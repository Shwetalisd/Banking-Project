 Prerequisites
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

3️⃣ Step 1: Create Infrastructure using Terraform
terraform/main.tf
terraform init
terraform apply
✔ Creates 1 Master + 2 Worker nodes

Step 2: Install Kubernetes on EC2 (kubeadm)

On ALL Nodes
sudo apt update -----
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

On Master Node------
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config







