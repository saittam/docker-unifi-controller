#!/bin/bash

set -e
set -o pipefail

fatal() {
	echo "$@" 1>&2
	exit 1
}

# Determine JAVA_HOME.
JAVA_HOME=$(update-alternatives --query java | grep '^Value:' | sed 's!Value:\s*\(.*\)/bin/java$!\1!')
test -d "${JAVA_HOME}" || fatal "Failed to determine JAVA_HOME"

# Find jsvc.
JSVC=$(which jsvc)
test -x "${JSVC}" || fatal "jsvc not found"

# Launch jsvc.
exec "${JSVC}" \
	-home "${JAVA_HOME}" \
	-cp "/usr/share/java/commons-daemon.jar:${BASEDIR}/lib/ace.jar" \
	-procname unifi \
	-nodetach \
	-Xmx1024M \
	-Djava.awt.headless=true \
	-Dfile.encoding=UTF-8 \
	-Dunifi.datadir=/var/lib/unifi \
	-Dunifi.logdir=/var/log/unifi \
	-Dunifi.rundir=/var/run/unifi \
	com.ubnt.ace.Launcher start
