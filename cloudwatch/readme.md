**#create cloudwatch log group**
>>aws logs create-log-group --log-group-name '/syops/exam/cloudwatch'

**#Set retention period**
>>aws logs put-retention-policy --log-group-name '/syops/exam/cloudwatch' --retention-in-days 1

**#create a log stream with timestamo in unix format**
>>aws logs create-log-stream --log-group-name '/syops/exam/cloudwatch' --log-stream-name 
$(date +%s)

**#Send logs to cloudwatch log streams**
>>aws logs put-log-events --log-group-name  '/syops/exam/cloudwatch' --log-stream-name 1746727113 --log-events file://events

**#BashScript to send sample logs**:

**Configrued  cloudwatch agent on an ec2 instance to capture and write logs to  LogGroup - '/syops/exam/cloudwatch'**
Also configured collectd to capture and sent custom system specific metrics to cloudwatch Metrics.



**Simulate an Alarm safely without impacting any resources in the account** 

>>aws cloudwatch set-alarm-state --alarm-name "ALARM_NAME" --state-value ALARM --state-reason "For testing purposes"

**Created Cloudwatch Dashboards and added Metrics to it. We can set the refresh rate and type of graph to be monitored as well.**

**Cloudwath Logs - Live Tail is like tail command in Linux. It is used to track and see live logs which are being written to specific Log groups.**

**Cloudwatch Synthetics canary are configurable scripts that can be used to monitor the API's , URL, or Websites. Can be used to find issues before customers actually find them**




**Amazon EventBridge - Consists of Event Buses and Rules. Almost all the events which occur inside an aws account is put into the "Default" Event Bus, which then can be filtered and trigger specific action based on it. The action can be sending a trigger to an SNS topic, Actions on an Ec2 instance**


**CloudTrail**

**Service Quotas**

**AWS Config** **AWS Config aggregator**



















