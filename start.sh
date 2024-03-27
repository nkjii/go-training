#!/bin/sh

# /server をバックグランドで実行
/server &

tail -f /dev/null