#!/bin/bash
echo "Status = $(cat env_Instruction.json | jq -r '.[].status')"
if [[ "$(cat env_Instruction.json | jq -r '.[].status')" == "EXECUTE" ]]
then
   for row in $(cat env_Instruction.json | jq -r '.[].ExecuteFiles[] | @base64'); do
      echo "in Loop"
     _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
     }
     echo $(_jq '.filePath')
     filePathArray=($(echo $(_jq '.filePath') | tr "/" " "))
     echo "${#filePathArray[@]}"
     #mvn_cmd = "echo 'mvn apigee-config:'"
     echo ${filePathArray[$(echo "${#filePathArray[@]}")]}
     echo "mvn apigee-config: ${filePathArray[@]}"
   done
else
   echo "FileStatusss"
   echo "Status = $(cat env_Instruction.json | jq -r '.[].status')"
fi
