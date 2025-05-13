#!/bin/bash

set -e

REGION="us-east-1"
TOPIC_NAME="ConsoleLoginTopic"
RULE_NAME="ConsoleLoginRule"

echo "Creating SNS topic..."
TOPIC_ARN=$(aws sns create-topic --name "$TOPIC_NAME" --region "$REGION" --query 'TopicArn' --output text)
echo "SNS topic ARN: $TOPIC_ARN"

echo "Creating EventBridge rule..."
aws events put-rule \
  --name "$RULE_NAME" \
  --event-pattern '{
    "source": ["aws.signin"],
    "detail-type": ["AWS Console Sign In via CloudTrail"],
    "detail": {
      "eventName": ["ConsoleLogin"]
    }
  }' \
  --region "$REGION" \
  --state ENABLED

echo "Adding SNS topic as target..."
aws events put-targets \
  --rule "$RULE_NAME" \
  --region "$REGION" \
  --targets "Id"="1","Arn"="$TOPIC_ARN"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

echo "Granting permission for EventBridge to publish to SNS topic..."
aws sns add-permission \
  --topic-arn "$TOPIC_ARN" \
  --label "GiveAccesstoEventBridge" \
  --aws-account-id "$ACCOUNT_ID" \
  --action-name "Publish" \
  --principal events.amazonaws.com

echo "EventBridge rule and SNS target set up successfully."
