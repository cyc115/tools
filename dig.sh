#! /usr/bin/env bash

for ip in $(cat ips.txt); do nslookup $ip <nameserver>; done
