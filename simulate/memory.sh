#!/usr/bin/env bash
declare -a array
for((i=0;i<10000000;i++))
do
  array[$i]=$i
done