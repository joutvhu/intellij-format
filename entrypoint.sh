#!/bin/bash
if [[ $# -ne 5 ]]; then
  echo 'Exactly five parameters required: path, mark, settings, message, verify'
  exit 1
fi

path=$1
mark=$2
settings=$3
message=$4
verify=$5

mkdir -p "/root/.config/JetBrains/IntelliJIdea2020.3/eval"
cd "/root/.config/JetBrains/IntelliJIdea2020.3/eval"
printf %x $(echo -$(($(date +%s%N)/1000000))) > evaluation-date.txt
xxd -r -p evaluation-date.txt idea203.evaluation.key
rm evaluation-date.txt

options="-r ."

if [[ "$settings" != "" ]]; then
  options="$options -s $settings"
fi

if [[ "$mark" != "" ]] && [[ "$mark" != "*" ]]; then
  options="$options -m $mark"
fi

git config --global --add safe.directory /github/workspace

cd "/github/workspace/$path" || exit 2
changed_files_before=$(git status --short)

/opt/idea/bin/format.sh $options

changed_files_after=$(git status --short)
changed_files=$(diff <(echo "$changed_files_before") <(echo "$changed_files_after"))
changed_files_count=$(($(echo "$changed_files" | wc --lines) - 1))

echo "$changed_files"
echo "changed=$changed_files_count" >> $GITHUB_OUTPUT

if [[ "$message" != "" ]]; then
  if [[ $changed_files_count -gt 0 ]]; then
    git config user.name 'GitHub'
    git config user.email 'noreply@github.com'
    git commit --all -m "$message" --author="github-actions[bot] <github-actions[bot]@users.noreply.github.com>"
    git push origin
  fi
fi

if [[ "$verify" == "true" ]]; then
  if [[ $changed_files_count -gt 0 ]]; then
    exit 1
  fi
fi
