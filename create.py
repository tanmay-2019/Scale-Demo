import boto3
s3_client = boto3.client("s3")
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('tt-demo')
def lambda_handler(event, context) :
	bucket_name = event ['Records'][0]['s3']['bucket']['name']
	s3_file_name = event ['Records'][0]['s3']['object']['key']
	resp = s3_client.get_object(Bucket=bucket_name, Key=s3_file_name)
	data = resp['Body'].read().decode("utf-8")
	employees = data.split("\n")
	for emp in employees:
		print(st)
		stud = st.split(",")
		try:
			table.put_item(
			Item = {
				"id" : stud[0],
				"name" : stud[1],
				"location" : stud[2]
			}
			)
		except Exception as e :
			print("End of file")
			
