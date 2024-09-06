#! /bin/bash

all_steps=16
curr_step=1

home=$HOME

step() {
  if (( curr_step < 10 )); then
    echo "[ $curr_step/$all_steps] $1"
  else
    echo "[$curr_step/$all_steps] $1"
  fi

  ((curr_step++))
}

step "Copy kitty config."

# -p to only create if it doesn't exist already.
mkdir -p $home/.config/kitty/
cp ./kitty/kitty.conf $home/.config/kitty/kitty.conf

step "Copy browser config."

mkdir -p $home/.mozilla/firefox/*.default-release/chrome
cp ./browser/userChrome.css $home/.mozilla/firefox/*.default-release/chrome/userChrome.css

step "Change kitty theme."

kitten themes Atelier Cave Dark

step "Installing Oh My Zsh."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &> /dev/null

step "Change shell to zsh."

if ! pacman -Qs "zsh" > /dev/null ; then
  sudo pacman -S --noconfirm zsh > /dev/null
fi

if [[ "$SHELL" != "/usr/bin/zsh" ]] ; then
  sudo chsh -s /usr/bin/zsh $(whoami) > /dev/null
fi

step "Copy zsh config."

cp ./zsh/.zshrc $home/.zshrc

step "Copy neovim config."

mkdir -p $home/.config/nvim/
cp ./nvim/init.lua $home/.config/nvim/init.lua

step "Installing node version manager."

curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh > /dev/null | bash > /dev/null

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

step "Installing node."

nvm install node &> /dev/null

step "Installing keyd."

if ! pacman -Qs "keyd" > /dev/null ; then
  sudo pacman -S --noconfirm keyd > /dev/null
fi

step "Copy keyd config."

sudo cp ./keyd/config.conf /etc/keyd/default.conf

step "Enable keyd."

sudo keyd reload
sudo systemctl enable keyd
sudo systemctl start keyd

step "Copy niri config."

mkdir -p $home/.config/niri
cp ./niri/config.kdl $home/.config/niri/config.kdl

step "Copy pacman config."

sudo cp ./pacman/pacman.conf /etc/pacman.conf

step "Installing vim-plug."

sh -c 'curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null'

step "Installing vim plugins."

nvim +PlugInstall +qall

echo
echo "Done!"
echo

echo "Manual to-do list:"
echo "  enable user stylesheet in firefox in about:config"
