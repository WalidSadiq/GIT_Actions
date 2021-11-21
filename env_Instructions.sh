#!/bin/bash
echo "hello!"
ExecuteFiles=$(cat env_Instruction.json | jq '.[].ExecuteFiles[]')
#echo "${#ExecuteFiles[@]}"
#echo "${ExecuteFiles[@]}"
for row in "${#ExecuteFiles[@]}"; do
   echo "$row"
   echo "in Loop"
   #echo "file = $file"
   echo "${ExecuteFiles[$row]}"
   echo "out Loop"
done
#for i in "${#ExecuteFiles[@]}"; do
#done
Fallback_Scenario=$(cat env_Instruction.json | jq '.[].ExecuteFiles[].fallback')
#echo "${Fallback_Scenario[@]}"
Status=$(cat env_Instruction.json | jq '.[].status')
#echo "$Status"
