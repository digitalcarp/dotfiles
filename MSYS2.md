# MSYS2

Prefer the UCRT64 environment.

## UCRT64

```bash
pacman -Syu git tmux mingw-w64-ucrt-x86_64-neovim mingw-w64-ucrt-x86_64-gcc 
```

### CLI Utilties

```bash
pacman -Syu mingw-w64-ucrt-x86_64-fzf mingw-w64-ucrt-x86_64-ripgrep mingw-w64-ucrt-x86_64-fd mingw-w64-ucrt-x86_64-just
```

### C/C++

```bash
pacman -Syu mingw-w64-ucrt-x86_64-clang mingw-w64-ucrt-x86_64-make mingw-w64-ucrt-x86_64-ninja mingw-w64-ucrt-x86_64-cmake mingw-w64-ucrt-x86_64-gdb mingw-w64-ucrt-x86_64-cppcheck
```

### Python

```bash
pacman -Syu mingw-w64-ucrt-x86_64-python-uv
```

### RawTherapee

```bash
pacman -Syu mingw-w64-ucrt-x86_64-pkg-config mingw-w64-ucrt-x86_64-gtkmm3 mingw-w64-ucrt-x86_64-fftw mingw-w64-ucrt-x86_64-exiv2 \
    mingw-w64-ucrt-x86_64-libiptcdata mingw-w64-ucrt-x86_64-lcms2 mingw-w64-ucrt-x86_64-lensfun
```

## Windows Terminal Settings

```json
...
"defaultProfile": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
...
"profiles": 
    {
        "defaults": 
        {
            "colorScheme": "Gruvbox Dark"
        },
        "list": 
        [
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell"
            },
            {
                "commandline": "%SystemRoot%\\System32\\cmd.exe",
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "name": "Command Prompt"
            },
            {
                "commandline": "C:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64 -shell bash",
                "font": 
                {
                    "size": 18
                },
                "guid": "{bcc64323-fc63-410f-8f6c-db8069002cab}",
                "hidden": false,
                "icon": "C:/msys64/mingw64.ico",
                "name": "MINGW64",
                "startingDirectory": "C:/msys64/home/%USERNAME%"
            },
            {
                "commandline": "C:/msys64/msys2_shell.cmd -defterm -here -no-start -ucrt64 -shell bash",
                "font": 
                {
                    "size": 18
                },
                "guid": "{84ba1022-d2c7-48e8-bba3-1332c5f33a0e}",
                "hidden": false,
                "icon": "C:/msys64/ucrt64.ico",
                "name": "UCRT64",
                "startingDirectory": "C:/msys64/home/%USERNAME%"
            }
        ]
    },
    "schemes": 
    [
        {
            "background": "#282828",
            "black": "#282828",
            "blue": "#458588",
            "brightBlack": "#928374",
            "brightBlue": "#83A598",
            "brightCyan": "#8EC07C",
            "brightGreen": "#B8BB26",
            "brightPurple": "#D3869B",
            "brightRed": "#FB4934",
            "brightWhite": "#EBDBB2",
            "brightYellow": "#FABD2F",
            "cursorColor": "#FFFFFF",
            "cyan": "#689D6A",
            "foreground": "#EBDBB2",
            "green": "#98971A",
            "name": "Gruvbox Dark",
            "purple": "#B16286",
            "red": "#CC241D",
            "selectionBackground": "#FFFFFF",
            "white": "#A89984",
            "yellow": "#D79921"
        }
    ],
...
```
