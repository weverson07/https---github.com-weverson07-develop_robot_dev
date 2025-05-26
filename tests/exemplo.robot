
*** Settings ***
Library    OperatingSystem

*** Test Cases ***
Teste de Integração Simples
    Log To Console    🚀 Iniciando teste integrado!
    Create File    arquivo_teste.txt    Arquivo criado no teste.
    File Should Exist    arquivo_teste.txt
