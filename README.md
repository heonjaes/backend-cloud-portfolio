# AWS Cloud Resume Challenge - Backend with Terraform

![Alt text](<images/infra_diagram.png>)

## Project Description

The AWS Cloud Resume Challenge with Terraform showcases expertise in infrastructure as code (IAC), AWS cloud services, and Terraform. This challenge involves building an automated cloud-native resume website hosted on AWS, featuring dynamic elements such as visitor tracking and integration with various AWS services.


## Key Features

- **Website Hosting**
  - Amazon S3: Utilizes Amazon S3 for static content storage, ensuring scalability and high availability.
  - Amazon CloudFront: Leverages Amazon CloudFront as a content delivery network (CDN) to offer globally low-latency, high-performance website access.
  - Amazon Route 53: Configures Amazon Route 53 to associate a custom domain name (resume.heonjaeshin.com) with the CloudFront distribution.
  - AWS Certificate Manager (ACM): Provides SSL/TLS certificates for secure connections.

- **Serverless Visitor Counter**
  - AWS Lambda: Implements a serverless visitor counter using AWS Lambda for serverless computing.
  - Amazon DynamoDB: Uses Amazon DynamoDB for serverless NoSQL database storage.
  
- **Infrastructure as Code**
  - Terraform: Manages AWS resources efficiently with Terraform, enabling infrastructure definition and versioning as code.
  
- **Secure Access**
  - AWS IAM (Identity and Access Management): Enforces secure AWS access and permissions through IAM roles and policies.

- **CI/CD Integration**
  - GitHub Actions: Establishes CI/CD pipelines using GitHub Action
  - Automated testing of lambda function using pytest
  - Automated deployment of AWS infrastructure


## Prerequisites

Prior to initiating the project, ensure these prerequisites are met:
- **Environmenta Variables Setup for AWS IAM Access**: Set up local CLI with environmental variables:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
  - CLOUDFRONT_CERTIFICATE_ARN

- **Terraform Installation**: Install Terraform on your local machine for defining and provisioning AWS infrastructure.

- **AWS Services Knowledge**: Understand AWS services such as Amazon S3, Amazon CloudFront, AWS Lambda, DynamoDB, Amazon Route 53, and AWS IAM.

- **Git for Version Control**: Use Git for version control and project collaboration.

- **GitHub Account**: Have a GitHub account for hosting your project's repository.

- **Code Editor or IDE**: Use a code editor or integrated development environment (IDE) for code writing and editing.

- **IAC Understanding**: Grasp the concept of Infrastructure as Code (IAC) for Terraform usage.

## Installation and Usage

For detailed installation and usage instructions, refer to the [Installation Guide](/docs/installation.md).

## License

This project operates under the MIT License. Review the [LICENSE](/LICENSE) file for specifics.

## Acknowledgments

Appreciation is extended to the open-source community and AWS for the resources that facilitated this project's creation.

## Contact

For inquiries or feedback, reach out through the following channels:

- Email: heonjae.shin00@mail.com
- Linkedin: https://www.linkedin.com/in/heonjae-shin-933a4a208/
- GitHub: [Your GitHub Profile](https://github.com/heonjaes)

