##################################
# This is profile for basic bash #
##################################

echo "Using default bash profile"

export PROFILE="$HOME/.bashrc"

# Load default profile
[[ ! -f ~/.profile ]] || source ~/.profile

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
