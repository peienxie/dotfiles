echo off

set LANG=en_US.utf8
set EDITOR=nvim
set CC=gcc

set "HOME=%USERPROFILE%"
set "SCOOP=D:\tools\scoop"
set "XDG_CONFIG_HOME=%HOME%\.config"
set "XDG_CACHE_HOME=%HOME%\.cache"
set "XDG_DATA_HOME=%HOME%\.local\share"
set "XDG_STATE_HOME=%HOME%\.local\state"
set "K9S_CONFIG_DIR=%HOME%\.config\k9s"

set PATH=%SCOOP%\shims;%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%
set PATH=%HOME%\.bin;%HOME%\.local\bin;%PATH%

@REM load all the aliases using doskey
%SystemRoot%\system32\doskey /listsize=1000 /macrofile=%~dp0%custom-aliases
