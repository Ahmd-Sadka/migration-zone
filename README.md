![Terraform](https://img.shields.io/badge/Terraform-v1.5.0-623CE4?logo=terraform&logoColor=white) ![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-enabled-blue)

A fully automated, Terraform-driven proof-of-concept landing zone for migrating on-premises infrastructure to AWS using only Free Tier–eligible resources. This project creates isolated staging (`pre-prod`) and production (`prod`) environments, each with its own VPC, compute layer, and centralized logging in production.

---

## 📖 Table of Contents

1. [Architecture](#architecture)  
2. [Project Structure](#project-structure)  
3. [Getting Started](#getting-started)  
   - [Prerequisites](#prerequisites)  
   - [Environment Setup](#environment-setup)  
   - [Deploying Environments](#deploying-environments)  
4. [CI/CD Pipeline](#ci-cd-pipeline)  
5. [Terraform Fundamentals](#terraform-fundamentals)  
6. [Screenshots & Validation](#screenshots--validation)  
7. [Clean Up](#clean-up)  
8. [Contributing](#contributing)  
9. [License](#license)  

---

## 🏗️ Architecture

```mermaid
graph LR
  A[GitHub Repo] -- push to pre-prod --> B[GitHub Actions: pre-prod job]
  B --> C[Terraform Init/Plan/Apply]
  C --> D[AWS Pre-Prod VPC + EC2]
  A -- merge to prod --> E[GitHub Actions: prod job]
  E --> F[AWS Prod VPC + EC2 + Logging]
  F --> G[S3 Bucket & CloudWatch Logs]
Figure: High-level workflow and AWS landing zone layout.

🗂️ Project Structure
plaintext
Copy
Edit
.
├── modules/
│   ├── network/       # VPC, subnets, IGW, routing
│   ├── compute/       # EC2 instances & security groups
│   └── logging/       # S3 bucket, CloudWatch Log Group, VPC Flow Logs
├── envs/
│   ├── pre-prod/     # Staging environment folder & backend
│   └── prod/         # Production environment folder & backend
├── .github/
│   └── workflows/
│       └── terraform.yml  # CI/CD pipeline
└── README.md         # This documentation
🚀 Getting Started
Prerequisites
Terraform v1.5.0 or later

AWS CLI configured with an IAM user that has Terraform permissions

Git and a GitHub account with repository access

Environment Setup
Clone the repo:

bash
Copy
Edit
git clone <your-repo-url>.git
cd <repo-name>
Configure AWS credentials:

bash
Copy
Edit
aws configure
Initialize Terraform for staging:

bash
Copy
Edit
cd envs/pre-prod
terraform init -backend-config=backend.tf
Deploying Environments
Staging (pre-prod):

bash
Copy
Edit
git checkout pre-prod
cd envs/pre-prod
terraform init
terraform plan -out=plan.out
terraform apply plan.out
Production (prod):

bash
Copy
Edit
git checkout prod
cd envs/prod
terraform init
terraform plan -out=plan.out
terraform apply plan.out
🤖 CI/CD Pipeline
Trigger: Push to pre-prod or prod branches.

Jobs: Init, fmt & validate, plan, and auto-apply.

Location: .github/workflows/terraform.yml

Tip: A pull request from pre-prod to prod will show the Terraform plan in the PR comment for review before merging.

📚 Terraform Fundamentals
State: Stored remotely in S3 with DynamoDB locking.

Variables: .tfvars files per env to customize counts, CIDRs, names.

Modules: Reusable network, compute, and logging components.

Validation: Guardrails prevent enabling logging outside prod.

Mapping: Subnets & instances auto-distributed across AZs.

📸 Screenshots & Validation
After running each environment, capture and include in this section:

VPC Dashboard: Showing your poc-pre-prod-vpc and poc-prod-vpc.

Subnets & Route Tables: Confirm public subnets and IGW attachments.

EC2 Instances: Instances in each environment with public IPs.

Logging (Prod only): S3 Bucket versioning screen & CloudWatch Log Group with sample flow logs.

Attach images like:

markdown
Copy
Edit
![Pre-Prod VPC](./screenshots/pre-prod-vpc.png)
![Prod Logging](./screenshots/prod-logging.png)
🧹 Clean Up
To destroy resources when done:

bash
Copy
Edit
cd envs/prod
terraform destroy -auto-approve
cd ../pre-prod
terraform destroy -auto-approve
🤝 Contributing
Feel free to open issues or PRs to improve modules, add security checks, or optimize costs.

📄 License
This project is licensed under the MIT License. See LICENSE for details.