@echo off
cls
@echo.
@echo --------------------------------
@echo BuildHelloDatalogicJavaPOS.cmd builds
@echo     HelloDatalogicJavaPOS.jar
@echo and puts it and support files in the ..\dist_via_jdk directory.
@echo The .class files are put in the ..\build_via_jdk directory.
@echo.
@echo BuildHelloDatalogicJavaPOS.cmd does not use NetBeans.
@echo It only uses the JDK's javac and jar to build the .jar.
@echo.
@echo This script assumes the installed JDK's bin dir is in the path.
@echo Note: You can temporarily update the path at the Command Prompt.
@echo Add your JDK bin path with something like the following.
@echo     path = C:\Program Files\Java\jdk1.8.0_231\bin;%%path%%
@echo --------------------------------

REM Make the .cmd directory the current directory.
for /f "tokens=1" %%B in ('echo %~dp0') do set DRIVE=%%~dB
%DRIVE%
cd %~dp0

REM Save the .cmd directory. It is restored later.
pushd %cd%

cd ..\src
REM Compile the .java file to a .class file.
@echo on
javac @..\scripts\javac_params.txt
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely javac is not in the path.
    @echo See "Note:" above.
    goto ExitLbl
)

REM Build the .class file(s) into the .jar file along with a manifest.
REM The manifest states the main class.
@echo on
jar -cvfe HelloDatalogicJavaPOS.jar HelloDatalogicJavaPOS hellodatalogicjavapos/*.class
@echo off

cd ..
REM Remove a possibly pre-existing dist_via_jdk
rmdir /S /Q dist_via_jdk 2>NUL
REM Create a new clean dist_via_jdk.
mkdir dist_via_jdk 2>NUL
cd dist_via_jdk
REM Un-REM the pause to verify dist_via_jdk is empty.
REM pause

REM Populate dist_via_jdk.
move /y ..\src\HelloDatalogicJavaPOS.jar 1>NUL
copy /y ..\scripts\HelloDatalogicJavaPOS.cmd 1>NUL
copy /y ..\scripts\HelloDatalogicJavaPOS.sh 1>NUL
copy /y ..\interface_configuration\jpos.xml 1>NUL

cd ..

REM Remove a possibly pre-existing dist_via_jdk.
rmdir /S /Q build_via_jdk 2>NUL
REM Create a new clean build_via_jdk.
mkdir build_via_jdk 2>NUL
cd build_via_jdk
REM Un-REM the pause to verify build_via_jdk is clean.
REM pause

REM Populate build_via_jdk.
move /y ..\src\hellodatalogicjavapos\*.class 1>NUL

cd ..\scripts

REM dir ..\dist
@echo.
@echo Look at the ..\dist_via_jdk directory.

:ExitLbl
popd

if /i "%errorlevel%" NEQ "0" (
    @echo errorlevel is %errorlevel%
)
