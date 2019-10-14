arg1=$1
arg2=$2

SCRIPT_PATH=$(dirname `which $0`)
PROJECT_PATH=$(pwd)


if [ "$arg1" == "-W" ]; then
  mkdir -p releases
  "echo" "Converting project to .love file"
  zip -r ./releases/game.love . -x './releases/*' '.*'
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

elif [ "$arg1" == "-M" ]; then
  mkdir -p releases
  "echo" "Converting project to .love file"
  zip -r ./releases/game.love . -x './releases/*' '.*'
  rm -rf $SCRIPT_PATH/temp
  cp -R $SCRIPT_PATH/mac $SCRIPT_PATH/temp
  cp $PROJECT_PATH/releases/game.love $SCRIPT_PATH/temp/mac.app/Contents/Resources
  cd $SCRIPT_PATH/temp
  zip -r -y $PROJECT_PATH/releases/mac.zip . -x './releases/*' '.*'
  rm -rf $SCRIPT_PATH/temp
  "echo" "FINISHED"
  exit 0

elif [ "$arg1" == "-L" ]; then
  mkdir -p releases
  "echo" "Converting project to .love file"
  zip -r ./releases/game.love . -x './releases/*' '.*'
  rm -rf $SCRIPT_PATH/temp
  cp -R $SCRIPT_PATH/linux $SCRIPT_PATH/temp
  cp $PROJECT_PATH/releases/game.love $SCRIPT_PATH/temp/application
  cd $SCRIPT_PATH/temp
  zip -r $PROJECT_PATH/releases/linux.zip .
  rm -rf $SCRIPT_PATH/temp
  "echo" "FINISHED"
  exit 0

elif [ "$arg1" == "-S" ]; then
  "echo" "Creating Source Code Zip"
  zip -r ./releases/source.zip . -x './releases/*' '.*'
  exit 0

else
  "echo" "INVALID PARAMETER GIVEN"
  exit 0
fi