#!/bin/sh

# 全局提交用户名与邮箱
git config --global user.name "Denny.Wu"
git config --global user.email wuqifu@gmail.com

# 中文编码支持, git 1.7支持中文路径utf-8，彻底解决中文乱码问题
echo "export LESSCHARSET=utf-8" > $HOME/.profile
git config --global gui.encoding utf-8
git config --global i18n.commitencoding utf-8
git config --global i18n.logoutputencoding utf-8

# 全局编辑器，提交时将COMMIT_EDITMSG编码转换成UTF-8可避免乱码
git config --global core.editor notepad2
# 全局.gitignore
git config --global core.excludesfile ~/.gitignore_global
# 密码缓存一小时，如果使用了ssh公钥验证，可去掉
git config --global credential.helper  'cache --timeout 3600'

# 差异工具配置
git config --global diff.external git-diff-wrapper.sh
git config --global diff.tool tortoise
git config --global difftool.tortoise.cmd 'TortoiseMerge -base:"$LOCAL" -theirs:"$REMOTE"'
git config --global difftool.prompt false

# 合并工具配置
git config --global merge.tool tortoise
git config --global mergetool.tortoise.cmd 'TortoiseMerge -base:"$BASE" -theirs:"$REMOTE" -mine:"$LOCAL" -merged:"$MERGED"'
git config --global mergetool.prompt false

# 别名设置
git config --global alias.dt difftool
git config --global alias.mt mergetool

# 取消 $ git gui 的中文界面，改用英文界面更易懂
if [ -f "/share/git-gui/lib/msgs/zh_cn.msg" ]; then
rm /share/git-gui/lib/msgs/zh_cn.msg
fi
