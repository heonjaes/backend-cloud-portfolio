import boto3
import os

os.environ['AWS_DEFAULT_REGION'] = 'ap-southeast-2'
dynamodb = boto3.resource('dynamodb')
view_table = dynamodb.Table("resume-count-table")


def lambda_handler(event, context, table=view_table):

    response = table.get_item(Key={
        'ID':'0'
    })
    views = response['Item']['visit_count']
    views = views + 1
    response = table.put_item(Item={
            'ID':'0',
            'visit_count': views
    })

    return views