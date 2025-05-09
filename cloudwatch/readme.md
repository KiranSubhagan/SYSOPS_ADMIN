#create cloudwatch log group
aws logs create-log-group --log-group-name '/syops/exam/cloudwatch'

#Set retention period
~ $ aws logs put-retention-policy --log-group-name '/syops/exam/cloudwatch' --retention-in-days 1

#create a log stream with timestamo in unix format
~ $ aws logs create-log-stream --log-group-name '/syops/exam/cloudwatch' --log-stream-name 
$(date +%s)

#Send logs to cloudwatch log streams
aws logs put-log-events --log-group-name  '/syops/exam/cloudwatch' --log-stream-name 1746727113 --log-events file://events

**#BashScript to send sample logs**:


#!/bin/bash
_# ----- Configuration -----
 LOG_GROUP_NAME="/syops/exam/cloudwatch"
 LOG_STREAM_NAME="1746770093"
 LOG_MESSAGE="This is a test log from CLI at $(date).Mean while Akshaya lakshmi is sleeping soundly. The time now is $(date)"
 REGION="us-east-1"  # Update if needed

 # Get current timestamp in milliseconds
 TIMESTAMP=$(date +%s%3N)

# # ----- Get the current sequence token -----
 SEQUENCE_TOKEN=$(aws logs describe-log-streams \
   --log-group-name "$LOG_GROUP_NAME" \
     --log-stream-name-prefix "$LOG_STREAM_NAME" \
       --region "$REGION" \
         --query "logStreams[0].uploadSequenceToken" \
           --output text 2>/dev/null)
##
#          # Check for "None" or missing token (new stream)
           if [[ "$SEQUENCE_TOKEN" == "None" || -z "$SEQUENCE_TOKEN" ]]; _then
                aws logs put-log-events \
                 --log-group-name "$LOG_GROUP_NAME" \
                     --log-stream-name "$LOG_STREAM_NAME" \
                         --log-events timestamp=$TIMESTAMP,message="$LOG_MESSAGE" \
                             --region "$REGION"
            else
                 aws logs put-log-events \
                                   --log-group-name "$LOG_GROUP_NAME" \
                                       --log-stream-name "$LOG_STREAM_NAME" \
                                           --log-events timestamp=$TIMESTAMP,message="$LOG_MESSAGE" \
                                               --sequence-token "$SEQUENCE_TOKEN" \
                                                   --region "$REGION"**






