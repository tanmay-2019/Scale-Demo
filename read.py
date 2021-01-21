from pprint import pprint
import boto3
from botocore.exceptions import ClientError


def lambda_handler(event,context):
    dynamodb = boto3.resource('dynamodb')

    table = dynamodb.Table('tt-demo')

    try:
        response = table.get_item(Key={'id': event['id']})
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        return response['Item']