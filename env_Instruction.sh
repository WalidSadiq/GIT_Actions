#!/bin/bash

echo "hello!"
ExecuteFiles=( $(jq '.[].ExecuteFiles[]' json) )
echo "${ExecuteFiles[@]}"

Fallback_Scenario=( $(jq '.[].ExecuteFiles[].fallback' json) )
echo "${Fallback_Scenario[@]}"

Status=.[].status
echo "$Status"
