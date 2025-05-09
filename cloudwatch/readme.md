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

Configrued a cloudwatch agent to capture and write logs to '/syops/exam/cloudwatch'









