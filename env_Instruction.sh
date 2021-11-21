#!/bin/bash
echo "hello!"
ExecuteFiles=$(cat env_Instruction.json | jq '.[].ExecuteFiles[]')
echo "${ExecuteFiles[@]}"
Fallback_Scenario=$(cat env_Instruction.json | jq '.[].ExecuteFiles[].fallback')
echo "${Fallback_Scenario[@]}"
Status=$(cat env_Instruction.json | jq '.[].status')
echo "$Status"
