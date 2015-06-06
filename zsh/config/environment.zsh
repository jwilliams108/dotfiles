# for local Python
if [ -d /usr/local/lib/python2.7/site-packages ]; then
  export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
fi

# local java
if [ -d ~/.java/lib ]; then
  export CLASSPATH=~/.java/lib:$CLASSPATH
fi

# for XQuartz
if [ -d /usr/X11 ]; then
  export PATH=/usr/X11/bin:$PATH
fi

# for mactex
if [ -d /usr/texlive ]; then
  export PATH=/usr/texlive/bin/x86_64-darwin:$PATH
fi

# for nvm
if [ -d ~/.nvm ]; then
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
fi

# for perlbrew
if [ -d ~/.perl5/perlbrew ]; then
  source $HOME/.perl5/perlbrew/etc/bashrc
  #export PATH=$HOME/.perl5/perlbrew/bin:$PATH
  export PERLBREW_ROOT=$HOME/.perl5/perlbrew
fi

# for phpbrew
if [ -d ~/.phpbrew ]; then
  source $HOME/.phpbrew/bashrc
fi

# for groovy
if [ -d /usr/local/opt/groovy/libexec ]; then
  export GROOVY_HOME=/usr/local/opt/groovy/libexec
fi

# make sure local takes precendence
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# editor and utils
export EDITOR=vim
export PAGER=less
export COPYFILE_DISABLE=1
