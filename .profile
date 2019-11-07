export PATH="$HOME/.node/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH:$HOME/bin:$HOME/phive/tools:$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin"

# include functions
. ~/www/git-files/functions.sh

subTitle "Profile initialization ..."

# When using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo '
alias switchBash='exec bash --login'

#
# brew
# https://github.com/Homebrew/legacy-homebrew/issues/49895
#

### Sublime
#
# This helps me edit files that my user isn't the owner of in Sublime
#alias edit='SUDO_EDITOR="open -FWna /Applications/Sublime\ Text\ 2.app" sudo -e'

### Visual studio code
#
# This allows run visual studio code in terminal by `code`
# @see https://code.visualstudio.com/docs/setup/mac#_command-line

# This alias reloads this file
alias reprofile='. ~/.profile'

#
# Development configuration files
#
alias eprofile='sublime ~/.profile'
alias ehosts='sublime /etc/hosts'
alias ehttpd='sublime ~/www/git-files/apache/httpd.conf'
alias ehttpdApache='sublime /etc/apache2/httpd.conf'
alias ehttpdApache24='sublime /usr/local/etc/apache2/2.4/httpd.conf'
alias evhosts='sublime /etc/apache2/extra/httpd-vhosts.conf'
alias elmcenvxml='sublime /etc/lmcenv.xml'
# php - https://getgrav.org/blog/mac-os-x-apache-setup-multiple-php-versions
alias ephp56='sublime /usr/local/etc/php/5.6/php.ini'	# LoadModule php5_module /usr/local/opt/php56/libexec/apache2/libphp5.so
alias ephp70='sublime /usr/local/etc/php/7.0/php.ini'	# LoadModule php7_module /usr/local/opt/php70/libexec/apache2/libphp7.so
alias ephp71='sublime /usr/local/etc/php/7.1/php.ini'	# LoadModule php7_module /usr/local/opt/php71/libexec/apache2/libphp71.so
alias ephp72='sublime /usr/local/etc/php/7.2/php.ini'	# LoadModule php7_module /usr/local/opt/php72/libexec/apache2/libphp72.so
alias ephp73='sublime /usr/local/etc/php/7.3/php.ini'	# LoadModule php7_module /usr/local/opt/php72/libexec/apache2/libphp73.so
# sphp 56 | sphp 70 | sphp 71
alias exdebug='sublime /usr/local/etc/php/7.3/conf.d/ext-xdebug.ini'

alias apache_check_sytnax='sudo /usr/sbin/httpd -t'
alias apache_restart='sudo apachectl restart'
alias apache_dump_vhosts='/usr/sbin/httpd -t -D DUMP_VHOSTS'
alias apache='echo use nginx!'
#alias apache='apache_restart && apache_check_sytnax'

function whatListenOn() {
	sudo lsof -nP -i:$1 | grep LISTEN
}

# nginx
alias phpStart='sudo brew services start php'
alias phpStop='sudo brew services stop php'
alias phpRestart='phpStop && phpStart'
alias phpShowFPM='lsof -Pni4 | grep LISTEN | grep php'

alias ngStart='phpStart && sudo brew services start nginx'
alias ngStop='sudo brew services stop nginx'
alias ngRestart='phpStart && sudo brew services restart nginx'

alias cd..="cd .."
alias cd.="cd ~"

alias ls='ls -FG'
alias lsa='ls -FGa'
alias ll='ls -lh'
alias lla='ll -a'

alias c='clear'
alias e='exit'
alias t='tail -f'
alias te='t /var/log/apache2/error_log'
alias ta='t /var/log/apache2/access_log'

# http://stackoverflow.com/questions/16956810/finding-all-files-containing-a-text-string-on-linux
function findString() {
	# or: grep -lr "/.*Suave.*/" ./
	grep -rnw . -e '$1'
}

# findFile /etc/ hosts
function findFile() {
	find $1 -type f -name "$2"
}

alias today='date "+%Y-%m-%d%n"'

# jenkins-console -> edu-jenkins
alias syncJenkinsMgmtToEdu='cp -R ~/www/php/jenkins-console/jobs/jenkins.mgmt.lmc.cz/	~/www/edu-jenkins/jobs/jenkins/'
alias syncJenkins3ToEdu='cp -R 	  ~/www/php/jenkins-console/jobs/jenkins3.lh.lmc.lan/	~/www/edu-jenkins/jobs/jenkins/'
# edu-jenkins -> jenkins-console
alias syncEduToJenkinsMgmt='cp -R	~/www/edu-jenkins/jobs/jenkins/	~/www/php/jenkins-console/jobs/jenkins.mgmt.lmc.cz/'
alias syncEduToJenkins3='cp -R		~/www/edu-jenkins/jobs/jenkins/	~/www/php/jenkins-console/jobs/jenkins3.lh.lmc.lan/'

