@echo off
REM ============================================================
REM build_exe.bat
REM Gera doom.exe a partir de main.py usando PyInstaller.
REM Saida: DOOM_ALGPP\doom.exe
REM ============================================================

setlocal

set BUILD_DIR=%~dp0
set DEST_DIR=%BUILD_DIR%..

echo.
echo Instalando dependencias...
python -m pip install --upgrade pip
python -m pip install -r "%BUILD_DIR%requirements.txt"
if errorlevel 1 goto erro

echo.
echo Empacotando doom.exe...
python -m PyInstaller ^
    --onefile ^
    --console ^
    --name doom ^
    --add-data "%BUILD_DIR%scripts;scripts" ^
    --distpath "%DEST_DIR%" ^
    --workpath "%BUILD_DIR%_pyi_work" ^
    --specpath "%BUILD_DIR%_pyi_spec" ^
    "%BUILD_DIR%main.py"
if errorlevel 1 goto erro

echo.
echo doom.exe gerado em: %DEST_DIR%\doom.exe
echo.
echo Lembre que doom.exe procura scripts/ ao lado do executavel
echo ou empacotado dentro do proprio binario.
goto fim

:erro
echo.
echo ERRO ao gerar doom.exe.
exit /b 1

:fim
endlocal
