#!/usr/bin/env bash

# Clear the screen with \033c. It is ESCc, the VT100 terminal reset command.
printf "\033c"
echo --------------------------------
echo InsideHelloDatalogicJavaPOS.sh \<option\>
echo lists contents of
echo     HelloDatalogicJavaPOS.jar
echo \<option\> is for javap. \<\> and \<-c\> are best. Run
echo     javap -help
echo to see all options.
echo
echo This script assumes the JDK is installed.
echo Note: You can check with
echo     which jar
echo     which javap
echo     java -version
echo --------------------------------

# Get the script's directory path.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Change working directory to the /dist_via_jdk directory.
cd $SCRIPT_DIR/../dist_via_jdk
# Store the error code from the previous command.
ERR_CODE=$?

# If there is an error then display the error code
if [ $ERR_CODE -ne 0 ]
then
    echo 
    echo The .sh file failed to run successfully.
    echo The dist_via_jdk directory does not exist.
    echo Run BuildHelloDatalogicJavaPOS.sh to create ../dist_via_jdk.
    echo "error code is" $ERR_CODE
    exit
fi

# List contents of HelloDatalogicJavaPOS.jar.
printf "jar tvf HelloDatalogicJavaPOS.jar\n"
jar tvf HelloDatalogicJavaPOS.jar

# Remove a possibly pre-existing temp_dir.
cd ..
rm -rf ./scripts/temp_dir

# Create a new temp_dir.
mkdir ./scripts/temp_dir

# Extract the HelloDatalogicJavaPOS.jar MANIFEST.MF.
cd ./scripts/temp_dir
cp ../../dist_via_jdk/HelloDatalogicJavaPOS.jar ./
printf "\njar xvf ../HelloDatalogicJavaPOS.jar META-INF/MANIFEST.MF"
jar xvf ./HelloDatalogicJavaPOS.jar META-INF/MANIFEST.MF

printf "cat ./META-INF/MANIFEST.MF\n"
cat ./META-INF/MANIFEST.MF

# Remove the META-INF directory.
rm -rf ./META-INF

# List contents of the expected classes.
printf "javap $1 -constants -classpath HelloDatalogicJavaPOS.jar hellodatalogicjavapos.HelloDatalogicJavaPOS\n"
javap $1 -constants -classpath HelloDatalogicJavaPOS.jar hellodatalogicjavapos.HelloDatalogicJavaPOS

# Remove the ./scripts/temp_dir directory.
cd ../..
rm -rf ./scripts/temp_dir
