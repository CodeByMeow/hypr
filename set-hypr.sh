#### Check for yay ####
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
    echo -e "yay was located, moving on.\n"
    yay -Suy --noconfirm
else 
    echo -e "yay was not located, please install yay. Exiting script.\n"
    exit 
fi

### Install all of the above pacakges ####
read -n1 -rep 'Would you like to install the packages? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
yay -S --noconfirm foot nushell hyprland hyprshot hyprpicker \
    swaybg swaylock-effects wofi wlogout mako waybar-hyprland waybar-updates wireplumber \
    ttf-jetbrains-mono-nerd ttf-victor-mono-nerd \
    polkit-gnome python-requests starship \
    swappy slurp pamixer brightnessctl gvfs \
    bluez bluez-utils blueman nwg-look-bin xfce4-settings \
    bettergruvbox-gtk-theme reversal-icon-theme-git bibata-cursor-theme xdg-desktop-portal-hyprland \
    xclip nodejs npm ripgrep neovim tree-sitter-cli tmux yazi \
    xdg-user-dirs wl-clipboard ly networkmanager rofi tumbler youtube-music-bin firefox

    # Noto fonts
    sudo pacman -S --noconfirm $(pacman -Ssq noto-fonts)

    echo -e "Reload font...\n"
    cp -R .fonts ~
    fc-cache -fv

    # Start the bluetooth service
    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
    
    # Clean out other portals
    echo -e "Cleaning out conflicting xdg portals...\n"
    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk
fi

### Create user folder ###
read -n1 -rep 'Would you like to create user foler? (y,n)' USRDIR
if [[ $USRDIR == "Y" || $USRDIR == "y" ]]; then
    xdg-user-dirs-update
    echo -e ":: User directory created.\n"
fi

### Copy Config Files ###
read -n1 -rep 'Would you like to copy config files? (y,n)' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "Copying config files...\n"
    cp -R .config/* ~/.config/
    
    # Set some files as exacutable 
    chmod +x ~/.config/hypr/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/weather.py
    chmod +x ~/.config/waybar/scripts/network/rofi-network-manager.sh
fi

### Script is done ###
echo -e "Script had completed.\n"
echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"
read -n1 -rep 'Would you like to start Hyprland now? (y,n)' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec Hyprland
else
    exit
fi
