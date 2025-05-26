*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     DateTime
Resource    ../../hooks/HOOKS.resource
Resource    ../../steps/web/LoginPageFretoSteps.resource

*** Test Cases ***
Acesso página VeryCode com sucesso
    [Setup]    Iniciar sessão web    chrome    ${OPTIONS}    veryCode
    Given estou na página e insiro
    Then valido se a criação do VeryCode foi realizada com sucesso
    [Teardown]    Finalizar sessão web