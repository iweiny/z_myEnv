#!/bin/sh


sparse_dir=$1
from_commit=$2

sparse_cmd="make C=2 CF=-D__CHECK_ENDIAN__"

if [ "$1" == "-h" ] || [ "$sparse_dir" == "" ]; then
	echo "usage: check-sparse.sh <sparse dir> [<from-commit>] "
	echo "   Run sparse on the directory specified"
	echo ""
	echo "   Optionally:"
	echo "   Check each patch from <from-commit> to the current head for"
	echo "   sparse errors"
	echo ""
	echo "   starts out in an interactive rebase windown for the user to"
	echo "   select the patches they want checked.  Mark such patches as"
	echo "   'edit' and proceed with the rebase"
	exit 1
fi

if [ "$from_commit" != "" ]; then
	git rebase -i $from_commit
	
	rc=0
	while [ "$rc" == "0" ]; do
		echo "     SPARSE CHECK: "
		git log -1 --pretty=oneline --abbrev-commit
		$sparse_cmd $sparse_dir
		rc=$?
		if [ "$rc" != "0" ]; then
			echo "     SPARSE BUILD failed: "
			git log -1 --pretty=oneline --abbrev-commit
			echo ""
			echo "     fix issue and check with the following"
			echo ""
			echo "     exit shell when done"
			echo "$sparse_cmd $sparse_dir"
			bash
		fi
	
		git rebase --continue
		rc=$?
	done
else
	$sparse_cmd $sparse_dir
fi

exit $rc

