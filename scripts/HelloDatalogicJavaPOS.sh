#!/usr/bin/env bash

# All arguments are passed to hellodatalogicjavapos.HelloDatalogicJavaPOS

# This uses the JavaPOS.jar installed to default location.

# Save the user's working directory. It is restored later.
ENTRY_DIR=$PWD

# Get the script's directory path.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Change working directory to JavaPOS directory.
# This is need to make JavaPOS.jar 1.14.060's file
#  access of ./LabelIdentifiers.csv work.
cd /usr/local/Datalogic/JavaPOS

# paths:
#   local
#   JavaPOS
#   JavaPOS SupportJars

java \
    -cp "$SCRIPT_DIR/*:/usr/local/Datalogic/JavaPOS/*:/usr/local/Datalogic/JavaPOS/SupportJars/*" \
    -Djava.library.path=$SCRIPT_DIR \
    -Djava.library.path=$SCRIPT_DIR:/usr/local/Datalogic/JavaPOS \
    -Djava.library.path=$SCRIPT_DIR:/usr/local/Datalogic/JavaPOS/SupportJars \
    hellodatalogicjavapos.HelloDatalogicJavaPOS ${@}

# Store the error code from running HelloDatalogicJavaPOS.jar.
ERR_CODE=$?

# Restore the user's working directory.
cd $ENTRY_DIR

# If there is an error then display the error code
if [ $ERR_CODE -ne 0 ]
then
    echo "error code is" $ERR_CODE
fi
