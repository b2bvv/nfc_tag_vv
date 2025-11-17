@echo off
echo Updating GitHub Pages site...
echo.

git add .
git commit -m "Update site: %date% %time%"
git push

echo.
echo Site updated! Wait 1-5 minutes for changes to appear on GitHub Pages.
echo.
pause

