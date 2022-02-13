#ECS Service

This the folder for factorial application service in ECS.

After the docker image is pushed to ECR.

The task definition and ECS service was created for the docker image using this folder.

The application is running on port 5000. The same is mapped with the ALB which listenes on 80 and forward the request to this service