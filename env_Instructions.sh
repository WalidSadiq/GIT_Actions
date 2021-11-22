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
     #filePathArray=($(echo $(_jq '.filePath') | tr "/" " "))
     #echo "${#filePathArray[@]}"
     echo "mvn apigee-config:$(_jq '.filePath') -P$ENV -Dusername=$machine_apigeeUsername -Dpassword=$machine_apigeePassword -Dorg=$ORG -Dapigee.config.options=$(_jq '.action')"
     echo "$?"
     if [ "$?" -ne 1 ]
     then
       #fallback=$(_jq '.fallback')
        echo $(_jq '.fallback')
        echo "Fallback script started executing"
        Fallbacks = "$(cat Env_Instruction.json | jq -r '.[].\${!(_jq '.fallback')}')"
        echo "Fallback = $(cat Env_Instruction.json | jq -r '.[].$fallback | @base64')"
        for row in $(cat Env_Instruction.json | jq -r '.[]."${fallback}" | @base64'); do
            echo "in fallback Loop"
            _jq() {
            echo ${row} | base64 --decode | jq -r ${1}
            }
            echo $(_jq '.filePath')
            echo "mvn apigee-config:$(_jq '.filePath') -P$ENV -Dusername=$machine_apigeeUsername -Dpassword=$machine_apigeePassword -Dorg=$ORG -Dapigee.config.options=$(_jq '.action')"  
        done
     else
        echo "Mvn Cmd successfully executed"
     fi
   done
else
   echo "Status = $(cat Env_Instruction.json | jq -r '.[].status')"
fi
