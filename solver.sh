#!/bin/sh

chown -R root:root /judge
chmod -R 400 /judge

gcc source.c -o source

if [ $? -eq 0 ]; then
  printf "\n::$1:compile:success::\n"
else
  printf "\n::$1:compile:fail::\n"
  exit 0
fi

for n in $(ls -1 /judge | awk -F. '$2=="in"{print$1}'); do
  printf "\n::$1:test:$n:start::\n"
  su-exec solver timeout $2 /source < /judge/$n.in | tee $n.tmp

  cmp -s $n.tmp /judge/$n.out

  if [ $? -eq 0 ]; then
    printf "\n::$1:test:$n:success::\n"
  else
    printf "\n::$1:test:$n:fail::\n"
  fi
done
