# Arch Linux Setup

This file has setup notes for installing Arch Linux. Follow the
[installation guide](https://wiki.archlinux.org/title/Installation_guide).

After the `arch-chroot` step into the installed machine, make sure to install
the following as a base:

```bash
pacman -Syu intel-ucode neovim networkmanager man texinfo sudo
```

## Post-Install Setup

### Internet Connectivity

```bash
systemctl enable --now NetworkManager.service
nmcli device wifi list
nmcli device wifi connect <SSID> --ask
```

### Create User Accounts

```bash
useradd -m <username>
passwd <username>
# Alternatively, use the wheel group
usermod -aG sudo <username>
# Update the sudoers file to enable the sudo/wheel group
EDITOR=nvim visudo /etc/sudoers
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
pacman -Syu dolphin konsole firefox
```

### Utilities

```bash
pacman -Syu htop tmux fzf ripgrep fd git just bat git-delta
```

### Development

#### C/C++

```bash
pacman -Syu gcc clang
```

#### Rust

```bash
pacman -Syu rustup
rustup toolchain stable
```
