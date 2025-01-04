# CircleCI Pipeline for Weather Web Application

This repository contains a **CircleCI pipeline** designed to automate the build, test, and deployment process for a cloud-native weather web application. The pipeline ensures seamless integration and delivery of both the application and its infrastructure on AWS.

### **Goal & Tools Used**
The primary objective of this pipeline is to automate the software lifecycle—from code commit to deployment—while ensuring scalability, security, and reliability. The pipeline incorporates industry-standard tools and practices, making it suitable for DevOps environments.

- **CI/CD Platform**: CircleCI
- **Containerization**: Docker, GitHub Container Registry (GHCR)
- **Infrastructure as Code (IaC)**: Terraform
- **Cloud Platform**: AWS (EKS, EC2, S3)
- **Orchestration**: Kubernetes
- **GitOps**: ArgoCD
- **Security & Compliance**: Checkov
- **Monitoring & Alerts**: Slack notifications

## **Pipeline Overview**

### **1. Build, Test, and Publish Job**
This job handles the core CI/CD steps:
- **Docker Image Build**: Builds the web application’s Docker image.
- **Container Testing**: Runs the container and performs HTTP status checks to ensure the application responds as expected.
- **Result Storage**: Stores test results.
- **Slack Notification**: Sends a custom notification to a Slack channel with the test results.
- **Image Publishing**: Pushes the built Docker image to GitHub Container Registry (GHCR).

### **2. Security and Compliance Check (Checkov Job)**
- Installs and runs **Checkov** to scan the Terraform code for potential security issues.

### **3. Infrastructure Testing (Terratest Job)**
- Uses **Terratest** with Go to validate the Terraform code by provisioning test infrastructure and running automated tests.

### **4. EKS Cluster Deployment (eks_cluster Job)**
- Provisions the Kubernetes cluster using Terraform.

### **5. Application Deployment with ArgoCD (deploy_argocd Job)**
- Installs and configures **ArgoCD**.
- Creates a kubeconfig for the EKS cluster.
- Adds the Git repository to ArgoCD and creates a new application.
- Synchronizes and deploys the application to the EKS cluster.

## **Workflows**
The `webapp_weather` workflow orchestrates the execution of the jobs in the following order:

1. `build_test_publish`
2. `checkov`
3. `terratest` (requires `checkov` to pass)
4. `eks_cluster` (requires `terratest` to pass)
5. `deploy_argocd` (requires `eks_cluster` to pass)

## **Setup Instructions**
To use this pipeline, follow these steps:

1. **Fork and clone this repository**.
2. **Set up required CircleCI environment variables**:
   - `GITHUB_TOKEN`: Personal access token for GitHub.
   - `GITHUB_USERNAME`: GitHub username.
   - `AWS_ACCESS_KEY_ID`: AWS access key.
   - `AWS_SECRET_ACCESS_KEY`: AWS secret key.
   - `ARGOCD_USERNAME`: ArgoCD username.
3. **Configure the Slack orb**:
   - Ensure your Slack workspace is integrated with CircleCI and set the `slack-secrets` context with appropriate credentials.

## **Key Highlights**
- The pipeline ensures code quality through automated testing and security checks.
- It automates infrastructure provisioning and deployment using Terraform and ArgoCD.
- Notifications provide real-time feedback on the status of builds and deployments.

This setup is ideal for managing cloud-native applications with a focus on continuous integration, delivery, and GitOps-based deployment strategies.

