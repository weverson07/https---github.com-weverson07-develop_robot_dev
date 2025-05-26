*** Settings ***
Library     SeleniumLibrary
Resource    ../../pages/LoginPageFreto/LoginPageFreto.resource

*** Keywords ***
estou na página e insiro
    Inserir usuário Válido
clico no botâo entrar da página
    Clicar no Botão de Entrar
acesso home page do ambiente VeryCode
    E acesso a home page
valido se a criação do VeryCode foi realizada com sucesso
    Verificar Login Bem Sucedido