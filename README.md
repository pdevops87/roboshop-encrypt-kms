# roboshop-encrypt-kms


[ User types: http://pdevops87.online ]
│
▼
[ AWS Load Balancer (Passes plain HTTP through Port 80) ]
│
▼
[ NGINX Ingress Controller ] ◄─── Reads: "ssl-redirect: true"
│
└─► (Sends a redirect command back to user's browser)
│
[ User's browser automatically upgrades to: https://... ]
│
▼
[ AWS Load Balancer ]        ◄─── Reads your ACM Certificate & Decrypts traffic safely!
│
▼
[ Argo CD Pod (HTTP) ]       ◄─── Receives clean traffic




kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx
