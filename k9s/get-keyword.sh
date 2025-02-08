#!/bin/bash
temp_file=$(mktemp)
nvim $temp_file
echo $temp_file
