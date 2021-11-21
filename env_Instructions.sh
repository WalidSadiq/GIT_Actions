#!/bin/bash
echo "Status = $(cat env_Instruction.json | jq -r '.[].status')"
if [[ "$(cat env_Instruction.json | jq -r '.[].status')" == "EXECUTE" ]]
then
   for row in $(cat env_Instruction.json | jq -r '.[].ExecuteFiles[] | @base64'); do
      echo "in Loop"
     _jq() {
      echo ${row} | base64 --decode
     }
     echo $(_jq '.filePath')
      echo ${row}'.filePath'| base64 --decode
      echo "out Loop" 
   done
else
  echo "File Status = $(cat env_Instruction.json | jq -r '.[].status')" 
fi
