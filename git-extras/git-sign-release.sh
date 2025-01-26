#!/usr/bin/env zsh

# git-sign-release(1)
hook() {
  local hook=".git/hooks/$1.sh"
  if test -f $hook; then
    echo "... $1"
    . $hook
  fi
}

if test $# -gt 0; then
  echo "... releasing $1"
  ndate=$(date -u +%Y-%m-%dT%H:%M:%S%z)
  GIT_AUTHOR_DATE=$ndate GIT_COMMITTER_DATE=$ndate git commit -a -m "Release $1." \
    && git tag $1 -s -m '' \
    && git push \
    && git push --tags
  echo "... complete"
else
  echo "tag required" 1>&2 && exit 1
fi