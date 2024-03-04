set appName to "WezTerm"

if application appName is running then
  tell application appName to activate
else
  Do Shell Script "/Applications/WezTerm.app/Contents/MacOS/wezterm-gui"
end if
