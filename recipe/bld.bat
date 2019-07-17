rm makefile
copy "%RECIPE_DIR%"\CMakeLists.txt .

cmake -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON .

nmake
nmake install

echo 123 | test.exe > output.txt

FC output.txt "%RECIPE_DIR%"\test_output.txt

if errorlevel 1 exit 1

