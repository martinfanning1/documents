#!/bin/bash

input=$1
failed=$2

dt=$(date '+%d/%m/%Y %H:%M:%S');
echo Onboarding started at $dt
SECONDS=0

while IFS=, read -r loginid secret tenantid tenantinstance usertype ipaddress
do

faildt=$(date '+%d/%m/%Y %H:%M:%S');

echo Activating $loginid with Secret Code: $secret as a $usertype on $ipaddress for Tenant $tenantid:$tenantinstance

result=`curl -k --tlsv1.2 -H Accept:application/json -H Content-Type:application/json -H Authorization -u routersysuser:Engage1! -H "X-WCM-EXTERNAL-USER:$loginid" -H "X-WCM-EXTERNAL-USER_TYPE:$usertype" -H "X-WCM-TENANT-ID:$tenantid" -H "X-WCM-TENANT-INSTANCE:$tenantinstance" -H "X-WCM-TRANSACTION-ID:d956293e-6120-4a81-8de5-39f1566c3f2b" -H "referer:curam://app" -v -s -X POST -d '{"'"verification"'":"'"$secret"'"}' -X POST https://$ipaddress:443/WCM-API-Gateway/registration/v1/ulm/user_verification`

#echo Output: $result

if grep -q identifier <<< $result;
then
 echo User $loginid was created successfully.
elif grep -q 400 <<< $result;
then
 echo User Registration Failed for: $loginid at $faildt. Reason: 400 Bad Request - The user is already Active.
elif grep -q 403 <<< $result;
then
 echo User Registration Failed for: $loginid at $faildt. Reason: 403 Forbidden - The request was incorrect or the onboarding request is not sent - Check the user and the curl command.
 echo $loginid,$secret,$tenantid,$tenantinstance,$usertype,$ipaddress >> $2
elif grep -q 500 <<< $result;
then
 echo User Registration Failed for: $loginid at $faildt. Reason: 500 Internal Server Error; echo $'' Error Trace: $result
 echo $loginid,$secret,$tenantid,$tenantinstance,$usertype,$ipaddress >> $2
elif grep -q 503 <<< $result;
then
 echo User Registration Failed for: $loginid at $faildt. Reason: 503 Service Unavailable - The service was unavailable.
 echo $loginid,$secret,$tenantid,$tenantinstance,$usertype,$ipaddress >> $2
else
 echo User Registration Failed for: $loginid at $faildt. Reason: Unknown Error - Check details are correct in the users file and Run the command manually to determine the issue.
 echo $loginid,$secret,$tenantid,$tenantinstance,$usertype,$ipaddress >> $2
fi

#sleep 3
echo $''
echo $''

done < "$input"

echo Onboarding complete at $dt
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
