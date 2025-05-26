*** Settings ***
Library    SeleniumLibrary
Resource   ../../pages/upload_arquivo_prouni.resource

*** Keywords ***
Given que acesso a página de upload
    acesso a página de upload
When clico em carregar arquivo
    clico em carregar arquivo
When clico no botão executar
    clico no botão executar
And desço a página para pegar o número do lote
    desço a página para pegar o número do lote
And valido o retorno do número do lote
    valido o retorno do número do lote
And valido se o número foi gerado com sucesso
    valido se o número foi gerado com sucesso
Then consulto no endpoint de download o número do lote gerado
    consulto no endpoint de download o número do lote gerado