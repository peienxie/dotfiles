#!/usr/bin/sh

REDIS_PORT=${1:-6379}

if ! [ -x "$(command -v redis-cli)" ]; then
  echo "redis-cli is not installed" >&2
  exit 1
fi

KEYS=$(redis-cli -p $REDIS_PORT --scan --pattern \*)
if [ $? -ne 0 ]; then
  echo "redis-cli get keys failed"
  exit 2
fi

for key in $KEYS;
  do echo -n "\"$key\": " 
    redis-cli -p $REDIS_PORT GET $key;
done
