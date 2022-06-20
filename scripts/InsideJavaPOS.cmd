@echo off
cls
@echo.
@echo --------------------------------
@echo InsideJavaPOS.cmd ^<option^>
@echo lists contents of
@echo     JavaPOS.jar
@echo     jpos114.jar
@echo     jpos114-controls.jar
@echo     jpos-dls-ext.jar
@echo ^<option^> is for javap. ^<^> and ^<-c^> are best. Run
@echo     javap -help
@echo to see all options.
@echo.
@echo This script assumes Datalogic JavaPOS is installed at
@echo     C:\Program Files\Datalogic\JavaPOS
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

REM Remove a possibly pre-existing temp_dir.
rmdir /S /Q temp_dir 2>NUL
REM Create a empty temp_dir.
mkdir temp_dir 2>NUL

REM temp_dir is a non-admin directory.
REM In a non-admin directory MANIFEST.MF can be extracted.
copy "C:\Program Files\Datalogic\JavaPOS\JavaPOS.jar" temp_dir 1>NUL
if /i %errorlevel% NEQ 0 (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo The directory
    @echo     "C:\Program Files\Datalogic\JavaPOS"
    @echo likely does not exist.
    goto ExitLbl
)


REM List contents of JavaPOS.jar.
cd temp_dir
@echo on
jar tvf JavaPOS.jar
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely javac is not in the path.
    @echo See "Note:" above.
    goto ExitLbl
)

REM List contents of JavaPOS.jar MANIFEST.MF.
REM Remove a possibly pre-existing META-INF directory.
rmdir /S /Q META-INF 2>NUL
@echo on
jar xvf JavaPOS.jar META-INF/MANIFEST.MF
type META-INF\MANIFEST.MF
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely JavaPOS.jar does not contain a MANIFEST.MF file.
    goto ExitLbl
)
cd ..
del temp_dir\JavaPOS.jar 2>NUL

copy "C:\Program Files\Datalogic\JavaPOS\SupportJars\jpos114.jar" temp_dir 1>NUL

REM List contents of jpos114.jar.
cd temp_dir
@echo on
jar tvf jpos114.jar
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely javac is not in the path.
    @echo See "Note:" above.
    goto ExitLbl
)

REM List contents of jpos114.jar MANIFEST.MF.
REM Remove the pre-existing META-INF directory.
rmdir /S /Q META-INF 2>NUL
@echo on
jar xvf jpos114.jar META-INF/MANIFEST.MF
type META-INF\MANIFEST.MF
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely jpos114.jar does not contain a MANIFEST.MF file.
    goto ExitLbl
)
cd ..
del temp_dir\jpos114.jar 2>NUL

copy "C:\Program Files\Datalogic\JavaPOS\SupportJars\jpos114-controls.jar" temp_dir 1>NUL

REM List contents of jpos114-controls.jar.
cd temp_dir
@echo on
jar tvf jpos114-controls.jar
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely javac is not in the path.
    @echo See "Note:" above.
    goto ExitLbl
)

REM List contents of jpos114-controls.jar MANIFEST.MF.
REM Remove the pre-existing META-INF directory.
rmdir /S /Q META-INF 2>NUL
@echo on
jar xvf jpos114-controls.jar META-INF/MANIFEST.MF
type META-INF\MANIFEST.MF
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely jpos114-controls.jar does not contain a MANIFEST.MF file.
    goto ExitLbl
)
cd ..
del temp_dir\jpos114-controls.jar 2>NUL

copy "C:\Program Files\Datalogic\JavaPOS\SupportJars\jpos-dls-ext.jar" temp_dir 1>NUL

REM List contents of jpos-dls-ext.jar.
cd temp_dir
@echo on
jar tvf jpos-dls-ext.jar
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely javac is not in the path.
    @echo See "Note:" above.
    goto ExitLbl
)

REM List contents of jpos-dls-ext.jar MANIFEST.MF.
REM Remove the pre-existing META-INF directory.
rmdir /S /Q META-INF 2>NUL
@echo on
jar xvf jpos-dls-ext.jar META-INF/MANIFEST.MF
type META-INF\MANIFEST.MF
@echo off
if /i "%errorlevel%" NEQ "0" (
    @echo.
    @echo The .cmd file failed to run successfully.
    @echo It is likely jpos-dls-ext.jar does not contain a MANIFEST.MF file.
    goto ExitLbl
)
cd ..
del temp_dir\jpos-dls-ext.jar 2>NUL

REM Remove the temp_dir.
rmdir /S /Q temp_dir 2>NUL

cd "C:\Program Files\Datalogic\JavaPOS"
C: 1>NUL
REM List contents of some of the expected classes.
@echo You may want to add lines like the following for other classes.
@echo on
javap %1 -constants -classpath JavaPOS.jar com.dls.jpos.common.DLSJposConst
javap %1 -constants -classpath JavaPOS.jar com.dls.jpos.interpretation.DLSScanner
@echo off
cd SupportJars
@echo You may want add lines like the following for other classes.
@echo on
javap %1 -constants -classpath jpos114.jar jpos.BaseControl
@echo off

:ExitLbl
popd

if /i "%errorlevel%" NEQ "0" (
    @echo errorlevel is %errorlevel%
)
