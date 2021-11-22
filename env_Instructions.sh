#!/bin/bash
echo "Status = $(cat Env_Instruction.json | jq -r '.[].status')"
if [[ "$(cat Env_Instruction.json | jq -r '.[].status')" == "EXECUTE" ]]
then
   for row in $(cat Env_Instruction.json | jq -r '.[].ExecuteFiles[] | @base64'); do
      echo "in Loop"
     _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
     }
     echo $(_jq '.filePath')
     filePathArray=($(echo $(_jq '.filePath') | tr "/" " "))
     echo "${#filePathArray[@]}"
     echo "mvn apigee-config:${filePathArray[${#filePathArray[@]}-1]} -P$ENV -Dusername=$machine_apigeeUsername -Dpassword=$machine_apigeePassword -Dorg=$ORG -Dapigee.config.options=$(_jq '.action')"
     echo "$?"
     if [ "$?" -ne 1 ]
     then
        echo "Fallback script started executing"
        echo "Fallback = $(cat Env_Instruction.json | jq -r '.[].($(_jq '.fallback')[]) | @base64')"
        echo "mvn apigee-config:${filePathArray[${#filePathArray[@]}-1]} -P$ENV -Dusername=$machine_apigeeUsername -Dpassword=$machine_apigeePassword -Dorg=$ORG -Dapigee.config.options=$(_jq '.action')"
     else
        echo "Mvn Cmd successfully executed"
     fi
   done
else
   echo "Status = $(cat Env_Instruction.json | jq -r '.[].status')"
fi