alias syncJenkinsQAToEduQa='cp -R 	~/www/php/jenkins-console/jobs/jenkinsqa.dev5.lmc.cz/	~/www/jenkinsqa-jobs/jobs/'
alias syncEduQaToJenkinsQa='cp -R 	~/www/jenkinsqa-jobs/jobs/ ~/www/php/jenkins-console/jobs/jenkinsqa.dev5.lmc.cz/'

#
# symfony
#

# composer global require bamarni/symfony-console-autocomplete
#eval "$(symfony-autocomplete)"

alias fixCsFixer='./bin/php-cs-fixer fix'
alias fixCodeSniffer='./bin/phpcbf --standard=ruleset.xml .'
alias fixAll='fixCsFixer && fixCodeSniffer'

alias dev='bin/console --env=dev'
alias prod='bin/console --env=prod'

#symfony_clear_cache prod
function symfony_clear_cache() {
	bin/console cache:clear --env=$1
}

# doctrine

alias doctrineUpdate='bin/console doctrine:schema:update --dump-sql'
alias doctrineUpdateApp='app/console doctrine:schema:update --dump-sql'

#
# GPG key
#
# https://help.github.com/en/articles/generating-a-new-gpg-key
# https://stackoverflow.com/questions/39494631/gpg-failed-to-sign-the-data-fatal-failed-to-write-commit-object-git-2-10-0

alias gpgList='gpg --list-secret-keys --keyid-format LONG'
alias gpgExport='gpg --armor --export ' # key from gpgList

#
# git
#

###############################################################
# Training
# http://pcottle.github.io/learnGitBranching/
##############

alias egit="git config --global --edit"

# editor pro git
# git config --global core.editor "sublime -n -w"

# vlastni user config pro kazdy repo
# git config --global user.useconfigonly true

function gitMortalek() {
	git config user.name "Petr Chromec"
	git config user.email "mortal_flesh@seznam.cz"
	git config user.signingkey 2ABA543C079E370A
}

# cloning locally git
# git clone --bare project project.git
#
# git remote add shared project.git
 
# git log history
alias gl='git log --oneline'
alias ghist='git log --color --graph --pretty=format:"%C(auto)%h %ad | %C(white)%s%Creset%C(auto)%d%Creset %C(dim cyan)<%an>%Creset" --date=short'
#alias lg='git log --color --graph --pretty=format:"%C(yellow)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold cyan)<%an>%Creset" --abbrev-commit --'

# log akci v repu
# git reflog

# hooky
# https://github.com/kvz/ochtra
# git config --global init.templatedir '~/.gittemplate'
# 	|- hooks
# 		|- pre-commit
# 		|- pre-push

# zmena historie
#git filter-branch --env-filter '
#if [ "$GIT_AUTHOR_EMAIL" = "..." ];
#	...
#'

# patch
# git diff 123...456 --patch > diff.patch
# git apply diff.patch

# colors: normal, black, red, green, yellow, blue, magenta, cyan, white
# modif: bold, dim (tmave), ul (podtrzeni), blink, reverse (podbarveni)

#
###############################################################

#git-fixups - https://filip-prochazka.com/blog/git-fixup
#chmod +x /bin/git-log-vgrep-most-recent-commit

#git-config (git aliases - git up = pull ff-only)
. ~/.git-config.bash

#git-autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias ga='git add'
alias g='git status'
alias cg='c && g'
alias gc='git commit -am'
alias gcNoAdd='git commit -m'
alias gcEmpty='git commit --allow-empty -m'
alias mgp='m && gp && g'
alias m='git checkout master'
alias gst='git stash'
alias gwip='gst'
alias gstp='git stash pop'
alias gwippop='gstp'
alias gp='git up'	#git pull ff-only atd (alias in .git-config)
alias gu='git push'
alias guForce='gu --force-with-lease'
alias gres='git reset HEAD --hard'
alias gclean='git clean'

alias gcfixup='git commit -a --fixup=HEAD'
function gcfixupCommit() {
	git commit -a --fixup=$1
}
function gcfixupCommitNoAdd() {
	git commit --fixup=$1
}

# diff
alias gd='git diff'
alias gdLast='gd HEAD~1'

alias gdCount='gd --stat'
alias gdFiles='gd --name-status'
alias gdLastFiles='gdFiles HEAD~1'
alias gdLastCount='gdLast --stat'

