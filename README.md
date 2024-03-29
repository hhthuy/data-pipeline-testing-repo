<h1 align="center">Data Testing - Data Pipeline foundation</h1>

</p>

<p align="center">
Data testing with AWS CodeBuild, through buildspec.yml, automates application builds and deployments within a CI/CD pipeline, similar to Terraform's infrastructure automation. Data quality remains crucial, demanding accuracy, completeness, consistency, uniqueness, and timeliness. Techniques like data validation (range checks, cross checks, structure checks) ensure this quality.
</p>
  🔖🏷️📜📃🛠 💻 💾💡📕📗📙📓📩📝📅📂🗂️📈📈🔒🚀 ⚡️🔥❇️📌💢💫👉👈👇👆✍️🎯

## Table of contents
- [Prerequisites](#pre)
  - [Git](#git)
  - [AWS Account](#aws)
  - [Snowflake](#snowflake)
  - [VSCode](#browser)
  - [Git Grap Extention](#gitgrap)
- [Setup](#setup)
  - [AWS Codebuild: Define buildspec .yml](#1)
  - [CICD: Terraform](#2)
  - [Data quality: accuracy, completeness, consistency, uniqueness, and timeliness](#3)
  - [Techniques for assessing data quality](#4)
  - [Data validation: range check, cross check, structure check...](#5)
- [Reference](#ref)
  - [AWS Code build](https://docs.aws.amazon.com/codebuild/latest/userguide/welcome.html)
  - [Terraform: aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
  - [Terraform:aws_codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) 

 


# [AWS Codebuild: Define buildspec .yml](#1)
### GitHub Actions to automate infrastructure on  AWS with Terraform
<img src="image\workflow_GitHubActions_AWS_Terraform.png" alt="alt text" width="650"/>

⚡️**GitHub Actions automates AWS infrastructure and application deployment via Terraform:**
> 1. **User triggers**: create a `pull request` or `push` code to the master branch in a GitHub repo.
> 2. **GitHub Actions triggers Runner**: Executes workflows in a virtual environment.
> 3. **Authentication with AWS** using `OIDC` and `IAM roles`. 
>    - `OpenID Connect (OIDC):` allows secure communication between GitHub Actions and AWS.
>    - `IAM roles`: grant temporary permissions to interact with AWS resources
> 2. **Triggers Terraform by GitHub Actions**  Runs Terraform code defined in a `.yml` file
>    - `Terraform`: An IaC tool for managing cloud resources.
> 5. **Terraform Plan and Apply:** Once Terraform is authenticated, it uses the provided code to create or update infrastructure in AWS. 
>    - `Plan` generates an execution plan for creating or modifying resources.
>    - `Apply` executes the plan and stores the infrastructure state.
> 6. **Store State (S3 Bucket):** Deploys the application or its resources to an S3 bucket.  
>    - `S3`: Object storage for various data and file types.

### Prepare Test Enviroment - AWS Codebuild
#### 📌 HW: GitHub Action successful: 5/5 tests passed, deployed to S3 bucket on AWS.
#### 🔥Steps:
> 1. Create a GitHub Repository
> 2. Create `dev` branch: `git checkout -b dev`
> 3. Create AWS Secret Key to get credential that allow deployment
>   - Creat `secret key` (AWS): AWS > Profile > Security Credentials > Create Access key > Download the access key ID and secret access key for this user securely
>   - _Once you close the screen that shows your `Access Key ID` and `Secret Access Key`, you will not be able to retrieve the `Secret access key` value again. The solution is to _delete the old credentials_, _generate new ones_ and *save the .csv file on your local file system*_.  (_Region=us-east-1_)
>   - **Crucially**: Don't store your AWS credentials directly in your code or configuration files. Use AWS Secrets Manager to create a secret that securely stores your AWS access key and secret key.
>     - <img src="image\AWS_creatSecretKey.png" alt="alt text" width="650"/>
>
> 4. Configure Secret Key for Deployment (Recommended - Environment Variables)
>   - If you plan to automate deployments using GitHub Actions, you can create secrets in your GitHub repository settings:
>     - Go to your repository's Settings > Secrets.
>     - Create secrets named `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`,`AWS_REGION` storing the respective values from step 3.
>     - <img src="image\GitHub_configSecretKey.png" alt="alt text" width="650"/>
> - **Alternatively**: You can store the credentials in environment variables managed by your CI/CD platform (e.g., AWS CodePipeline, CircleCI, etc.).
> 5. Clone code 
> - `terraform/main.tf`: contains Terraform code for creating and managing your infrastructure
> - `terraform/s3.tf`  (assumed):  contain Terraform code that directly references a hardcoded bucket name.
> 6. Push code and deploy on `dev` branch
> 7. Verify CICD on GitHub
 
### Data pipeline testing workflow using AWS services
> <img src="image\workflow_DataPipelineAWS.png" alt="alt text" width="850"/>

⚡️**4-Stage Automated Testing Pipeline for Cloud Data Processing:**
> 1. **Trigger**: Schedule (hourly/weekly) or Github code changes.
>       - _CloudWatch Event_ (AWS service): schedules events or reacts to changes in other AWS services to trigger.
> 3. **Test**: Health, Integration, Smoke (basic functionality), and custom scenarios (data access, verification).
>       - **Health Check**: Verifies resources like CodeBuild are working. 
>            - _CodeBuild (AWS service): builds, tests, and deploys code. Runs the health check test scenarios using pytest._ 
>       - **Integration Testing**:  Validates data flow between components (data source -> data warehouse).
>       - **Smoke Testing**: Quick check for overall pipeline execution.
>       - **Test Scenarios**: Specific tests for your data pipeline (data lake queries, data warehouse queries, data verification).
>            - Test Scenario 1: Verify all pipeline components (like CodeBuild in Snowpipe) are functioning properly.
>            - Test Scenario 2: Validates queries used to extract data from the `data lake`.
>            - Test Scenario 3: Validates queries used to extract data from the `data warehouse`.
>            - Test Scenario 4: Verify the data itself is accurate and meets quality standards.
> 4. **Report Flow**: Stores results and sends notifications to `Slack`.
> 5. **Monitoring**: Monitors the pipeline  and sent alert if issues arise.
# [CICD: Terraform](#2)
## Terraform config
This block defines settings specific to your Terraform configuration.
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }

  backend "s3" {
    bucket = "thuy-s3bucket-terraform-maunal"
    key    = "terraform/tf.state"
    region  = "us-east-1"
  }
}

provider "aws" {}
```
  > **1. Required Providers**
  > - Terraform needs the aws provider (from HashiCorp) to interact with AWS services.
  > - You've specified the official HashiCorp AWS provider (version 5.17.0).
  > - Keeping providers up-to-date is recommended, but fixing the version can ensure consistency.
  >
  > **2. Remote State Storage (S3):**
  > - Terraform stores its state (`tf.state`) file in an S3 bucket for remote access.
  > - The bucket (`thuy-s3bucket-terraform-manual`) needs to be created manually in AWS.
  > - The state file is stored within a `terraform` folder inside the bucket.
  >
  > **3. Empty AWS Provider Block:**
  > - This block defines how to interact with AWS services.
  > - Since `aws` is already declared as a required provider, this block is a placeholder and doesn't need further configuration in this case.
## Terraform code 
**1. Creating the S3 Bucket:**
```Terraform
resource "aws_s3_bucket" "example" {
  bucket = "thuy-s3bucket-aws"
  tags = {
    Name    = "My bucket"
    Environment = "Dev"
  }
}
```
  > - This block creates an S3 bucket named `thuy-s3bucket-aws` in your AWS account.
  > - It adds two tags for organization:
  >   - `Name = "My bucket"`: A human-readable name for easy identification.
  >   - `Environment = "Dev"`: Indicates the purpose (dev) of the bucket.
**2. Configuring Bucket Ownership Controls:**
```Terraform
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
```
  > - This block establishes ownership controls for the bucket:
  >   -  `bucket`: It links to the previously created bucket (`aws_s3_bucket.example.id`).
  >   -  `rule`: Sets a rule for object ownership:
  >   -  `object_ownership = "BucketOwnerPreferred"`: New objects uploaded with the "bucket-owner-full-control" canned ACL will automatically assume bucket owner ownership

**3. Setting Access Control List (ACL):**
```Terraform
resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}
```
  > - This blocks applies an ACL to the bucket:
  >   - `depends_on`: Ensures the ownership controls are applied before the ACL.
  >   - `bucket`: Again references the created bucket.
  >   - `acl = "private"`: Sets the ACL to private, restricting access to only the bucket owner.
# [Data quality: accuracy, completeness, consistency, uniqueness, and timeliness](#3)
**
# [Data validation: range check, cross check, structure check...](#5)
**
