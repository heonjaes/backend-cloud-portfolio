# AWS Cloud Resume Challenge - Backend with Terraform

![Alt text](<images/infra_diagram.png>)

## Project Description

The AWS Cloud Resume Challenge with Terraform showcases expertise in infrastructure as code (IAC), AWS cloud services, and Terraform. This challenge involves building an automated cloud-native resume website hosted on AWS, featuring dynamic elements such as visitor tracking and integration with various AWS services. It also incorporates CI/CD to automate the testing and deployment of cloud infrastructure. This challenge is inspired by Forrest Brazzeal https://cloudresumechallenge.dev/docs/the-challenge/aws/.


## Key Features
- **Infrastructure as Code (IaC)**
  - Terraform: Manages AWS resources efficiently with Terraform, enabling infrastructure definition and versioning as code.
  - Remote S3 State File to track and automate deployment

- **Serverless Visitor Counter**
  - AWS Lambda: Implements a serverless visitor counter using AWS Lambda for serverless computing.
  - Amazon DynamoDB: Uses Amazon DynamoDB for serverless visit count
  - API Gateway: Integrates with API Gateway to invoke a Lambda function for retrieving and updating visitor counts in DynamoDB.

- **Website Hosting**
  - Amazon S3: Utilizes Amazon S3 for static content storage, ensuring scalability and high availability.
  - Amazon CloudFront: Leverages Amazon CloudFront as a content delivery network (CDN) to offer globally low-latency, high-performance website access.
  - Amazon Route 53: Configures Amazon Route 53 to associate a custom domain name (resume.heonjaeshin.com) with the CloudFront distribution.
  - AWS Certificate Manager (ACM): Provides SSL/TLS certificates for secure connections.

- **Secure Access**
  - AWS IAM (Identity and Access Management): Enforces secure AWS access and permissions through IAM roles and policies.

- **CI/CD Integration**
  - GitHub Actions: Establishes CI/CD pipelines using GitHub Action
  - Automated testing of lambda function using pytest
  - Automated deployment of AWS infrastructure


## Prerequisites

Prior to initiating the project, ensure these prerequisites are met:
- **Environmental Variables Setup for AWS IAM Access**: Set up local CLI with environmental variables for AWS IAM user and cloudfront details:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
  - CLOUDFRONT_CERTIFICATE_ARN

- **Terraform Installation**: Install Terraform on your local machine for defining and provisioning AWS infrastructure.

- **AWS Services Knowledge**: Understand AWS services such as Amazon S3, Amazon CloudFront, AWS Lambda, DynamoDB, Amazon Route 53, and AWS IAM.

- **Git for Version Control**: Use Git for version control and project collaboration.

- **GitHub Account**: Have a GitHub account for hosting your project's repository.

- **Code Editor or IDE**: Use a code editor or integrated development environment (IDE) for code writing and editing.

- **IAC Understanding**: Grasp the concept of Infrastructure as Code (IAC) for Terraform usage.

## Installation

Before you begin, ensure that you have the following software requirements installed:

- [Terraform](https://www.terraform.io/downloads.html) (v0.15.0)
- [AWS CLI](https://aws.amazon.com/cli/) (v2.0.0 or higher)
- [Python](https://www.python.org/downloads/release/python-390/) (v3.9.17)
- Python Libraries:
  - [pytest](https://pypi.org/project/pytest/)
  - [boto3](https://pypi.org/project/boto3/)
  - [json](https://pypi.org/project/jsonlib/)


## Setup

Follow these steps to set up and run the project:

1. Clone the Repository

   ```bash
   git clone https://github.com/heonjaes/backend-cloud-portfolio.git
   cd backend-cloud-portfolio
   ```

2. Set Up AWS Credentials

   ```bash
   export AWS_ACCESS_KEY_ID=[YOUR_AWS_ACCESS_KEY]
   export AWS_SECRET_ACCESS_KEY=[YOUR_AWS_SECRET_KEY]
   export CLOUDFRONT_CERTIFICATE_ARN=[ARN_OF_YOUR_ACM_CERTIFICATE]
   ```

Certainly! Here are the additional steps to set up a remote state file with an S3 bucket and add it to the Terraform code, followed by pushing the code:

3. Set Up Terraform Remote State with S3 Bucket

   Create an S3 bucket to store your Terraform state file remotely. Replace `[YOUR_UNIQUE_BUCKET_NAME]` with a globally unique bucket name:

   ```bash
   aws s3api create-bucket --bucket [YOUR_UNIQUE_BUCKET_NAME] --region [YOUR_AWS_REGION]
   ```

   Next, configure your Terraform backend to use the S3 bucket for remote state storage. Create a `backend.tf` file in your Terraform project directory and add the following content, replacing `[YOUR_UNIQUE_BUCKET_NAME]` and `[YOUR_AWS_REGION]` with your S3 bucket name and AWS region:

   ```hcl
   terraform {
     backend "s3" {
       bucket         = "[YOUR_UNIQUE_BUCKET_NAME]"
       key            = "terraform.tfstate"
       region         = "[YOUR_AWS_REGION]"
     }
   }
   ```

4. Push Your Terraform Code to Version Control

   Now, fill out all the relevant variable names in the terraform files. Commit your changes to your local Git repository and push them to your remote repository (e.g., GitHub) to keep your Terraform code under version control. Follow these commands:

   ```bash
   git add .
   git commit -m "Add Terraform backend configuration for remote state"
   git push origin main  # Replace 'main' with your branch name if it's different
   ```

   This will update your remote repository with the latest changes, including the Terraform backend configuration.

## Contact

For inquiries or feedback, reach out through the following channels:

- Email: heonjae.shin00@mail.com
- Linkedin: https://www.linkedin.com/in/heonjae-shin-933a4a208/
- GitHub: [Your GitHub Profile](https://github.com/heonjaes)

## Acknowledgments
We extend our thanks to the open-source community and AWS for providing the tools and resources that made this project possible.

