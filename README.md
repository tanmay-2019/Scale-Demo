# Scale-Demo
lambda for DB(CRUD), Terraform for Infra


   
   PREREQUISITE :
Terraform installed in your local machine and connection to your AWS account using keys.
Run the "main.tf" file to create all the resources required for this use case.
Uploading the CSV file "tt-demo.csv" with the contents to S3 will add the items to DynamoDB table using the lambda function "create.py".
API gateway is created using the swagger file which will create the appropriate methods and resources.
Lambda function read.py will read the data based on the id from DynamoDB table,Lambda function update.py will update the data based on the id from DynamoDB table.
Lambda function delete.py will delete the data based on the id from DynamoDB table.
RDevent.json is the test event json for the lambda functions read.py and delete.py.
Uevent.json is the test event json for the lambda functions update.py.
authorizer.py will authorise the requests coming from API gateway using the username and password based on the checking the auth header. (API key will be created as part of terraform template)All the resources are created for testing and best naming convention should be "appname-environment-resourceName".
