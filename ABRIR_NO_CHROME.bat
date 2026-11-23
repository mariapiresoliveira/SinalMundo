@echo off
setlocal
cd /d "%~dp0"
echo ==========================================
echo       SINALMUNDO - EXECUTAR NO CHROME
echo ==========================================
echo.
where flutter >nul 2>&1
if errorlevel 1 (
  echo Flutter nao foi encontrado no PATH.
  echo Instale o Flutter e reinicie o terminal antes de executar este arquivo.
  goto erro
)
if not exist "web\index.html" (
  echo A pasta Web do projeto nao foi encontrada.
  echo Restaure a pasta web original deste pacote antes de continuar.
  goto erro
)
echo [1/4] Baixando dependencias...
call call flutter pub get
if errorlevel 1 goto erro
echo.
echo [2/4] Verificando o codigo...
call call flutter analyze
if errorlevel 1 goto erro
echo.
echo [3/4] Executando os testes...
call call flutter test
if errorlevel 1 goto erro
echo.
echo [4/4] Iniciando no Chrome...
call call flutter run -d chrome
if errorlevel 1 goto erro
goto fim
:erro
echo.
echo Ocorreu um erro. Copie a mensagem acima para suporte.
pause
:fim
endlocal

