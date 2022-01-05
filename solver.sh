#!/bin/sh

chown -R root:root /judge
chmod -R 400 /judge

gcc source.c -o source

if [ $? -ne 0 ]; then
  printf "::$1:fail:compile::"
  exit
fi

judge() {
  su-exec solver timeout -s 9 $3 /source < /judge/$1.in > /judge/$1.tmp
  cmp -s /judge/$1.tmp /judge/$1.out || printf "::$2:fail:test:$n::"
}

for n in $(ls -1 /judge | awk -F. '$2=="in"{print$1}'); do
  judge $n $1 $2 &
done
