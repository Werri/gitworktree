#!/bin/bash
source ~/gitbranchespath.sh
if [ $# -lt 1 ]; then
	echo "Usage: gitworktree.sh <new_branch_name_to_create>";
	exit 0;
fi
OLD_BRANCH=$1
CMD=''
if [ $# -lt 2 ]; then
   git branch -M $OLD_BRANCH ${OLD_BRANCH}'_renamed'
   HEAD=$(git log -n 1 --pretty=%H)
   CMD="-b ${OLD_BRANCH} "
else
   HEAD=${OLD_BRANCH}
fi
git branch -v
git stash
git worktree add ${CMD}${GIT_BRANCHES_PATH}/${OLD_BRANCH} ${HEAD}
git worktree lock ${GIT_BRANCHES_PATH}/${OLD_BRANCH}
cd ${GIT_BRANCHES_PATH}/${OLD_BRANCH}
git stash apply
echo $HEAD > HEAD
git push --set-upstream origin ${OLD_BRANCH}
