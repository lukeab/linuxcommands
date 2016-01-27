#!/bin/bash
#
##adapted from a gist from https://gist.github.com/gonsfx
options=('find' 'delete')
PS3='state your wish: '

echo -e "\nfind/delete corrupt whisper-files"

whisperinfoscript="/bin/whisper-info.py"
if [[ ! -f $whisperinfoscript ]]; then
  echo "Error: Missing dependency => $whisperinfoscript not found." 
  exit 1;
fi

select opt in "${options[@]}"; do
  case $REPLY in
    [12] ) option=$opt; break;;
    * ) exit;;
  esac
done

if [ "$option" ]; then
  matches=()
  fileschecked=0
  directory='/opt/graphite/storage/whisper'

  for file in $(find $directory -type f -name '*.wsp' -print); do
    /usr/bin/env python $whisperinfoscript "${file}" > /dev/null 2>&1
    retval=$?
    #echo -en "\r\033[Kchecking $file"
    ((fileschecked++))
    [ $retval -ne 0 ] && matches+=($file) && printf $retval
  done

  echo

  if [ "$option" == 'find' ]; then
    echo -en "\r\033[Klisting ${#matches[@]} corrupt files out of $fileschecked checked files:\n"
    for file in "${matches[@]}"; do
      echo -e "- $file"
    done
  else
    echo -en "\r\033[Kdeleting ${#matches[@]} corrupt files out of $fileschcked checked files:\n"
    for file in "${matches[@]}"; do
      rm "$file" && echo -e "- $file"
    done
  fi
fi

