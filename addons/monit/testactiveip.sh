#!/usr/bin/env bash

mgmtip=`grep '\[CLUSTER\]' -A 1 /usr/local/pf/conf/cluster.conf|grep management_ip|cut -d= -f2`
activip=`ip a | grep 'inet '| grep -v '127.0.0.1' |awk '{ print $2}'|cut -d/ -f1`

if [[ ${activip[*]} =~ $mgmtip ]]; then
	exit 0
else
	exit 1
fi
