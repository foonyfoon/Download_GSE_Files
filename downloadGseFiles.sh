#!/bin/bash

readonly root_dir=$(pwd)
current_dir=$root_dir

regex_url='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
#dir name must be in the format of "xx..x_GSEnn..n" (no whitespace characters allowed, GSE id must be placed at the end of string)
regex_id='GSE[0-9]+$'

while read -r line
do
  if [[ $line =~ $regex_url ]]
  then 
    echo "$line will be downloaded to dir $(pwd)"
    axel -a -n 40 $line
  fi

  if [[ $line =~ $regex_id ]]
  then 
    if [[ $(pwd) != $root_dir ]]
    then
      echo "leaving $(pwd) to $root_dir"
      cd $root_dir
    fi

    pattern_folder=*"_${line}"

    for _dir in $pattern_folder
    do
      if [[ -d "${_dir}" ]]
      then
        break
      fi
    done
    
    if [[ ! -d "${_dir}" ||  "${_dir}" != $pattern_folder ]]
    then
      _dir=DIR_"${line}"
      mkdir "${_dir}"
      echo "mkdir ${_dir}"
    fi

    cd $_dir
    echo "at "$(pwd)
  fi

done < out.txt

echo "leaving $(pwd) to $root_dir"
cd $root_dir