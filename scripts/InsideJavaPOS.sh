#!/usr/bin/env bash

# Clear the screen with \033c. It is ESCc, the VT100 terminal reset command.
printf "\033c"
echo --------------------------------
echo InsideJavaPOS.sh \<option\>
echo lists contents of
echo "    JavaPOS.jar"
echo "    jpos114.jar"
echo "    jpos114-controls.jar"
echo "    jpos-dls-ext.jar"
echo \<option\> is for javap. \<\> and \<-c\> are best. Run
echo "    javap -help"
echo to see all options.
echo
echo This script assumes the JDK is installed.
echo Note: You can check with
echo "    which jar"
echo "    which javap"
echo "    java -version"
echo --------------------------------

# Get the script's directory path.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Change working directory to the installed JavaPOS.
cd /usr/local/Datalogic/JavaPOS
# Store the error code from the previous command.
ERR_CODE=$?

# If there is an error then display the error code
if [ $ERR_CODE -ne 0 ]
then
    echo 
    echo The .sh file failed to run successfully.
    echo JavaPOS is not installed at the expected location.
    echo "error code is" $ERR_CODE
    exit
fi

# Change working directory to just below the scripts directory.
cd $SCRIPT_DIR/..
# Store the error code from the previous command.
ERR_CODE=$?

# If there is an error then display the error code
if [ $ERR_CODE -ne 0 ]
then
    echo 
    echo The .sh file failed to run successfully.
    echo The scripts directory does not exist.
    echo "error code is" $ERR_CODE
    exit
fi

# Remove a possibly pre-existing temp_dir.
rm -rf ./scripts/temp_dir

# Create a new temp_dir.
mkdir ./scripts/temp_dir
cd ./scripts/temp_dir

# List contents of JavaPOS.jar.
cp /usr/local/Datalogic/JavaPOS/JavaPOS.jar ./
printf "jar tvf JavaPOS.jar\n"
jar tvf JavaPOS.jar

# Extract the JavaPOS.jar MANIFEST.MF.
printf "\njar xvf ./JavaPOS.jar META-INF/MANIFEST.MF\n"
jar xvf ./JavaPOS.jar META-INF/MANIFEST.MF

printf "\ncat ./META-INF/MANIFEST.MF\n"
cat ./META-INF/MANIFEST.MF

# Remove the META-INF directory.
rm -rf ./META-INF

# List contents of jpos114.jar.
cp /usr/local/Datalogic/JavaPOS/SupportJars/jpos114.jar ./
printf "jar tvf jpos114.jar\n"
jar tvf jpos114.jar

# Extract the jpos114.jar MANIFEST.MF.
printf "\njar xvf ./jpos114.jar META-INF/MANIFEST.MF\n"
jar xvf ./jpos114.jar META-INF/MANIFEST.MF

printf "\ncat ./META-INF/MANIFEST.MF\n"
cat ./META-INF/MANIFEST.MF

# Remove the META-INF directory.
rm -rf ./META-INF

# List contents of jpos114-controls.jar.
cp /usr/local/Datalogic/JavaPOS/SupportJars/jpos114-controls.jar ./
printf "jar tvf jpos114-controls.jar\n"
jar tvf jpos114-controls.jar

# Extract the jpos114-controls.jar MANIFEST.MF.
printf "\njar xvf ./jpos114-controls.jar META-INF/MANIFEST.MF\n"
jar xvf ./jpos114-controls.jar META-INF/MANIFEST.MF

printf "\ncat ./META-INF/MANIFEST.MF\n"
cat ./META-INF/MANIFEST.MF

# Remove the META-INF directory.
rm -rf ./META-INF

# List contents of jpos-dls-ext.jar.
cp /usr/local/Datalogic/JavaPOS/SupportJars/jpos-dls-ext.jar ./
printf "jar tvf jpos-dls-ext.jar\n"
jar tvf jpos-dls-ext.jar

# Extract the jpos-dls-ext.jar MANIFEST.MF.
printf "\njar xvf ./jpos-dls-ext.jar META-INF/MANIFEST.MF\n"
jar xvf ./jpos-dls-ext.jar META-INF/MANIFEST.MF

printf "\ncat ./META-INF/MANIFEST.MF\n"
cat ./META-INF/MANIFEST.MF

# Remove the META-INF directory.
rm -rf ./META-INF

# List contents of the expected classes.
printf "\njavap $1 -constants -classpath JavaPOS.jar com.dls.jpos.common.DLSJposConst\n"
javap $1 -constants -classpath JavaPOS.jar com.dls.jpos.common.DLSJposConst

printf "\njavap $1 -constants -classpath JavaPOS.jar com.dls.jpos.interpretation.DLSScanner\n"
javap $1 -constants -classpath JavaPOS.jar com.dls.jpos.interpretation.DLSScanner

printf "\njavap $1 -constants -classpath jpos114.jar jpos.BaseControl\n"
javap $1 -constants -classpath jpos114.jar jpos.BaseControl

# Remove the ./scripts/temp_dir directory.
cd ../..
rm -rf ./scripts/temp_dir
