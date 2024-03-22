<h1 align="center">Data Testing - Data Pipeline foundation</h1>

</p>

<p align="center">
Data testing with AWS CodeBuild, through buildspec.yml, automates application builds and deployments within a CI/CD pipeline, similar to Terraform's infrastructure automation. Data quality remains crucial, demanding accuracy, completeness, consistency, uniqueness, and timeliness. Techniques like data validation (range checks, cross checks, structure checks) ensure this quality.
</p>
  🛠 💻 🚀 ⚡️🔥❇️📌

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
> 2. Create `dev` branch
> 3. Create `secret key` on AWS to get credential that allow deployment
> 4. Configure `secret key` to prepare for deployment
> 5. Clone code
> 6. Push code and deploy on `dev` branch
> 7. Verify CICD on GitHub
> #### Creat secret key (AWS)
> AWS > Profile > Security Credentials > Create Access key
> _Once you close the screen that shows your `Access Key ID` and `Secret Access Key`, you will not be able to retrieve the `Secret access key` value again. The solution is to _delete the old credentials_, _generate new ones_ and *save the .csv file on your local file system*.
> <img src="image\AWS_creatSecretKey.png" alt="alt text" width="650"/>
>
> _Region=us-east-1_
>
> ### Configure secret key (GitHub)
> <img src="image\GitHub_configSecretKey.png" alt="alt text" width="650"/>
> 
### Data pipeline testing workflow using AWS services
> <img src="image\workflow_DataPipelineAWS.png" alt="alt text" width="650"/>

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
**
# [Data quality: accuracy, completeness, consistency, uniqueness, and timeliness](#3)
**
# [Data validation: range check, cross check, structure check...](#5)
**
