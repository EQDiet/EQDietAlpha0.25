@echo off
echo EQDiet Alpha 0.25 Compiler for Windows.
echo (C) 2020, Daniel Lopez Tena.
echo.

:choice
IF NOT "x%~5"=="x" GOTO help
IF /I "%~1"=="/Compile"    GOTO Compile
IF /I "%~1"=="-Compile"    GOTO Compile
IF /I "%~1"=="/Clean"      GOTO Clean
IF /I "%~1"=="-Clean"      GOTO Clean
IF /I "%~1"=="/Jar"        GOTO Jar
IF /I "%~1"=="-Jar"        GOTO Jar
IF /I "%~1"=="/Launch4j"   GOTO Launch4j
IF /I "%~1"=="-Launch4j"   GOTO Launch4j
IF /I "%~1"=="/Website"    GOTO Website
IF /I "%~1"=="-Website"    GOTO Website
IF /I "%~1"=="/?"          GOTO help
IF /I "%~1"=="-?"          GOTO help
IF    "%~1" EQU ""         GOTO help
IF /I "%~1"=="/h"          GOTO help
IF /I "%~1"=="-h"          GOTO help
IF /I "%~1"=="/Help"       GOTO help
IF /I "%~1"=="-Help"       GOTO help
echo Invalid switch: %~1
echo.
goto help

:Compile
echo Compiling EQDiet Alpha 0.25...
echo.
md Build >NUL 2>NUL
javac -verbose --release 8 src\EQDietAlpha025.java -d Build
echo.
IF EXIST Build\EQDietAlpha025.class (echo Compilation done! Check your Build folder.) else echo Error while compilating.
exit /b

:Clean
echo Cleaning files...
if exist Build (
echo.
del /s /f /q Build
rd /s /q Build >NUL 2>NUL
echo.
echo Done!
) else (
echo.
echo No need to clean.
)
exit /b

:Jar
echo Generating JAR file...
echo.
IF NOT EXIST Build\EQDietAlpha025.class (echo Compilation isn't done. Run "EQDietCompiler.bat /Compile" to compile && exit /b)
md Release >NUL 2>NUL
md Build\META-INF >NUL 2>NUL
cd Build
echo Manifest-Version: 1.0 >META-INF\MANIFEST.MF
echo Class-Path: . >>META-INF\MANIFEST.MF
echo Main-Class: EQDietAlpha025 >>META-INF\MANIFEST.MF
jar cvmf META-INF\MANIFEST.MF ..\Release\EQDietAlpha0.25.jar *.class
cd..
IF EXIST Release\EQDietAlpha0.25.jar (echo. && echo JAR file successfully generated at Release folder!) else echo. && echo Error generating JAR file
rd /s /q Build\META-INF
exit /b

:Launch4j
echo Downloading Launch4j...
echo.
Tools\wget.exe --no-check-certificate https://eqdiet.weebly.com/uploads/1/2/2/7/122786941/launch4j-3.12-win32.exe && move /Y launch4j-3.12-win32.exe %temp%
echo.
echo Installing Launch4j...
echo.
%TEMP%\launch4j-3.12-win32.exe /S
IF ERRORLEVEL ==1 (echo. && echo Error while installing Launch4j.) else (echo Launch4j has been successfully installed in your PC!)
del %TEMP%\launch4j-3.12-win32.exe
exit /b

:Website
echo | set /p website= "Redirecting to eqdiet.weebly.com... "
start https://eqdiet.weebly.com
echo | set /p website= "Done!"
echo.
exit /b

:Help
echo --------------------------------------------------------------------------------
echo Abstract: This batch file compiles EQDiet Alpha 0.25. Usage:
echo.
echo "EQDietCompiler.bat [/Compile | /Clean | /Jar | /Launch4j | /Website | /Help]"
echo.
echo             /Compile   - Compiles EQDiet Alpha 0.25 source code
echo             /Clean     - Cleans the compiled source folder (release folder)
echo             /Jar       - Creates the jar file from compiled source code
echo             /Launch4j  - Downloads and install Launch4j (Jar to exe compiler)
echo             /Website   - Redirects to EQDiet's website
echo             /Help      - Shows this message screen
echo.
echo --------------------------------------------------------------------------------
exit /b
