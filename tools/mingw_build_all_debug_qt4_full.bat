REM -- BATCH PARAMETERS --
set BATCH_TYPE=full
set MINGW_CONFIG=debug
set LIB_SUFFIX=d
if "%1"=="release" set MINGW_CONFIG=%1
if "%1"=="release" set LIB_SUFFIX=
if "%2"=="minimal" set BATCH_TYPE=%2
if "%BATCH_TYPE%"=="full" set QXORM_QMAKE_PARAMS="DEFINES += _QX_ENABLE_BOOST_SERIALIZATION" "DEFINES += _QX_ENABLE_QT_GUI" "DEFINES += _QX_ENABLE_QT_NETWORK"
set QXORM_QMAKE_PARAMS=%QXORM_QMAKE_PARAMS% "QMAKE_CXXFLAGS += -std=c++0x"

REM -- QT ENVIRONMENT VARIABLES --
set QT_DIR=%QT4_MINGW%
set PATH=%QT_DIR%\bin;%PATH%

REM -- BOOST ENVIRONMENT VARIABLES --
set BOOST_INCLUDE=%BOOST_DIR%\include
set BOOST_LIB=%BOOST_DIR%\lib_shared
set BOOST_LIB_SERIALIZATION_DEBUG=libboost_serialization-mgw45-mt-d-1_57
set BOOST_LIB_SERIALIZATION_RELEASE=libboost_serialization-mgw45-mt-1_57
set BOOST_LIB_WIDE_SERIALIZATION_DEBUG=libboost_wserialization-mgw45-mt-d-1_57
set BOOST_LIB_WIDE_SERIALIZATION_RELEASE=libboost_wserialization-mgw45-mt-1_57

REM -- MAKE OPTIONS : USE 8 CORE CPU TO REDUCE BUILD TIMES --
set MAKE_COMMAND=make -j8

REM -- BUILD QXORM LIBRARY --
cd "../"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "./lib/QxOrm%LIB_SUFFIX%.dll" GOTO END

REM -- BUILD TEST DLL1 --
cd "./test/qxDllSample/dll1/"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "../../_bin/dll1%LIB_SUFFIX%.dll" GOTO END

REM -- BUILD TEST DLL2 --
cd "../dll2/"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "../../_bin/dll2%LIB_SUFFIX%.dll" GOTO END

REM -- BUILD TEST EXE --
cd "../exe/"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "../../_bin/exe%LIB_SUFFIX%.exe" GOTO END

REM -- BUILD TEST QXBLOG --
cd "../../qxBlog/"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "../_bin/qxBlog%LIB_SUFFIX%.exe" GOTO END

REM -- BUILD TEST QXBLOG COMPOSITE KEY --
cd "../qxBlogCompositeKey/"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "../_bin/qxBlogCompositeKey%LIB_SUFFIX%.exe" GOTO END

REM -- BUILD TEST QXBLOG MODEL VIEW --
cd "../qxBlogModelView/"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "../_bin/qxBlogModelView%LIB_SUFFIX%.exe" GOTO END

REM -- CHECK BATCH TYPE : FULL OR MINIMAL --
IF "%BATCH_TYPE%"=="minimal" GOTO END

REM -- BUILD TEST QXCLIENTSERVER QXSERVICE --
cd "../qxClientServer/qxService"
qmake %QXORM_QMAKE_PARAMS% qxServiceServer.pro
make %MINGW_CONFIG%
IF NOT EXIST "../../_bin/qxServiceServer%LIB_SUFFIX%.dll" GOTO END
qmake %QXORM_QMAKE_PARAMS% qxServiceClient.pro
make %MINGW_CONFIG%
IF NOT EXIST "../../_bin/qxServiceClient%LIB_SUFFIX%.dll" GOTO END

REM -- BUILD TEST QXCLIENTSERVER QXSERVER --
cd "../qxServer/"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "../../_bin/qxServer%LIB_SUFFIX%.exe" GOTO END

REM -- BUILD TEST QXCLIENTSERVER QXCLIENT --
cd "../qxClient/"
qmake %QXORM_QMAKE_PARAMS%
make %MINGW_CONFIG%
IF NOT EXIST "../../_bin/qxClient%LIB_SUFFIX%.exe" GOTO END

REM -- BATCH FINISHED --
:END
pause
