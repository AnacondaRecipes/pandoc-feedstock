@echo on

MKDIR %LIBRARY_BIN%

MOVE "pandoc.exe" %LIBRARY_BIN%\pandoc.exe
if errorlevel 1 exit 1