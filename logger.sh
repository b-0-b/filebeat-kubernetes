#!/bin/bash

for i in 1 2 3 4 5
do
    DATE=$(date)
    echo "{ \"log\": \"Testing JSON logs $DATE\"}" >> /var/log/containers/json_test.log
    sleep 5
done
