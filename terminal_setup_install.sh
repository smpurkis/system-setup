chmod 644 $PWD/tilda.service 

sudo apt install fish tmux tilda tmuxinator

cat $PWD/bashrc_addition >> ~/.bashrc

mkdir --parents ~/.config/fish/; mv $PWD/config.fish $_
mkdir --parents ~/.config/tmuxinator/; mv $PWD/ts.yml $_
mkdir --parents ~/.config/systemd/user/; mv $PWD/tilda.service $_

systemctl --user enable tilda.service
systemctl --user daemon-reload
echo "Reboot to have settings take effect"