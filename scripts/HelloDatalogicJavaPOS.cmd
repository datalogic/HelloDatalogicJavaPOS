@Echo Off
cls
Echo.
Echo.
Echo.
Echo    Please wait while loading the HelloDatalogicJavaPOS application...
Echo.
Echo.
REM All arguments are passed to hellodatalogicjavapos.HelloDatalogicJavaPOS

REM This uses the JavaPOS.jar installed to default location.

REM Save the user's working directory. It is restored later.
REM The actual directory pushed here is a do not care since
REM a cd is done a couple of lines below this.
pushd %cd%

REM Make the .cmd directory the current directory.
for /f "tokens=1" %%B in ('echo %~dp0') do set DRIVE=%%~dB
%DRIVE%
cd %~dp0

REM Save the .cmd directory in CMD_DIR.
set CMD_DIR=%cd%

REM Run HelloDatalogicJavaPOS.jar with the working directory the JavaPOS directory.
REM This is required for JavaPOS.jar to find jpos.xml and 
REM LabelIdentifiers.csv and other .csv files. These files are in
REM the JavaPOS directory.
cd "C:\Program Files\Datalogic\JavaPOS"
if /i %errorlevel% NEQ 0 (
echo The .cmd file failed to run successfully.
echo The directory
echo     "C:\Program Files\Datalogic\JavaPOS"
echo was not found.
goto ExitLbl
)

REM -cp has classpath directories.
REM     Look here for classes in .jar files.
REM -Djava.library.path has library directories.
REM                     Look here for .dll or .so files.
REM  hellodatalogicjavapos.HelloDatalogicJavaPOS is the 
REM  package and class with the main() to run.
REM  %%* sends all the .cmd command line parameters to the main().

java^
    -cp "%CMD_DIR%\*;C:\Program Files\Datalogic\JavaPOS\*;C:\Program Files\Datalogic\JavaPOS\SupportJars\*"^
    -Djava.library.path="C:\Program Files\Datalogic\JavaPOS";"C:\Program Files\Datalogic\JavaPOS\SupportJars"^
    hellodatalogicjavapos.HelloDatalogicJavaPOS %*

:ExitLbl
popd

if /i "%errorlevel%" NEQ "0" (
    echo errorlevel is %errorlevel%
)
