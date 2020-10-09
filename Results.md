# Overview

# Solution-1:
-  I had Cloned the Servian GitHub Repository to my personal repository and configured automated build in Docker Hub to build docker image.
-  I will be using the created Docker image to build a container in Azure Container Instance (ACI).
-  I have created Terraform Scripts to deploy Azure Resource Group and Azure Container Instance (ACI)

# Terraform Scripts Location: https://github.com/amansyed931/TechChallengeApp/tree/master/Terraform-Scripts/AzureContainerInstance
Result : I am able to access the Servian sample site.

# Solution-2:
Pre-requisite:
- Create Postgressql database in Azure
Steps:
- Create Shell script to extract the TechChallengeApp zip file.
- Created Terraform Scripts for deploying Azure Virtual network, Subnet, Public IP, NIC, Virtual machine.
- Environment is successfully deployed but unfornately site is not coming up.
# Terraform Scripts Location: https://github.com/amansyed931/TechChallengeApp/tree/master/Terraform-Scripts/IaaS-VM
Result: Partially successful.

# PreRequisites
  - Create a ServicePrincipal for terraform authentication with Azure.

# Build
- I had Integrated auto build in Docker Hub Account. Please access the below link for Docker File
URL: https://hub.docker.com/repository/docker/syeaman1693/servian-techchallenge

### Release
  - I had Triggered my Terraform scripts from Azure Cloud Shell. unfortunately couldn't work on Azure DevOps CI/CD pipeline for deploying the terraform scripts due to time constraint.

### Final Results

