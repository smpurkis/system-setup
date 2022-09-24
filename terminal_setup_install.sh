#!/usr/bin/env bash -x

# install set of requirements
sudo add-apt-repository ppa:apt-fast/stable -y
sudo apt update
sudo nala install fish tmux guake -y

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-binstall

# install terminal window manager
# for info on zellij see, https://github.com/zellij-org/zellij
cargo-binstall zellij
mkdir --parents ~/.config/zellij/layouts
mkdir --parents ~/.config/zellij/themes
cp $PWD/configs/config.yaml ~/.config/zellij/
cp $PWD/configs/main_layout.yaml ~/.config/zellij/layouts/
cp $PWD/configs/dracula.yaml ~/.config/zellij/themes/

# setup bash, fish and oh-my-fish on shell start
# for info on fish see, https://github.com/fish-shell/fish-shell
# for info on oh-my-fish see, https://github.com/oh-my-fish/oh-my-fish
# for info on starship see, https://github.com/starship/starship
cat $PWD/configs/bashrc_addition >> ~/.bashrc
mkdir --parents ~/.config/fish/
cp $PWD/configs/config.fish ~/.config/fish/
curl -sS https://starship.rs/install.sh | sh
cp $PWD/configs/starship.toml ~/.config/
# curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# install python tools, miniconda and poetry
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
conda init fish
conda config --set auto_activate_base false
conda install mamba -n base -c conda-forge
mamba init fish
mamba create --name py9 python=3.9 -y
echo "conda activate py9" >> ~/.config/fish/
curl -sSL https://install.python-poetry.org | python3 -

# setup apt fast and nala
cp completions/fish/apt-fast.fish /etc/fish/conf.d/completions/
chown root:root /etc/fish/conf.d/completions/apt-fast.fish
source /etc/fish/conf.d/completions/apt-fast.fish

# setup guake service to start on system boot
# for info on guake see, https://github.com/Guake/guake
cp $PWD/configs/guake.config ~/.config/
guake --restore-preferences ~/.config/guake.config
chmod 644 $PWD/configs/guake.service 
mkdir --parents ~/.config/systemd/user/
cp $PWD/configs/guake.service ~/.config/systemd/user/
systemctl --user enable guake.service
systemctl --user daemon-reload

# add utils scripts to start on boot
cd $PWD/util_scripts/ && poetry install && cd ..
chmod 644 $PWD/util_scripts/utils.service 
mkdir --parents ~/.config/systemd/user/
cp $PWD/util_scripts/utils.service ~/.config/systemd/user/
systemctl --user enable utils.service
systemctl --user daemon-reload

sudo mkdir -p /etc/brave/policies/managed/
cp $PWD/configs/browser_policies/brave_policy.json /etc/brave/policies/managed/
sudo mkdir -p /etc/opt/chrome/policies/managed/
cp $PWD/configs/browser_policies/chrome_policy.json /etc/opt/chrome/policies/managed/

echo "Reboot to have settings take effect"