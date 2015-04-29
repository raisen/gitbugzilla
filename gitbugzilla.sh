#!/bin/sh
FILE=bugs.txt
branches=($(git branch))
bug_prefix="bug"

#echo $branches

while read -a fields
do
 bug_no=${fields[0]#?}
 status=${fields[1]}
 author=${fields[3]}
 for i in {0..4} 
 do
  unset fields[$i]
 done
 description=${fields[@]}
 description="${description//\"/\\\"}"
 branch_name="$bug_prefix$bug_no"
 FOUND_BRANCH=( ${branches[@]/$branch_name} )
 if ! [ ${#FOUND_BRANCH[@]} != ${#branches[@]} ]; then
#  echo "The branch '"$branch_name"' could not be found"
 else
#  echo "The branch '"$branch_name"' could be found!"
  x="git config branch.${branch_name}.description \"$status $description\""
#  echo $x
  eval $x
 fi
done < $FILE