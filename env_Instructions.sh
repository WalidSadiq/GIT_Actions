#!/bin/bash
echo "hello!"
#ExecuteFiles=$(cat env_Instruction.json | jq -r '.[].ExecuteFiles[] | @base64')
#echo "${#ExecuteFiles[@]}"
#echo "${ExecuteFiles[@]}"
for row in $(cat env_Instruction.json | jq -r '.[].ExecuteFiles[] | @base64'); do
   echo "in Loop"
   echo ${row}
   echo ${row} | base64 --decode | jq -r ${1}
   #echo "file = $file"
   #echo "${ExecuteFiles[$row]}"
   echo "out Loop"
done
#for i in "${#ExecuteFiles[@]}"; do
#done
Fallback_Scenario=$(cat env_Instruction.json | jq '.[].ExecuteFiles[].fallback')
#echo "${Fallback_Scenario[@]}"
Status=$(cat env_Instruction.json | jq '.[].status')
#echo "$Status"
