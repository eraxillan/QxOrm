REM -- BATCH DEFAULT PARAMETERS --
set QT_DIR=%QT5_8_MSVC2015_64B%
set PATH=%QT_DIR%\bin;%PATH%
set MSVC_CONFIG=Debug
set CL=/MP
set BATCH_TYPE=full
set CMAKE_OPTIONS=-D_QX_UNITY_BUILD=1

REM -- CHECK BATCH COMMAND LINE OPTIONS --
if "%1"=="release" set MSVC_CONFIG=Release
if "%2"=="minimal" set BATCH_TYPE=%2
if "%BATCH_TYPE%"=="full" set CMAKE_OPTIONS=%CMAKE_OPTIONS% -D_QX_ENABLE_BOOST=1 -D_QX_ENABLE_QT_GUI=1 -D_QX_ENABLE_QT_NETWORK=1

REM -- BATCH EXECUTION DIRECTORY --
cd "..\test\"
set QX_TEST_DIR="%cd%"
cd ".\build\"

REM -- CALL CMAKE TO BUILD QXORM LIBRARY AND ALL SAMPLES PROJECTS --
cmake -G"Visual Studio 14 2015 Win64" %QX_TEST_DIR% %CMAKE_OPTIONS%
cmake --build . --config %MSVC_CONFIG%

pause