# will show only added files in diff - usage: gda master
function gda() {
	gdFiles $1 | grep ^A
}
function gdaClass() {
	gda $1 | grep --color "/[A-Za-z ]*.php"
}
# will show only modified files in diff - usage: gdm master
function gdm() {
	gdFiles $1 | grep ^M
}
function gdmClass() {
	gdm $1 | grep --color "/[A-Za-z ]*.php"
}

function gitListMergedBranches() {
	git branch -r --merged | grep origin | grep -v master | xargs -L1 | cut -d"/" -f 2-10 > branches.txt
	sublime branches.txt
}
function gitListBranches() {
	git branch -r | grep origin | grep -v master | xargs -L1 | cut -d"/" -f 2-10 > branches.txt
	sublime branches.txt
}
function gitListIntegrationBranches() {
	git branch -r | grep origin | grep -v master | grep integration | xargs -L1 | cut -d"/" -f 2-10 > branches.txt
	sublime branches.txt
}

# removes local branches listed in `branches.txt`
function removeLocalBranches() {
	cat branches.txt | while read branch;
	do git branch -D $branch
	done
}

# removes origin branches listed in `branches.txt`
function removeOriginBranches() {
	cat branches.txt | while read branch;
	do git push origin --delete $branch
	done
}

function deleteBranch() {
	deleteLocalBranch $1
	deleteRemoteBranch $1
}

function deleteLocalBranch() {
	git branch -D $1
}

function deleteRemoteBranch() {
	git push origin --delete $1
}

# create branch XYZ
function branch() {
 gp
 git checkout -b $1
 git push -u origin $1:$1
 g
}

# create issue XYZ
function issue_withoutmaster() {
 gp
 git checkout -b $1
 git push -u origin $1:feature/$1
 g
}

# checkout master first
function issue() {
 mgp
 git checkout -b $1
 git push -u origin $1:feature/$1
 g
}

# create bugfix XYZ
function bugfix_withoutmaster() {
 gp
 git checkout -b $1
 git push -u origin $1:bugfix/$1
 g
}

# checkout master first
function bugfix() {
 mgp
 git checkout -b $1
 git push -u origin $1:bugfix/$1
 g
}

function gcountcommits() {
	ghist -100 | grep $1 | wc -l
}

# git squash commits: squash 5 (squashes 5 commits)
function squash() {
 git rebase --autosquash -i HEAD~$1
}

# gitTag 1.0.0
function gitTag() {
	gu
	git tag -a $1 -m "$1"
	gu --tags
}

function deleteTag() {
	git tag -d $1
	git push origin :refs/tags/$1
}

# create release issue release/rc/___XYZ___/rc1
# example: `release 14.11.40` creates `origin/release/rc/14.11.40/rc1`
function release() {
 mgp
 git checkout -b release/$1
 git push -u origin HEAD:release/$1
 g
}

function releaseNotFromMaster() {
 gp
 git checkout -b release/$1
 git push -u origin HEAD:release/$1
 g
}

# example: `integration 07-31` creates `origin/integration/2018-07-31`
function integration() {
	mgp
	git checkout -b integration/2018-$1
	git push -u origin HEAD:integration/2018-$1
	g
}

function integrationNew() {
	mgp
	git checkout -b integration/$(date "+%Y-%m-%d%n")
	git push -u origin integration/$(date "+%Y-%m-%d%n")
	g
}

function int() {
	i $(date "+%Y-%m-%d%n")
}

# checkout integration branch and pull
# write `i 2018-08-09` - it will checkout `integration/2018-08-09` and pull changes
function i() {
 git fetch
 git checkout integration/$1
 gp
 g
}

function integrationList() {
	git fetch
	git branch | grep integration | grep 2018
}

#
#workspaces
#
alias www='cd ~/www/'
alias fs='cd ~/fsharp/'

#
#php
#
alias phpUnlimitedMemory='php -d memory_limit=-1 '
alias phpUnlimitedMemoryComposer='php -d memory_limit=-1 /usr/local/bin/composer '
alias phptest='www && sublime test.php'
alias phpsymfonyrun='php app/console server:run'

alias ser='w && cd ../vagrant-lmc/'
alias vu='vagrant up'
alias vs='vagrant ssh'
alias vhalt='vagrant halt'

#phpunit
alias phpunitTest='cd app && ../bin/phpunit && cd ..'
#alias phpunitTest='php ./vendor/phpunit/phpunit/phpunit'
alias phpunitTestUnit='php ./vendor/phpunit/phpunit/phpunit --group unit'
alias phpunitTestGroup='php ./vendor/phpunit/phpunit/phpunit -c app/ --group $1'

