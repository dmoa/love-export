# love-export

love-export is a script that exports LOVE2D games to desktop

## Installation

Run the following in terminal (windows users need [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) or [Cygwin](https://www.cygwin.com/))

```bash
curl -s -L https://github.com/dmoa/love-export/releases/download/v1.2/install.sh | bash
```

## Dependencies

```bash
zip
unzip
```

## Usage

```bash
love-export -IL 11.3 # Install LOVE2D Version 11.3 [run on installation]

love-export -W       # Windows
love-export -M       # Mac
love-export -L       # Linux
love-export -D       # Windows, Mac, and Linux

love-export -LF      # .love file
love-export -S       # source code

love-export -H       # print available commands
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[GPL](https://choosealicense.com/licenses/gpl-3.0/)