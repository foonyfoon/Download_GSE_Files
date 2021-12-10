#!/bin/bash

readonly root_dir=$(pwd)
current_dir=$root_dir

regex_url='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
#dir name must be in the format of "xx..x_GSEnn..n" (no whitespace characters allowed, GSE id must be placed at the end of string)
regex_id='GSE[0-9]+$'

while read -r line
do
#if line is in the pattern of an url
  if [[ $line =~ $regex_url ]]
  then 
    axel -a -n 40 $line
  
  fi

#if line is in the pattern of GSEnn...n
  if [[ $line =~ $regex_id ]]
  then 
    if [[ $(pwd) != $root_dir ]]
    then
      cd $root_dir
    fi

    pattern_folder=*"_${line}"

  #if dir for corresponding GSE id does exists
    for _dir in $pattern_folder
    do
      if [[ -d "${_dir}" ]]
      then
        break
      fi
    done

#if dir for corresponding GSE id does not exist
    if [[ ! -d "${_dir}" ||  "${_dir}" != $pattern_folder ]]
    then
      _dir=DIR_"${line}"
      mkdir "${_dir}"
      echo "created directory: ${_dir}"
    fi

    cd $_dir
  fi

done < out.txt

cd $root_dir