alias phpunit2Test='php ./vendor/bin/phpunit'
alias phpunit2TestUnit='php ./vendor/bin/phpunit --group unit'
alias phpunit2TestGroup='php ./bin/phpunit -c app/ --group $1'

alias phpunitTestGroupSrc='php ./vendor/bin/phpunit -c src/ --group $1'

#
# js and css builds
#

# bower
alias bcc='bower cache clean'
alias bi='bower install'
alias bjsAll='bi && npm run build && grunt'

# npm
alias nrb='npm run build'
alias npmPublish='npm publish ./'

#
# QA
#
alias seleniumInstall='php ./vendor/bin/steward.php install 2.53.1'
alias seleniumServer='java -jar ./vendor/bin/selenium-server-standalone-2.53.1.jar'

alias seleniumServerHub='java -jar ./vendor/bin/selenium-server-standalone-2.53.1.jar -role hub -port 4444'
alias seleniumServerNode='java -jar ./vendor/bin/selenium-server-standalone-2.53.1.jar -role node -hub http://127.0.0.1:4444 -port 5555'

#
# Docker grid console: http://localhost:4444/grid/console
#
# will start 4 chromes in docker
function seleniumDockerStart() {
	docker-compose -f ./vendor/lmc/steward-lmc/bin/selenium-docker.yml up -d chrome
	docker-compose -f ./vendor/lmc/steward-lmc/bin/selenium-docker.yml scale chrome=4
}
# example: seleniumDockerDebug (will start 1 chrome in docker and allows debug mode - vnc server etc.)
function seleniumDockerDebug() {
	docker-compose -f ./vendor/lmc/steward-lmc/bin/selenium-docker.yml up -d chrome-debug
}
function seleniumDockerStop() {
	docker-compose -f ./vendor/lmc/steward-lmc/bin/selenium-docker.yml stop
	docker-compose -f ./vendor/lmc/steward-lmc/bin/selenium-docker.yml rm -f
}

#example: seleniumRunTest ENV FILE
function seleniumRunTest() {
	c
	./vendor/bin/steward run -v $1 chrome --pattern "$2.php"
}
function seleniumRunTestVV() {
	c
	./vendor/bin/steward run -vv $1 chrome --pattern "$2.php"
}
function seleniumRunTestDebug() {
	c
	./vendor/bin/steward run -vvv $1 chrome --pattern "$2.php"
}

#seleniumRunTestLocal FILE
function seleniumRunTestLocal() {
	c
	./vendor/bin/steward run -v --no-proxy local chrome --pattern "$1.php"
}
function seleniumRunTestLocalVV() {
	c
	./vendor/bin/steward run -vv --no-proxy local chrome --pattern "$1.php"
}
function seleniumRunTestLocalDebug() {
	c
	./vendor/bin/steward run -vvv --no-proxy local chrome --pattern "$1.php"
}

#example: seleniumRunGroup GROUP ENV
function seleniumRunGroup() {
	c
	./vendor/bin/steward run -v --group=$1 $2 chrome $3
}
function seleniumRunGroupVV() {
	c
	./vendor/bin/steward run -vv --group=$1 $2 chrome $3
}
function seleniumRunGroupDebug() {
	c
	./vendor/bin/steward run -vvv --group=$1 $2 chrome $3
}

#example: seleniumRunGroupLocal GROUP
function seleniumRunGroupLocal() {
	c
	./vendor/bin/steward run -v --no-proxy --group=$1 local chrome
}
function seleniumRunGroupLocalVV() {
	c
	./vendor/bin/steward run -vv --no-proxy --group=$1 local chrome
}
function seleniumRunGroupLocalDebug() {
	c
	./vendor/bin/steward run -vvv --no-proxy --group=$1 local chrome
}

#
# Database
#

# importDB DBNAME DBFILE
function importDB() {
	# echo "SET FOREIGN_KEY_CHECKS=0" | mysql [user/pass/database] 
	mysql -u root -p $1 < $2.sql
	# { echo "SET FOREIGN_KEY_CHECKS=1;" ; } | mysql
}

#
# Docker
#

# docker - completion
# http://stackoverflow.com/questions/26132451/how-to-add-bash-command-completion-for-docker-on-mac-os-x
# curl -XGET https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker > `brew --prefix`/etc/bash_completion.d/docker

alias cdDocker='cd. && cd docker'

