# git up - command to proxy git pull ff-only and other stuff (to prevent merging a forced branches)
# http://stackoverflow.com/questions/15316601/in-what-cases-could-git-pull-be-harmful/15316602#15316602
git config --global alias.up '!git remote update -p; git merge --ff-only @{u}'
