#! /bin/bash
#@name: change_git_user
#@brief: 开源之前，处理历史版本全局用户名和删除敏感文件，
#@note: GIT_COMMITTER_NAME is more importment than GIT_AUTHOR_NAME
#@refer: ~/.gitconfig

#COMP_NAME="denny"
#git commit --amend --author='Denny Wu <wuqifu@gmail.com>'

dir=$1
cd $dir

do_commit_filter()
{   # '=' seems 完全相同，通配符＊不起作用
	git filter-branch -f --commit-filter '
		if [ "${GIT_AUTHOR_NAME}" = *enny* ];
		then
		    GIT_COMMITTER_NAME="Denny Wu";
		    GIT_AUTHOR_NAME="Denny Wu";
		    GIT_COMMITTER_EMAIL="wuqifu@gmail.com";
		    GIT_AUTHOR_EMAIL="wuqifu@gmail.com";
		    git commit-tree "$@";
		else
		    git commit-tree "$@";
		fi' HEAD
}

do_env_filter()
{
git filter-branch -f --env-filter '
	case "${GIT_AUTHOR_NAME} ${GIT_AUTHOR_EMAIL}" in
	*enny*)
	export GIT_AUTHOR_NAME="Denny Wu"
	export GIT_AUTHOR_EMAIL="wuqifu@gmail.com"
	;;
	esac
	case "${GIT_COMMITTER_NAME}　${GIT_COMMITTER_EMAIL}" in
	*enny*)
	export GIT_COMMITTER_NAME="Denny Wu"
	export GIT_COMMITTER_EMAIL="wuqifu@gmail.com"
	;;
	esac
	'
}

# remove unnecessay file or directory
do_tree_filter()
{
git filter-branch --tree-filter 'rm -f passwords.txt' HEAD
git push origin --tags --force
git push origin --all --force
}

do_env_filter

#git log
# git pull --allow-unrelated-histories

