from decimal import Decimal, ROUND_HALF_EVEN
import time


import boto3

dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('wordvice-posts')

def get_posts(**kwargs):
    posts = table.scan()
    return posts['Items']

def get_post(date, **kwargs):
    return None

def post_post(event, **kwargs):
    data = floats_to_decimals(event['body'])
    data['date'] = rounded_decimal(time.time())
    response = table.put_item(
        Item=data
    )

    return response

def floats_to_decimals(obj):
    if isinstance(obj, dict):
        return {k: floats_to_decimals(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [floats_to_decimals(i) for i in obj]
    elif isinstance(obj, float):
        return rounded_decimal(obj)
    else:
        return obj

def rounded_decimal(f):
    return Decimal(f).quantize(Decimal('.000001'), rounding=ROUND_HALF_EVEN)
