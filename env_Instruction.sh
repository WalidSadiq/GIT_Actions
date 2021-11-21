#!/bin/bash
echo "hello!"
ExecuteFiles=$(cat env_Instruction.json | jq '.[].ExecuteFiles[]')
echo "${#ExecuteFiles[@]}"
echo "${ExecuteFiles[@]}"
for file in "${#ExecuteFiles[@]}"; do
  echo "in Loop"
  echo "${ExecuteFiles[file]}"
done
Fallback_Scenario=$(cat env_Instruction.json | jq '.[].ExecuteFiles[].fallback')
echo "${Fallback_Scenario[@]}"
Status=$(cat env_Instruction.json | jq '.[].status')
echo "$Status"
