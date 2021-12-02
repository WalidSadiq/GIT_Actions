#!/bin/bash
echo "in apigee2openapi.sh"
npm install -g apigee2openapi
apigee2openapi -d ~/ -l ~/Drupal-Dummy_rev1_2021_12_02.zip -n Drupal-Dummy -e http://hiraaroob-fe1e7940-eval-test.apigee.net
