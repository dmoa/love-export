arg1=$1
arg2=$2

SCRIPT_PATH=$(dirname `which $0`)
PROJECT_PATH=$(pwd)

function lovefile {
  mkdir -p releases
  "echo" "Converting project to .love file"
  zip -r ./releases/game.love . -x './releases/*' '.*'
}

function windows {
  rm -rf $SCRIPT_PATH/temp
  cp -R $SCRIPT_PATH/win $SCRIPT_PATH/temp
  cp $PROJECT_PATH/releases/game.love $SCRIPT_PATH/temp
  cat $SCRIPT_PATH/temp/love.exe $SCRIPT_PATH/temp/game.love > $SCRIPT_PATH/temp/game.exe
  rm $SCRIPT_PATH/temp/game.love
  rm $SCRIPT_PATH/temp/love.exe
  cd $SCRIPT_PATH/temp/
  zip -r $PROJECT_PATH/releases/windows.zip .
  rm -rf $SCRIPT_PATH/temp
  "echo" "FINISHED"
}

function mac {
  rm -rf $SCRIPT_PATH/temp
  cp -R $SCRIPT_PATH/mac $SCRIPT_PATH/temp
  cp $PROJECT_PATH/releases/game.love $SCRIPT_PATH/temp/mac.app/Contents/Resources
  cd $SCRIPT_PATH/temp
  zip -r -y $PROJECT_PATH/releases/mac.zip . -x './releases/*' '.*'
  rm -rf $SCRIPT_PATH/temp
  "echo" "FINISHED"
}

function linux {
  rm -rf $SCRIPT_PATH/temp
  cp -R $SCRIPT_PATH/linux $SCRIPT_PATH/temp
  cp $PROJECT_PATH/releases/game.love $SCRIPT_PATH/temp/application
  cd $SCRIPT_PATH/temp
  zip -r $PROJECT_PATH/releases/linux.zip .
  rm -rf $SCRIPT_PATH/temp
  "echo" "FINISHED"
}

if [ "$arg1" == "-W" ]; then
  lovefile
  "echo" "Exporting project to Windows"
  windows
  exit 0

elif [ "$arg1" == "-M" ]; then
  lovefile
  "echo" "Exporting project to Mac"
  mac
  exit 0

elif [ "$arg1" == "-L" ]; then
  lovefile
  "echo" "Exporting project to Linux"
  exit 0

elif [ "$arg1" == "-D" ]; then
  lovefile
  "echo" "Exporting project to Windows, Mac, and Linux"
  windows 
  mac
  linux
  exit 0

elif  [ "$arg1" == "-LF" ]; then
  lovefile
  exit 0

elif [ "$arg1" == "-S" ]; then
  "echo" "Creating Source Code Zip"
  zip -r ./releases/source.zip . -x './releases/*' '.*'
  exit 0

elif [ "$arg1" == "-IL" ]; then
  if [ -n "$arg2" ]; then
    cd $SCRIPT_PATH
    rm -rf win
    curl -L -O https://bitbucket.org/rude/love/downloads/love-$arg2-win64.zip
    unzip love-$arg2-win64.zip
    mv *win64 win
    rm love-$arg2-win64.zip
    cd win 
    rm love.ico
    rm game.ico
    rm lovec.exe
    rm readme.txt
    rm license.txt
    rm changes.txt

    cd ..
    rm -rf mac
    mkdir mac
    cd mac
    curl -L -O https://bitbucket.org/rude/love/downloads/love-$arg2-macos.zip
    unzip love-$arg2-macos.zip
    mv love.app mac.app
    rm love-$arg2-macos.zip

    cd ..
    rm -rf linux
    mkdir linux 
    cd linux
    touch runme
    echo "./application/love" > runme
    chmod +x runme
    curl -L -O https://bitbucket.org/rude/love/downloads/love-$arg2-x86_64.tar.gz
    tar -zxvf *.tar.gz
    rm *.tar.gz
    mv dest application
    cd application
    echo "#!/bin/sh
          export LOVE_LAUNCHER_LOCATION="$(dirname "$(which "$0")")"
          export LD_LIBRARY_PATH="${LOVE_LAUNCHER_LOCATION}/lib/x86_64-linux-gnu:${LOVE_LAUNCHER_LOCATION}/usr/bin:${LOVE_LAUNCHER_LOCATION}/usr/lib:${LOVE_LAUNCHER_LOCATION}/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
          /sbin/ldconfig -p | grep -q libstdc++ || export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${LOVE_LAUNCHER_LOCATION}/libstdc++/"
          exec ${LOVE_BIN_WRAPPER} "${LOVE_LAUNCHER_LOCATION}/usr/bin/love" "${LOVE_LAUNCHER_LOCATION}/game.love"" > love
    chmod +x love

    exit 0
  
  else
    "echo" "DID NOT GIVE 2ND PARAMETER (2ND PARAMETER MUST BE VERSION NUMBER)"
    exit 0
  fi

elif [ "$arg1" == "-H" ]; then
  "echo" "
  Commands:

    -W
    release for Windows

    -M 
    release for Mac

    -L
    release for Linux

    -D
    release for Desktop (Windows, Mac, and Linux)

    -LF
    release for .love file

    -S
    release for Source Code

    -IL
    download Windows, Mac, and Linux versions of love


  - by Stan O (https://stan.xyz)
  - Repository at https://github.com/dmoa/love-export
  - Problems? Open an issue on github, or contact me on discord @dmoa#0001
  "
  exit 0

else
  "echo" "INVALID PARAMETER GIVEN"
  exit 0
fi
