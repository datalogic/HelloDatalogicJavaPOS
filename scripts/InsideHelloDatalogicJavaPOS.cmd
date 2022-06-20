@echo off
cls
@echo.
@echo --------------------------------
@echo InsideHelloDatalogicJavaPOS.cmd ^<option^>
@echo lists contents of
@echo     HelloDatalogicJavaPOS.jar
@echo ^<option^> is for javap. ^<^> and ^<-c^> are best. Run
@echo     javap -help
@echo to see all options.
@echo.
@echo This script assumes the installed JDK's bin dir is in the path.
@echo Note: You can temporarily update the path at the Command Prompt.
@echo Add your JDK bin path by running something like:
@echo     path = C:\Program Files\Java\jdk1.8.0_231\bin;%%path%%
@echo --------------------------------

REM Make the .cmd directory the current directory.
for /f "tokens=1" %%B in ('echo %~dp0') do set DRIVE=%%~dB
%DRIVE%
cd %~dp0

REM Save the .cmd directory. It is restored later.
pushd %cd%

cd ..\dist_via_jdk
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo The ..\dist_via_jdk directory does not exist.
    @echo Run BuildHelloDatalogicJavaPOS.cmd to create ..\dist_via_jdk.
    goto ExitLbl
)

REM List contents of HelloDatalogicJavaPOS.jar.
@echo on
jar tvf HelloDatalogicJavaPOS.jar
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely javac is not in the path.
    @echo See "Note:" above.
    goto ExitLbl
)

REM List contents of HelloDatalogicJavaPOS.jar MANIFEST.MF.
REM Remove a possibly pre-existing temp_dir.
rmdir /S /Q temp_dir 2>NUL
REM Create a empty temp_dir.
mkdir temp_dir 2>NUL
cd temp_dir
@echo on
jar xvf ..\HelloDatalogicJavaPOS.jar META-INF/MANIFEST.MF
type META-INF\MANIFEST.MF
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely HelloDatalogicJavaPOS.jar does not contain a MANIFEST.MF file.
    goto ExitLbl
)
cd ..
rmdir /S /Q temp_dir 2>NUL

REM List contents of the expected classes.
@echo on
javap %1 -constants -classpath HelloDatalogicJavaPOS.jar hellodatalogicjavapos.HelloDatalogicJavaPOS
@echo off

cd ..\scripts

:ExitLbl
popd

if /i "%errorlevel%" NEQ "0" (
    @echo errorlevel is %errorlevel%
)
