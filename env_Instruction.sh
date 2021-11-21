#!/bin/bash

echo "hello!"
ExecuteFiles=$(cat env_Instruction.json | jq '.[].ExecuteFiles[]')
echo "${ExecuteFiles[@]}"

Fallback_Scenario=$(cat env_Instruction.json | jq '.[].ExecuteFiles[].fallback')
echo "${Fallback_Scenario[@]}"

Status=.[].status
echo "$Status"
