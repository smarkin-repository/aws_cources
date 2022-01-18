#!/bin/bash

set -x 

echo "VAR: $VAR"

echo $(expr $VAR + 1)
echo $(expr $VAR+1)
echo $(($VAR + 1 ))
echo $((VAR + 1))
