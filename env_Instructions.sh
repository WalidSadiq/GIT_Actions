#!/bin/bash
echo "hello!"
ExecuteFiles=$(cat env_Instruction.json | jq '.[].ExecuteFiles[]')
#echo "${#ExecuteFiles[@]}"
#echo "${ExecuteFiles[@]}"
for ((i=0; i<=${#ExecuteFiles[@]}; i++)); do
   echo "$i"
   echo "in Loop"
   #echo "file = $file"
   echo "${ExecuteFiles[$i]}"
   echo "out Loop"
done
#for i in "${#ExecuteFiles[@]}"; do
#done
Fallback_Scenario=$(cat env_Instruction.json | jq '.[].ExecuteFiles[].fallback')
#echo "${Fallback_Scenario[@]}"
Status=$(cat env_Instruction.json | jq '.[].status')
#echo "$Status"
