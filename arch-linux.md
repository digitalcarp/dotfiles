# Arch Linux Setup

This file has setup notes for installing Arch Linux. Follow the
[installation guide](https://wiki.archlinux.org/title/Installation_guide).

After the `arch-chroot` step into the installed machine, make sure to install
the following as a base:

```bash
pacman -Syu intel-ucode neovim networkmanager man texinfo sudo
```

## Post-Install Setup

### Create User Accounts

```bash
useradd -m <username>
passwd <username>
# Alternatively, use the wheel group
usermod -aG sudo <username>
# Update the sudoers file to enable the sudo/wheel group
EDITOR=nvim visudo /etc/sudoers
```

### Internet Connectivity

```bash
# Initialize /etc/hosts
cp etc/hosts /etc/hosts

# Enable NetworkManager and connect to WiFi
systemctl disable systemd-networkd.service
systemctl enable --now NetworkManager.service
nmcli device wifi list
nmcli device wifi connect <SSID> --ask
```

### Utilities

```bash
pacman -Syu openssh
ssh-keygen -t ed25519 -C <email>
systemctl enable --now sshd.service
ssh-add ~/.ssh/id_ed25519
# Add SSH key to GitHub
cat ~/.ssh/id_ed25519.pub

# Install nftables and uninstall iptables
pacman -Syu iptables-nft
cp /etc/nftables.conf /etc/nftables.conf.bak
cp etc/nftables.conf /etc/nftables.conf
systemctl enable --now nftables.service

# Enable periodic TRIM for SSDs
sudo systemctl enable --now fstrim.timer
```

```bash
pacman -Syu tmux fzf ripgrep fd git just bat git-delta glow \
  htop unzip ffmpeg imagemagick gettext tree
```

#### AUR Helper

```bash
pacman -Syu base-devel
mkdir ~/aur
cd !$
# Check with https://aur.archlinux.org/packages/yay
git clone https://aur.archlinux.org/yay.git
cd yay
less PKGBUILD
makepkg --syncdeps --install --clean
```

#### Non-`pacman`/`yay` Executables

For non-`pacman`/`yay` installs, use a whitelisted directory of executables for
improved safety (i.e. accidentally overriding some command).

```bash
mkdir -p ~/tools/bin
echo "export PATH=$PATH:$HOME/tools/bin" >> ~/.bashrc
```

### Graphics Driver

```bash
pacman -Syu nvidia-open nvidia-utils
```

### KDE Plasma

```bash
pacman -Syu sddm plasma-desktop
```

Setup SDDM by creating `/etc/sddm.conf.d/autologin.conf`.
```bash
[Autologin]
User=username
Session=Plasma (Wayland)
```

```bash
pacman -Syu sddm-kcm brightnessctl kscreen kgamma plasma-nm plasma-pa \
  phonon-qt6-vlc
pacman -Syu ffmpegthumbs kdegraphics-thumbnailers kimageformats kio-extras \
  icoutils noto-sans noto-color-emoji qt-imageformats

pacman -Syu powerdevil power-profiles-daemon
systemctl enable --now power-profiles-daemon.service
```

#### GUI Apps

```bash
pacman -Syu dolphin konsole firefox vlc okular spectacle gwenview
```

#### Font

```bash
pacman -Syu ttf-dejavu-nerd ttf-roboto noto-fonts noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
```

##### Manual Install

Install DejaVuSansM Nerd Font from [here](https://www.nerdfonts.com/font-downloads).

```bash
mkdir /usr/local/share/fonts
cp *.ttf /usr/local/share/fonts
```

Set fonts using system settings and konsole.

### Development

#### C/C++

```bash
pacman -Syu gcc clang cmake ninja gdb
```

#### Python

```bash
pacman -Syu python uv
```

#### Rust

```bash
pacman -Syu rustup
rustup toolchain stable
```

### Key Mappings

```bash
yay -Syu kanata

# Create user/group for kanata to read uinput (must be system group)
groupadd -r uinput
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' > /etc/udev/rules.d/99-kanata.rules
useradd --no-create-home --groups input,uinput --shell /bin/false --user-group kanata

mkdir /etc/kanata
# Use the version provided by dotfile repo
cp <config>.kbd /etc/kanata/kanata.kbd

# See dotfiles/etc/systemd/system/kanata.service
cp kanata.service /etc/systemd/system/kanata.service
systemctl enable --now kanata.service
```

## GRUB

If dual-booting, pick one of the following GRUB themes and follow the instructions to install the theme.

* [krypciak/crossgrub](https://github.com/krypciak/crossgrub)

Modify the following lines in `/etc/default/grub`:

```
GRUB_DEFAULT="saved"
GRUB_THEME="/boot/grub/themes/crossgrub/theme.txt"
GRUB_SAVED_DEFAULT="true"
```

Apply changes by running `sudo grub-mkconfig -o /boot/grub/grub.cfg`.
