cd src
rm makefile
copy "%RECIPE_DIR%"\CMakeLists.txt .

REM -GL has issues in cmake
set "CFLAGS=-MD"

cmake -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON .

nmake
nmake install

ctest
if errorlevel 1 exit 1

