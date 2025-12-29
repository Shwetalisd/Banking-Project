banking-eks-poc/
│
├── terraform/                 # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
│
├── app/                       # Banking Application
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── k8s/                       # Kubernetes manifests (GitOps)
│   ├── deployment.yaml
│   ├── service.yaml
│   └── namespace.yaml
│
├── argo/                      # Argo CD application manifest
│   └── argo-app.yaml
│
├── Jenkinsfile                # Jenkins CI/CD pipeline
│
└── README.md
 ----------------- Prerequisites
 AWS Account
IAM User with:
EC2,VPC,ECR,IAM
Key Pair

EC2 or local machine with:
kubectl
eksctl
terraform
docker

AWS CLI configured

Terraform-based EKS (for production-style POC)
terraform/main.tf
terraform init
terraform apply
✔ Creates 1 Master + 2 Worker nodes

5️⃣ Step 2: Create Banking Application
Simple Flask app simulating banking microservice:

Step 3: Push Docker Image to AWS ECR
aws ecr create-repository --repository-name banking-app

aws ecr get-login-password | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com

docker build -t banking-app .
docker tag banking-app:latest <ECR_URL>/banking-app:1.0
docker push <ECR_URL>/banking-app:1.0

Step 4: Kubernetes Manifests (GitOps Repo)
deployment.yaml
service.yaml

Step 5: Install Argo CD on EKS
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Port-forward Argo CD UI:
kubectl port-forward svc/argocd-server -n argocd 8080:443

Get initial password:
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

Step 6: Create Argo CD Application
argo-app.yaml:
kubectl apply -f argo-app.yaml
Argo CD will automatically deploy the banking app to EKS.

Step 7: Verify Deployment
kubectl get pods -n banking
kubectl get svc -n banking
Access application via LoadBalancer URL.

step 8---Autoscaling
Pod Auto Scaling:
kubectl autoscale deployment banking-app --cpu-percent=50 --min=2 --max=10

Node Auto Scaling:
Managed Node Group auto-scales automatically based on cluster load.

Step 9: CI Pipeline (Jenkins)
Jenkinsfile example:
Argo CD will pick up changes automatically.



