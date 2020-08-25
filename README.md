# VulnerableAzure
Terraform playbook of a vulnerable Azure deployment

Written by Michael Braun

<p align="left">
    <img src="https://img.shields.io/badge/Version-1.0.0-red" />
</p>    


The purpose of this project is to build an intentionally vulnerable environment for me to experiement with. I see this as having two main purposes. <br>

1. Test offensive principles and tools against vulnerable Azure infrastructure

2. Test defensive tools to evaluate their capabilities in the Cloud and the CI/CD pipeline.

This is a first version, as it was also a way for me to learn about Azure, Terraform and Github Actions. 

Here is crude diagram of what this playbook will build:

![](images/diagram.png)

All services are open and accessible to the internet.

<b> DO NOT DEPLOY THIS IN A PRODUCTION ENVIRONMENT </b>

## Prerequisites

[Github Account](https://github.com) <br>
[Azure Account](https://portal.azure.com) <br>
[Terraform Cloud Account](https://terraform.io) <br>

This writeup assumes that you have basic working knowledge of all of these services. 

## Setup 

Fork the [VulnerableAzure](https://github.com/metalstormbass/VulnerableAzure) repository into your personal Github account. 
<br>

### Microsoft Azure
 Create an App Registration in Azure. As this will be used multiple times, please note the following:

- Application (client) ID
- Directory (tenant) ID
- Secret
- Subscription ID

Ensure that you give this app registration "Contributor" permission. This is required for Terraform to build the environment.

### Terraform
Create a new workspace in your Orginization and select CLI-driven run. The configure your variables.

![](images/terraform1.png)

Start with the Environment Variables. Input the Azure App Registration information you noted earlier. Use the following keys.

![](/images/terraform2.PNG)

Then fill in the variables required to run the Terraform playbook. Reuse the Azure App Registration client id and secret for the client_id and the client_secret variables.

![](/images/terraform3.PNG)

Under the user settings, select Tokens and create an API token. Note the value for later. 

### Github 

Select settings and add the following secrets to your repository:

![](/images/github1.PNG)

Click on actions and enable workflows



