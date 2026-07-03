# resource "helm_release" "nginx-ingress" {
#   depends_on = [null_resource.kube-config]
#   name       = "external-dns"
#   repository = "https://kubernetes-sigs.github.io/external-dns"
#   chart      = "external-dns"
# }


#  external-dns will deploy as a pod
#  so here external-dns cannot communicate directly to the route53
#  so create an add-on eks pod identity

# create eks pod identity
resource "aws_eks_addon" "pod-identity" {
  cluster_name = aws_eks_cluster.cluster.name
  addon_name   = "eks-pod-identity-agent"
}
# create external dns
resource "aws_eks_addon" "external-dns" {
  cluster_name = aws_eks_cluster.cluster.name
  addon_name   = "external-dns"
}

# here need to check aws addon name
# aws eks describe-addon-configuration --cluster-name [ check addon-name]

# step2: we need a role for each pod to communicate to pod identity
# Pods are created under nodes(nodes are in ec2)
#  create a role------> POD can use but which pod (we don't know)


resource "aws_iam_role" "external-dns-role" {
  assume_role_policy = data.aws_iam_policy_document.pod_identity_assume_role.json
}
resource "aws_iam_role" "external-dns" {
  name               = "external-dns-inline-policy"
  assume_role_policy = data.aws_iam_policy_document.pod_identity_assume_role.json

  inline_policy {
    name = "external-dns-inline-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["route53:*"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}


  resource "aws_iam_role" "addon-role" {
  name = "${var.env}-pod-role"
  assume_role_policy = data.aws_iam_policy_document.pod_identity_assume_role.json
}
resource "aws_iam_role_policy_attachment" "policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.addon-role.name
}

# step3: service account is an identity
# link service account and iam role
# associate pod identity

# create eks pod identity
resource "aws_eks_pod_identity_association" "pod-identity" {
  cluster_name    = aws_eks_cluster.cluster.name
  namespace       = "default"
  service_account = "default"
  role_arn        = aws_iam_role.addon-role.arn
}

resource "aws_eks_pod_identity_association" "eks-pod-identity" {
  cluster_name    = aws_eks_cluster.cluster.name
  namespace       = "external-dns"
  service_account = "external-dns"
  role_arn        = aws_iam_role.addon-role.arn
}

# service account links to iam role to connect to pods
# pod identity agent watches service account and get credentials
# here pod identity communicates to external dns


# step4:
# external dns communicate to aws service route53
#  here iam role is required to communicate to route53


# creating a role is nothing but IRSA means IAM role for service account
# step5:
# create a role for external dns and policy to communicate to Route53









