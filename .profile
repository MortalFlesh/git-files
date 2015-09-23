export PATH="$HOME/.node/bin:$PATH"


# When using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo '


# This helps me edit files that my user isn't the owner of in Sublime
#alias edit='SUDO_EDITOR="open -FWna /Applications/Sublime\ Text\ 2.app" sudo -e'

# This alias reloads this file
alias reprofile='. ~/.profile'

#
# Development configuration files
#
alias eprofile='sublime ~/.profile'
alias ehosts='sublime /etc/hosts'
alias ehttpd='sublime /etc/apache2/httpd.conf'
alias ephp='sublime /usr/local/etc/php/5.6/php.ini'
alias evhosts='sublime /etc/apache2/extra/httpd-vhosts.conf'

alias apache_check_sytnax='sudo /usr/sbin/httpd -t'
alias apache_restart='sudo apachectl restart'
alias apache_dump_vhosts='/usr/sbin/httpd -t -D DUMP_VHOSTS'
alias apache='apache_restart && apache_check_sytnax'

alias cd..="cd .."
alias cd.="cd ~"

alias ls='ls -FG'
alias lsa='ls -FGa'
alias ll='ls -lh'
alias lla='ls -lha'

alias c='clear'
alias e='exit'
alias t='tail -f'
alias te='t /var/log/apache2/error_log'
alias ta='t /var/log/apache2/access_log'

#
# symfony
#

#symfony_clear_cache prod
function symfony_clear_cache() {
	php app/console cache:clear --env=$1
}

#
# git
#

#git-fixups - https://filip-prochazka.com/blog/git-fixup
chmod +x ~/git-log-vgrep-most-recent-commit

#git-config (git aliases - git up = pull ff-only, git cif = fixup commit)
. ~/.git-config.bash

#git-autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias ga='git add'
alias g='git status'
alias gc='git commit -am'
alias mgp='m && gp && g'
alias m='git checkout master'
alias gst='git stash'
alias gwip='gst'
alias gstp='git stash pop'
alias gwippop='gstp'
alias gp='git up'	#git pull ff-only atd (alias in .git-config)
alias gu='git push'
alias gd='git diff'
alias gres='git reset HEAD --hard'

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
# git squash commits: squash 5 (squashes 5 commits)
function squash() {
 git rebase -i HEAD~$1
}

# git autosquash fixup commits in branch (use: autosquash master)
function autosquash() {
	git rebase -i --autosquash $1
}

# gitTag 1.0.0
function gitTag() {
 git tag -a $1 -m "$1"
 gu --tags
}

# create release issue release/rc/___XYZ___/rc1
# example: `release 14.11.40` creates `origin/release/rc/14.11.40/rc1`
function release() {
 mgp
 git checkout -b release/rc/$1/rc1
 git push -u origin HEAD:release/rc/$1/rc1
 g
}

# create release issue release/rc/___XYZ___/rc___X___
# example: `release 14.11.40 2` creates `origin/release/rc/14.11.40/rc2`
function release_rc() {
 mgp
 git checkout -b release/rc/$1/rc$2
 git push -u origin HEAD:release/rc/$1/rc$2
 g
}

function releaseNotFromMaster() {
 gp
 git checkout -b release/rc/$1/rc1
 git push -u origin HEAD:release/rc/$1/rc1
 g
}

# example: `integration 07-31` creates `origin/integration/2015-07-31`
function integration() {
	mgp
	git checkout -b integration/2015-$1
	git push -u origin HEAD:integration/2015-$1
	g
}

# checkout sprint branch and pull
# write `s 08-09` - it will checkout `integration/2015-08-09` and pull changes
function i() {
 git fetch
 git checkout integration/2015-$1
 gp
 g
}

# example: `sprint 10` creates `origin/sprint/15.10`
function sprint() {
 gp
 git checkout -b sprint/15.$1
 git push -u origin HEAD:sprint/15.$1
 g
}

# checkout sprint branch and pull
# write `s 21` - it will checkout `sprint/15.21` and pull changes
function s() {
 git checkout sprint/15.$1 && gp
 g
}

#
#workspaces
#
alias www='cd ~/www/'

#
#php
#
alias phptest='www && sublime test.php'
alias phpsymfonyrun='php app/console server:run'

alias ser='w && cd ../vagrant/'
alias vu='ser && vagrant up'
alias vs='ser && vagrant ssh'
alias vhalt='ser && vagrant halt && vu && vs'

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
alias seleniumInstall='php ./vendor/bin/steward.php install'
alias seleniumServer='java -jar ./vendor/bin/selenium-server-standalone-2.47.1.jar'

alias seleniumServerHub='java -jar ./vendor/bin/selenium-server-standalone-2.47.1.jar -role hub -port 4444'
alias seleniumServerNode='java -jar ./vendor/bin/selenium-server-standalone-2.47.1.jar -role node -hub http://127.0.0.1:4444 -port 5555'

#example: seleniumRunTest ENV FILE
function seleniumRunTest() {
	./vendor/bin/steward.php run-tests $1 firefox --pattern "$2.php"
}
#seleniumRunTestLocal FILE
function seleniumRunTestLocal() {
	./vendor/bin/steward.php run-tests --no-proxy local firefox --pattern "$1.php"
}
#example: seleniumRunGroup GROUP ENV
function seleniumRunGroup() {
	./vendor/bin/steward.php run-tests --group=$1 $2 firefox $3
}
#example: seleniumRunGroupLocal GROUP
function seleniumRunGroupLocal() {
	./vendor/bin/steward.php run-tests --no-proxy --group=$1 local firefox
}
