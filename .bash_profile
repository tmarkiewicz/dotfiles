echo -ne "${COLOR_GRAY}Uptime: "; uptime
echo -ne "${COLOR_GRAY}Server time is: "; date

# display which Git branch you are currently working in
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1="\w\$(parse_git_branch) $ "

# cd to the path of the front Finder window
# via http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

# General aliases
alias cd..='cd ..'
alias l='ls -l'
alias ebash='subl ~/.bash_profile &'
alias reload_bash='source ~/.bash_profile'
alias bash_reload='source ~/.bash_profile'
alias systail='tail -f /var/log/system.log'
alias top='top -o cpu'
alias c='clear'
alias ip='getnet.sh'
alias q="exit"
alias cleanup='sudo periodic all'
function alias-help() {
	echo "Generic Alias Usage"
	echo
	echo " l = ls -l"
	echo " q = exit"
	echo
}

# OSX / Applications
alias preview="open -a '$PREVIEW'"
alias safari="open -a safari"
alias firefox="open -a firefox"
alias chrome="open -a google\ chrome"
alias github="open -a firefox http://www.github.com"
alias mc="memcached -vv"
alias log="~/scripts/logtodayone.rb"
# alias f='open -a Finder'
alias f='open -a Finder ./' # open current dir in Finder

# Rails aliases
alias rc='rails console'
alias rs='rails server'
alias rtp='rake db:test:prepare'
alias a='autotest -rails' # makes autotesting quicker
alias rt='rake test'
alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rti='rake test:integration'
alias rst='rake stats'
alias tlog='tail -f log/development.log'
alias rtar='sh test_all_rubies.sh'
alias rdbm='rake db:migrate'
function rails-help() {
	echo "Rails Aliases Usage"
	echo
	echo " rs   = rails server"
	echo " rc   = rails console"
	echo " rtp  = rake db:test:prepare"
	echo " a    = autotest -rails"
	echo " rt   = rake test"
	echo " rtu  = rake test:units"
	echo " rtf  = rake test:functionals"
	echo " rti  = rake test:integration"
	echo " rst  = rake stats"
	echo " tlog = tail -f log/development.log"
	echo " rtar = sh test_all_rubies.sh"
  echo " rdbm = rake db:migrate"
	echo
}
function server() {
  	# local port="${1:-8000}"
    open "http://localhost:3000/"
    script/server
}

# Git aliases
alias gs='git status'
alias gl='git log'
alias gp='git push'
alias ga='git add .'
alias gb='git branch'
alias gc='git commit'
alias gpull='git pull origin master'
function git-help() {
  echo "Git Custom Aliases Usage"
  echo
  echo " ga    = git add"
  echo " gl    = git log"
  echo " gp    = git push"
  echo " gs    = git status"
  echo " gpull = git pull origin master"
  echo " gc    = git commit"
  echo " gb    = git branch"
  echo
}

# Heroku aliases
alias gph='git push heroku master'
alias h='heroku'
alias hl='heroku list'
alias hi='heroku info'
alias ho='heroku open'
# dynos and workers
alias hd='heroku dynos'
alias hw='heroku workers'
# rake console
alias hr='heroku rake'
alias hcon='heroku console'
# new and restart
alias hnew='heroku create'
alias hrestart='heroku restart'
# logs
alias hlog='heroku logs'
alias hlogs='heroku logs'
# maint
alias hon='heroku maintenance:on'
alias hoff='heroku maintenance:off'
# heroku configs
alias hc='heroku config'
alias hca='heroku config:add'
alias hcr='heroku config:remove'
alias hcc='heroku config:clear'
function heroku-help() {
  echo "Heroku Aliases Usage"
  echo
  echo "  gph         = git push heroku master"
  echo "  h           = heroku"
  echo "  hl          = heroku list"
  echo "  hi          = heroku info"
  echo "  ho          = heroku open"
  echo "  hd          = heroku dynos"
  echo "  hw          = heroku workers"
  echo "  hr          = heroku rake"
  echo "  hcon        = heroku console"
  echo "  hnew        = heroku create"
  echo "  hrestart    = heroku restart"
  echo "  hlog        = heroku logs"
  echo "  hon         = heroku maintenance:on"
  echo "  hoff        = heroku maintenance:off"
  echo "  hc          = heroku config"
  echo "  hca         = heroku config:add"
  echo "  hcr         = heroku config:remove"
  echo "  hcc         = heroku config:clear"
  echo
}

# Directories / navigation aliases
alias rw='cd /usr/local/work'
alias rwi='cd /usr/local/work/investify'
alias rws='cd /usr/local/work/statsapp'
alias wp='cd /applications/mamp/htdocs'
alias rm='rm -i'

# Servers
alias ssha="ssh -p 30000 deploy@69.55.59.184" # Digital Ocean - arrakis - personal projects

# MySQL aliases
# alias start_mysql='sudo mysqld_safe'
# alias stop_mysql='sudo mysqladmin shutdown'
alias tunnel_mysql='ssh -p 30000 -fNg -L 8888:127.0.0.1:3306 tmarkiewicz@67.207.129.76'

# PostgreSQL
alias start_pg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias stop_pg='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias psql="psql -h localhost"

# MySQL
# http://hivelogic.com/articles/compiling-mysql-on-snow-leopard
alias start_mysql='sudo launchctl load -w /Library/LaunchDaemons/com.mysql.mysqld.plist'
alias stop_mysql='sudo launchctl unload -w /Library/LaunchDaemons/com.mysql.mysqld.plist'

# Cassandra
alias start_cassandra='cassandra_helper cassandra'

# Apache
alias restart_apache='sudo /usr/sbin/apachectl restart'
alias edit_apache='sudo nano /etc/apache2/httpd.conf'

# display battery info on your Mac
# see http://blog.justingreer.com/post/45839440/a-tale-of-two-batteries
alias battery='ioreg -w0 -l | grep Capacity | cut -d " " -f 17-50'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Set the terminal title bar to the current directory
# export TITLEBAR='\[\033]0;\w\007\]'

# set TextMate as default text editor (replacing vim)
# export EDITOR='mate -w'
export EDITOR='nano'
# for contab, via http://manual.macromates.com/en/using_textmate_from_terminal.html
# export EDITOR='mate_wait'

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

[[ -s "/Users/tmarkiewicz/.rvm/scripts/rvm" ]] && source "/Users/tmarkiewicz/.rvm/scripts/rvm" # This loads RVM into a shell session.

export PATH="/Users/tmarkiewicz/scripts:/usr/local/work/ofexport:$PATH"
export OFEXPORT_HOME="/usr/local/work/ofexport"
export PATH=$PATH:"$OFEXPORT_HOME/bin"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"