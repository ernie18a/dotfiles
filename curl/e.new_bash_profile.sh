cd ~/.G/dotfiles ; git pull
cat ~/.G/dotfiles/home/.bash_profile |sort -k2 |grep -Ev ^\#\|"\(\)"\|alias > /tmp/.bpt
cat ~/.G/dotfiles/home/.bash_profile |sort -k3 |grep -v ^\ *$ |grep -v ^\ *\# |grep -v ^\t*$ |grep -v ^\t*\# |grep -v ^$'\r' | grep -vP ^'\t*\#' |grep alias >> /tmp/.bpt        
cat ~/.G/dotfiles/home/.bash_profile |sort -k4 |grep -v ^\ *$ |grep -v ^\ *\# |grep -v ^\t*$ |grep -v ^\t*\# |grep -v ^$'\r' | grep -vP ^'\t*\#' |grep \(\) >> /tmp/.bpt
cat ~/.G/dotfiles/home/.bash_profile |grep ^\# >> ~/.G/dotfiles/home/deprecated.bash_profile
cat /tmp/.bpt |grep -v ^# > ~/.G/dotfiles/home/.bash_profile 
git rm -r --cached . > /dev/null ; git add -A ; git commit -m NBP &>/dev/null ; git push
cd -
