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
     echo "mvn apigee-config:${filePathArray[${#filePathArray[@]}-1]} -P$ENV -Dusername=$machine_apigeeUsername -Dpassword=$machine_apigeePassword -Dorg=$ORG -Dapigee.config.file=$GITHUB_WORKSPACE/Env_Config/$ENV/${filePathArray[${#filePathArray[@]}-1]}/$(_jq '.filename') -Dapigee.config.options=$(_jq '.action')"
     #echo "mvn apigee-config:${filePathArray[${#filePathArray[@]}-1]} -P$ENV -Dusername=$machine_apigeeUsername -Dpassword=$machine_apigeePassword -Dorg=$ORG -Dapigee.config.options=$(_jq '.action')"
     echo "$?"
     if [ "$?" -ne 1 ]
     then
        echo "Fallback script started executing"
        eval "fallback=\$(cat Env_Instruction.json | jq -r '.[].$(_jq '.fallback')[] | @base64')"
        echo "Fallback = ${fallback}"
        #auth=$(echo ${fallback}|base64);
        #echo "auth = ${fallback}"
        for row in ${fallback}; do
            echo "in fallback Loop"
            _jq() {
            echo ${row}| base64 --decode | jq -r ${1}
            }
            echo $(_jq '.filePath')
            echo "mvn apigee-config:${filePathArray[${#filePathArray[@]}-1]} -P$ENV -Dusername=$machine_apigeeUsername -Dpassword=$machine_apigeePassword -Dorg=$ORG -Dapigee.config.file=$GITHUB_WORKSPACE/Env_Config/$ENV/${filePathArray[${#filePathArray[@]}-1]}/$(_jq '.filename') -Dapigee.config.options=$(_jq '.action')"
            #echo "mvn apigee-config:${filePathArray[${#filePathArray[@]}-1]} -P$ENV -Dusername=$machine_apigeeUsername -Dpassword=$machine_apigeePassword -Dorg=$ORG -Dapigee.config.options=$(_jq '.action')"  
        done
        break
     else
        echo "Mvn Cmd successfully executed"
     fi
   done
else
   echo "Status = $(cat Env_Instruction.json | jq -r '.[].status')"
fi
