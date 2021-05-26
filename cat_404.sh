#!/bin/bash

cat /var/log/apache2/$1 | grep "404" | sed 's/"//g' \awk 'BEGIN {print "  ip   \t     Request  \t METHOD \ USER-AGENT"} {print $1 "  \t " $76  "  \t  "  $6 "        \t  "  $12}'
