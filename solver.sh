#!/bin/sh

# permission correction
chown -R root:root /judge
chmod -R 400 /judge

# build source code
gcc source.c -o source

if [ $? -eq 0 ]; then
  printf "\n::$1:compile:success::\n"
else
  printf "\n::$1:compile:fail::\n"
  exit 0
fi

# find test cases & run
for n in $(ls -1 /judge | awk -F. '$2=="in"{print$1}'); do
  printf "\n::$1:test:$n:start::\n"

  # run
  su-exec solver timeout $2 /source < /judge/$n.in | tee $n.tmp

  # append LF if not exist
  xxd $n.tmp -p | grep -qE "0a"

  if [ $? -ne 0 ]; then
    echo -ne '\x0a' >> $n.tmp
  fi
  
  # append LF if not exist
  xxd /judge/$n.out -p | grep -qE "0a"

  if [ $? -ne 0 ]; then
    echo -ne '\x0a' >> /judge/$n.out
  fi


  # check result
  cmp -s $n.tmp /judge/$n.out

  if [ $? -eq 0 ]; then
    printf "\n::$1:test:$n:success::\n"
  else
    printf "\n::$1:test:$n:fail::\n"
  fi
done
