#!/bin/bash
echo "hello!"
echo "Status = $(cat env_Instruction.json | jq -r '.[].status')"
if [[$(cat env_Instruction.json | jq -r '.[].status') = "EXECUTE" ]]
then
   for row in $(cat env_Instruction.json | jq -r '.[].ExecuteFiles[] | @base64'); do
      echo "in Loop"
      echo ${row}
      echo ${row} | base64 --decode | jq -r ${1}
      echo "out Loop"
   done
else
  echo "File Status = $(cat env_Instruction.json | jq -r '.[].status')" 
fi
#Fallback_Scenario=$(cat env_Instruction.json | jq '.[].ExecuteFiles[].fallback')
#echo "${Fallback_Scenario[@]}"
#Status=$(cat env_Instruction.json | jq '.[].status')
#echo "$Status"
