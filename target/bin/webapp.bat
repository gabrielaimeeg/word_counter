@REM ----------------------------------------------------------------------------
@REM  Copyright 2001-2006 The Apache Software Foundation.
@REM
@REM  Licensed under the Apache License, Version 2.0 (the "License");
@REM  you may not use this file except in compliance with the License.
@REM  You may obtain a copy of the License at
@REM
@REM       http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM  Unless required by applicable law or agreed to in writing, software
@REM  distributed under the License is distributed on an "AS IS" BASIS,
@REM  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM  See the License for the specific language governing permissions and
@REM  limitations under the License.
@REM ----------------------------------------------------------------------------
@REM
@REM   Copyright (c) 2001-2006 The Apache Software Foundation.  All rights
@REM   reserved.

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of arguments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
for %%i in ("%~dp0..") do set "BASEDIR=%%~fi"

:repoSetup
set REPO=


if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=%BASEDIR%\repo

set CLASSPATH="%BASEDIR%"\etc;"%REPO%"\org\eclipse\jetty\jetty-webapp\9.3.14.v20161028\jetty-webapp-9.3.14.v20161028.jar;"%REPO%"\org\eclipse\jetty\jetty-xml\9.3.14.v20161028\jetty-xml-9.3.14.v20161028.jar;"%REPO%"\org\eclipse\jetty\jetty-util\9.3.14.v20161028\jetty-util-9.3.14.v20161028.jar;"%REPO%"\org\eclipse\jetty\jetty-server\9.3.14.v20161028\jetty-server-9.3.14.v20161028.jar;"%REPO%"\javax\servlet\javax.servlet-api\3.1.0\javax.servlet-api-3.1.0.jar;"%REPO%"\org\eclipse\jetty\jetty-http\9.3.14.v20161028\jetty-http-9.3.14.v20161028.jar;"%REPO%"\org\eclipse\jetty\jetty-io\9.3.14.v20161028\jetty-io-9.3.14.v20161028.jar;"%REPO%"\org\mortbay\jetty\jsp-2.1-glassfish\9.1.02.B04.p0\jsp-2.1-glassfish-9.1.02.B04.p0.jar;"%REPO%"\org\eclipse\jdt\core\3.1.1\core-3.1.1.jar;"%REPO%"\org\mortbay\jetty\jsp-api-2.1-glassfish\9.1.02.B04.p0\jsp-api-2.1-glassfish-9.1.02.B04.p0.jar;"%REPO%"\org\mortbay\jetty\servlet-api\3.0.pre1\servlet-api-3.0.pre1.jar;"%REPO%"\ant\ant\1.6.5\ant-1.6.5.jar;"%REPO%"\org\eclipse\jetty\jetty-servlet\9.3.14.v20161028\jetty-servlet-9.3.14.v20161028.jar;"%REPO%"\org\eclipse\jetty\jetty-security\9.3.14.v20161028\jetty-security-9.3.14.v20161028.jar;"%REPO%"\javax\servlet\servlet-api\2.5\servlet-api-2.5.jar;"%REPO%"\org\webjars\bootstrap\5.1.1\bootstrap-5.1.1.jar;"%REPO%"\org\webjars\jquery\3.6.0\jquery-3.6.0.jar;"%REPO%"\org\webjars\popper.js\2.9.3\popper.js-2.9.3.jar;"%REPO%"\org\voxy\word_counter\1.0-SNAPSHOT\word_counter-1.0-SNAPSHOT.war

set ENDORSED_DIR=
if NOT "%ENDORSED_DIR%" == "" set CLASSPATH="%BASEDIR%"\%ENDORSED_DIR%\*;%CLASSPATH%

if NOT "%CLASSPATH_PREFIX%" == "" set CLASSPATH=%CLASSPATH_PREFIX%;%CLASSPATH%

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS% -Xmx512m -classpath %CLASSPATH% -Dapp.name="webapp" -Dapp.repo="%REPO%" -Dapp.home="%BASEDIR%" -Dbasedir="%BASEDIR%" Main %CMD_LINE_ARGS%
if %ERRORLEVEL% NEQ 0 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=%ERRORLEVEL%

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@REM If error code is set to 1 then the endlocal was done already in :error.
if %ERROR_CODE% EQU 0 @endlocal


:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%
