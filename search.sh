#!/bin/bash

read -p "Grep: " keyword
kubectl logs gateway-app-cc675ddc-5f6w4 -n gateway-pj --context gateway-pj/api-tatung-ocp-poc:6443/admin -f | grep $keyword
