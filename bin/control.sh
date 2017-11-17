#!/bin/bash
set -euo pipefail

function do_build {
	docker build -t $DCIMG $BASEDIR
}

function do_shell {
	exec docker run $DCOPT -it --rm -w /root/app $DCIMG bash
}

function do_openstack {
	exec docker run $DCOPT -it --rm -w /root/app $DCIMG openstack $@
}

function do_env {
	echo "export PATH=$BASEDIR/bin:$PATH"
}


BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

source $BASEDIR/config.env

COMMANDS="build shell openstack env"

# 使い方
function usage {
	echo "USAGE: $0 [ COMMAND ]"
	echo "COMMANDS:"
	for i in $COMMANDS; do
		echo "  $i"
	done
	exit 1
}

# do_[コマンド名] を実行
if [ -z "${1:-}" ]; then usage; fi
for i in $COMMANDS; do
	if [ "$i" == "$1" ]; then
		RUNCOMMAND="do_"$i
		if [ "$(type -t "$RUNCOMMAND")" == "function" ]; then
			shift
			$RUNCOMMAND $@
			exit 0
		fi
	fi
done
usage
