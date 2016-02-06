# ENVIRONMENT
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
export MONGO_HOME=/usr/local/mongodb
export MYSQL_HOME=/usr/local/mysql
export REDIS_HOME=/usr/local/redis
export RVM_HOME=~/.rvm
export TOMCAT_HOME=/usr/local/tomcat

export PATH=${PATH}:${JAVA_HOME}/bin:${MONGO_HOME}/bin:${MYSQL_HOME}/bin:${REDIS_HOME}/src:${TOMCAT_HOME}/bin:${RVM_HOME}/bin

export EDITOR='/usr/local/bin/sublime'

# RUBY
source ~/.rvm/scripts/rvm

#ls aliases
alias ll='ls -alhF'

#r7 aliasses
alias build_boxes='sudo ~/workspace/box_tools/prepare.sh && ~/workspace/box_tools/build_boxes.sh'

#ssh r7
sshr7() {
	PROST_SCHUMI=$1
	case $PROST_SCHUMI in
		"prost")
			SYSTEM="cms"
			;;
		"schumi")
			SYSTEM="delivery"
			;;
		*)
			echo "Invalid parameter $1"
			kill -INT $$
			;;
	esac
	ENV=$2
	ssh gcmelo@$SYSTEM-$ENV-qa.ir7.com.br
}

#git helpers
merge_theirs() {
	BRANCH=$1
	git merge --strategy recursive -X theirs $BRANCH
}

#set colors on ls, grep
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

function color_my_prompt {
    local __user_and_host="\[\033[38;5;240m\]\u@\h"
    local __cur_location="\[\033[38;5;74m\]\w"
    local __git_branch_color="\[\033[38;5;246m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[38;5;15m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt