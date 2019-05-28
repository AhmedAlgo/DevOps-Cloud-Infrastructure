## Overview 
In our class, we discussed how IT professionals now design and provision infrastructure using code — a concept known as Infrastructure as Code. The AWS CloudFormation service allows you to define cloud infrastructure using JSON template files. These template files create resource stacks in AWS.

In this week’s assignment, you will use AWS CloudFormation to create a basic stack. Your stack will expand the stack design that was created during the hands-on portion of the class. You will learn how code can simplify and ensure the repeatability of infrastructure deployments. 

Some students feel that it takes more effort to create infrastructure using code versus manually creating infrastructure using a web console. That’s probably true initially, especially when you are less familiar with infrastructure as code techniques. However, once you become experienced in building infrastructure using code you will find that it’s faster and more reliable than a manual process. 

When you build infrastructure manually you have to spend time documenting the infrastructure that you built, and this documentation needs to be maintained over time. Infrastructure as code is self-documenting and doesn’t require this extra step. Once you spend the time writing code to build out an infrastructure environment, you can share it with others and generate copies of the environment within minutes. 

## Download CloudFormation template 
This week’s assignment isn’t as prescriptive as some of the previous assignments and you will need to experiment with CloudFormation template code to build the required solution.

Build a new CloudFormation stack template called corpweb.json for the development team. The stack must have two Amazon Linux EC2 instances located behind an Application ELB. The load balancer must handle incoming requests on port 80 and send those to the EC2 instances on port 80. Additionally, the two instances need to be members of a security group which allows incoming traffic on ports 22 and 80. 

The engineering manager would like users to be able to provide three input parameters when launching the stack:

- A parameter called InstanceType that defines the instance type for the instances. 
- The allowable type must be one of the following: t2.micro or t2.small
- A parameter called KeyPair that specifies the server key-pair name for the EC2 instances.
- A parameter called YourIp that specifies your public IP address in CIDR notation. 

Also, create an output called WebUrl that displays the load balancer dns name after the stack is launched. 

The stack template should create the following logical resources: 
A VPC called: EngineeringVpc 
- The VPC CIDR block should be: 10.0.0.0/18
- The VPC should have two subnets called: PublicSubnet1 and PublicSubnet2.
- publicSubnet1 has a CIDR block of 10.0.0.0/24
- publicSubnet2 has a CIDR block of 10.0.1.0/24 o The subnets should be able to route data out to the Internet.

Two EC2 instances with logical resource names of web1 and web2 with associated Name tags.
- web1 is located in the publicSubnet1 subnet.
- web2 is located in the publicSubnet2 subnet. 
- Each instance type is based on the InstanceType input parameter. 
- The instance AMIs should use this public image (community ami): ami-3ea13f29
- The instance key-pairs are based on the KeyPair parameter.

A security group with a logical name and group name of WebserversSG in the VPC.
- Allow incoming requests on port 22 from your workstation (based on the YourIp parameter) 
- Allow incoming requests on port 80 from 0.0.0.0/0

An application load balancer named EngineeringLB and target group named EngineeringWebservers 
- Load balance incoming requests on port 80 and send to instance port 80 using the http protocol.
- Load balancer health check via http on port 80 to the "/" url location. 

Note: The names of the resources you configure in your stack template must exactly match the values above. The names are case-sensitive, so a resource with the name of "web1" is not the same as "Web1". You will lose points on this assignment if your resource names do not match the expected names. You should always double-check your work.

## Launch the stack 
Once you have created and validated your template, save it to your local file system. Next launch your new stack, called WebserversDev, in us-east-1 and provide the proper input parameters. Watch as AWS CloudFormation goes through the build process and creates the resources defined in the template. It will take a few minutes for CloudFormation to build the stack resources.

It’s likely that your stack launch will fail to complete the first time you try to launch the stack. Take a look at the events associated with the stack to try to determine which resource CloudFormation failed to create properly. You will see an error message describing why the resource failed. Oftentimes a resource will not get built because the one of the resource properties is missing or is incorrect. Try to fix the error in the template and launch the stack again. 

When you see that the stack launch completed and the EC2 instances are running, go ahead and terminal into one of the instances to confirm that you can access the server. Next, look at the output value from the CloudFormation stack to determine the DNS address for the load balancer that was created. Enter this DNS address into your web browser to confirm that it is distributing requests across the instances properly.

## Check your work 
Here is what the contents of your git repository should look like before final submission:

┣ corpweb.json 
