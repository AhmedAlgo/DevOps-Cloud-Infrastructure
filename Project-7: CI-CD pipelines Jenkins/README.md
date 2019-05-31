## Overview 
A DevOps code pipeline helps to automate continuous delivery processes for software development organizations. Developers, testers, and operations staff depend on functioning pipelines to transform code changes into deployable software releases. While software developers are the primary users of a pipeline, IT operations professionals oftentimes have to maintain it. 

This project builds a code deployment pipeline using Jenkins, a continuous integration tool. The pipeline will test, build, and deploy a very simple Java application. 

## Launch the Jenkins stack 
You will use a CloudFormation template to launch a stack containing a Jenkins server. The stack will create the following AWS resources: 
- An AWS Virtual Private Cloud (VPC), including all the necessary routing tables and routes, an Internet gateway, and security groups for EC2 instances to be launched into.
- An Amazon EC2 instance that hosts a Jenkins server, installed and configured for you with all the necessary plugins. 
- An IAM instance role which allows the Jenkins server to access the S3 bucket. 
- Launch the stack by clicking on the following URL and then clicking the Next link: 
[a link](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fcloudformation%2Fhome%3Fregion%3Dus-east-1%26state%3DhashArgs%2523%252Fstacks%252Fnew%253FstackName%253Djenkins-stack%2526templateURL%253Dhttps%253A%252F%252Fs3.amazonaws.com%252Fseis665%252Fjenkins-cf.json%26isauthcode%3Dtrue&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fcloudformation&forceMobileApp=0)

On the stack Specify Details page, enter the following: 
1. In Stack name, use jenkins as the name for the stack. 
2. In JenkinsPassword, provide an administrative password for this system (choose a hard password). 
3. In JenkinsUsername, you can leave this set to admin or choose a different admin username. 
4. In Key Name, choose the name of your Amazon EC2 key pair. 
5. In YourIP, type the public IP address (appending /32) of the computer system which you will access the resources created by this template.

On the Options page you can tag the resources created by the template. Feel free to create whatever tag you would like and click Next. 
On the Review page, select the I acknowledge that this template might cause AWS CloudFormation to create IAM resources check box. (It will.) Review the other settings, and then choose Create.

It will take several minutes for CloudFormation to create the resources on your behalf. You can watch the progress messages on the Events tab in the console. When the stack has been created, you will see a CREATE_COMPLETE message in the Status column of the console and on the Overview tab.

You will find the IP address of the Jenkins server in the stack outputs (select the stack name and look at the outputs tab). Access the Jenkins server with a web browser on port 8080:
```sh
http://<Jenkins IP address>:8080
```
## Setup GitHub integration 
Before you start working on a build pipeline, you should configure Jenkins to integrate with your GitHub account. This will allow Jenkins to automatically pull source code from your forked Java repository when the build pipeline runs. 

## Create a Pipeline 
You will create a new build pipeline using the Jenkins Pipeline DSL. Jenkins supports two different types of Pipeline DSL formats: declarative and scripted. We will use the declarative format for this assignment because it’s a little easier to work with.

Begin by creating a new pipeline project in Jenkins called java-pipeline. Configure the project to reference the Java GitHub repository you forked earlier in the assignment.

Setup a build trigger for this project using the GitHub hook trigger for GITScm polling configuration setting. The project should create a pipeline (Pipeline script from SCM) based on a file called Jenkinsfile located at the root (top) directory of the Java project. 

The project pipeline should include the following named stages (highlighted in bold): 

**Unit Tests** 
- The pipeline will initiate unit tests using ant and create a junit report.
- The shell command to run ant tests is ant -f test.xml -v
- The junit report source data is located in reports/result.xml

**Build** 
- The pipeline will compile the Java application using ant.
- The shell command to compile the application is ant -f build.xml -v

**Deploy**
- The pipeline will copy the build output jar file into an S3 bucket (use an existing S3 bucket or create a new one for this assignment).
- The name of the output jar file will look something like rectangle-2.jar, where the number represents the current Jenkins build number.
- You can use the AWS CLI to copy files from Jenkins to the S3 bucket. Don’t worry about access credentials for this step because the Jenkins server has a proper role attached which allows it to access the S3 bucket.

**Report**
- The pipeline will generate a report of the CloudFormation stack resources created in your environment using the command: aws cloudformation describestack-resources --region us-east-1 --stack-name jenkins
- Note: you will need to setup proper IAM and Jenkins access credentials to run this command.

## Check your work 
Here is what the contents of your git repository should look like before final submission: 

┣ Jenkinsfile 

┗ console.txt 

## Terminate application environment 
The last step in the assignment is to delete all the AWS resources created by the stack. You don’t want to keep this stack running for a long time because the costs will accumulate. Go to the CloudFormation dashboard, select your running stack, and choose the delete option. Watch as CloudFormation deletes all the resources previously created. 
