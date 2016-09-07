#!/bin/sh

# Settings
FILE=/tmp/bugs.txt
BRANCHES=($(git branch))
BUGPREFIX="bug"
BUGZILLA="bugzilla"

VERSION="1.1"

function change_descriptions() {
  while read -a fields; do
    local bug_no=${fields[0]#?}
    local status=${fields[1]}
    local author=${fields[3]}
    for i in {0..4}; do
      unset fields[$i]
    done

    local description=${fields[@]}
    description="${description//\"/\\\"}"
    local branch_name="$BUGPREFIX$bug_no"

    local found_branch=( ${BRANCHES[@]/$branch_name} )

    if ! [ ${#found_branch[@]} == ${#BRANCHES[@]} ]; then
      x="git config --replace-all branch.${branch_name}.description \"$status $description\""
      eval $x
    fi
  done < $FILE
}

# Shows branches with descriptions
function show_descriptions() {
  branches=$(git for-each-ref --format='%(refname)' refs/heads/ | sed 's|refs/heads/||')
  for branch in $branches; do
    desc=$(git config branch.$branch.description)
    if [ $branch == $(git rev-parse --abbrev-ref HEAD) ]; then
      branch="* \033[0;32m$branch\033[0m"
     else
       branch="  $branch"
     fi
     echo "$branch \033[0;36m$desc\033[0m"
  done
}

function generate_text_file() {
  $BUGZILLA --bugzilla=$BUGZILLA_URL --user="$BUGZILLA_USERNAME" --password="$BUGZILLA_PASSWORD" query > $FILE
  change_descriptions
}

function remove_temp_file() {
  rm $FILE  
}

function show_help() {
  echo "gitbugzilla, version $VERSION

usage: gitbugzilla <COMMAND>

  -s Show git branches with their descriptions
  -g Populate git branches with Bugzilla's information"
}

options_found=0

while getopts sg opt; do
  options_found=1
  case $opt in
  s)
    show_descriptions
    ;;
  g)
    generate_text_file
    change_descriptions
    remove_temp_file
    ;;
  *)
    show_help
    ;;
  esac
done

if ((!options_found)); then
  show_help
fi