# dockerRun appName
function dockerRun() {
	# it - interactive terminal
	# rm - remove after exit
	docker conainer run -it --rm --name $1 $1
}
alias drit='docker container run -it '
alias dritrm='docker container run -it --rm '

# docker ps 	# running processes
alias dps='docker container ls'
alias dpsa='dps -a'
alias dkillAll='docker stop $(dps -q)'

# docker run -it --rm --name NAME IMAGE -p EXTERN_PORT:IMAGE_PORT
# docker run -||- -d 	# -d pusti se na pozadi
# docker exec -it hello-app bash 	# pripojeni se na bash beziciho dockeru "hello-app"

#
# push repository to docker hub
# 
# $ docker build -t {username}/{image-name} . 						# builds a docker image in cwd
# $ docker images 							  						# shows all builded images (find a container id there)
# $ docker tag {container-id} {username}/{image-name}:{tag-version}	# add tag to container
# $ docker images 							  						# there should be tagged version of image with same container-id
# $ docker login --username={username}								# login to dockerhub acc
# $ docker push {username}/{image-name}:{tag-version}				# pushes the container to docker hub

#
# cleanup space - https://lebkowski.name/docker-volumes/
# docker system df
#
# docker image ls | grep '<none>' | awk '{ print $3 }' | xargs docker rmi
# docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v


#
# Scala
#
alias scala='sbt console'

#
# F#
#
alias f='fake build target '	# use: fake run OR fake build ...

alias fsNewConsole='dotnet new console -lang f# --no-restore'
alias fsNewSAFE='dotnet new SAFE -lang f#'
alias fsNewTests='dotnet new expecto -n tests -o tests/'
alias fsNewFake='dotnet new fake'
alias fsNewLib='dotnet new classlib -lang F#'

alias fsRun='dotnet run'
function fsRequire() {
	dotnet add package $1
	dotnet restore
}

alias dotnetTests='dotnet run -p tests/tests.fsproj'

alias fsRelease='dotnet publish -c Release -o ' # provide where to put the output

# tag current commit, push tags and release to the current nuget
function fsReleaseTag() {
	version=$1
	library=$2

	if [ -z "${version}" ]; then echo "Version is unset"; return 1; fi
	if [ -z "${library}" ]; then echo "Library is unset"; return 1; fi

	echo "Building '$library:$version' ..."

	f tests &&
	gc "Version $1" &&
	gu &&
	gitTag $1 &&
	f release &&

	fs &&
	cd nuget-server &&
	f copyAll &&
	ga . &&
	gc "Add $2 in version $1" &&
	ghist -1
}

#
# Profile
#
# profile PID ($1) for 30s to the sample.txt - example: `profileProcess 1234`
function profileProcess() {
	sample $1 30 -file ./sample.txt
}

# profile container by ID - example: `profileDocker CONTAINER_ID`
function profileDocker() {
	docker stats $0
}

#
# 7Zip
#
# zipFileWithPassword source
function zipFileWithPassword() {
	7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -mhe=on -p -- $1.7z $1
}
# zipFile source
function zipFile() {
	7z a -t7z -- $1.7z $1
}
alias zipExtract='7z x '
alias zipList='7z l '

#
# Black-fire
#
alias bfRestart='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.blackfire-agent.plist && launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.blackfire-agent.plist'
alias bfTailLog='tail -f /usr/local/var/log/blackfire/agent.log'

#
# Postgresql
#
# https://medium.com/coding-blocks/creating-user-database-and-adding-access-on-postgresql-8bfcd2f4a91e

alias pgStart='pg_ctl -D /usr/local/var/postgres start'
alias pgStop='pg_ctl -D /usr/local/var/postgres stop'
# brew services start postgresql # lauch at startup

#
# FTP
#

# http://osxdaily.com/2011/09/29/start-an-ftp-or-sftp-server-in-mac-os-x-lion/
alias ftpStart='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
alias ftpStop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

#
# include bash-completion
# http://superuser.com/questions/819221/how-to-install-the-debian-bash-completion-using-homebrew
#
if [ -f `brew --prefix`/etc/bash_completion ]; then 
    . `brew --prefix`/etc/bash_completion 
fi

#
# include private profile
#
if [ -f ~/.private_profile ]; then
  . ~/.private_profile
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm use node

#
# haskell
#
# Config file path source is default config file.
# Config file /Users/chromecp/.cabal/config not found.
# Writing default configuration to /Users/chromecp/.cabal/config

# ~/.ghcup/env

# http://geekocephale.com/blog/2018/09/28/Haskell-setup
alias haskellGhcid='ghcid "--command=ghci"'
alias haskellGhciRepl='ghci'
