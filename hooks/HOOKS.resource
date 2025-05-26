*** Settings ***
Resource    ../common/constants.resource
Library     ../common/WebDriver.py


*** Keywords ***
Iniciar sessão web
    [Arguments]    ${BROWSER}    ${OPTIONS}    ${AMBIENTE}    ${BASE_URL}=
    Selecionar URL por ambiente    ${AMBIENTE}
    # Integração Zephyr - Validações
    ${DRIVER_PATH}                 Get Driver Path With Browser      ${BROWSER}
    Open Browser                   browser=${BROWSER}
    ...                            executable_path=${DRIVER_PATH}
    ...                            options=${OPTIONS}
    Log                            ${OPTIONS}
    Maximize Browser Window
    Go To                          ${BASE_URL}
Selecionar URL por ambiente
    [Arguments]    ${AMBIENTE}
    ${BASE_URL}    Set Variable    ${BASE_URL_UMC}
    IF    '${AMBIENTE}' == 'umc'
        Set Test Variable    ${BASE_URL}    ${BASE_URL_UMC}
    ELSE IF    '${AMBIENTE}' == 'upf'
        Set Test Variable    ${BASE_URL}    ${BASE_URL_UPF}
    ELSE IF    '${AMBIENTE}' == 'utp'
        Set Test Variable    ${BASE_URL}    ${BASE_URL_UTP}
    ELSE IF    '${AMBIENTE}' == 'haoc'
        Set Test Variable    ${BASE_URL}    ${BASE_URL_HAOC}
    ELSE IF    '${AMBIENTE}' == 'infoprod'
        Set Test Variable    ${BASE_URL}    ${BASE_URL_INFOPROD}
    ELSE IF    '${AMBIENTE}' == 'kroton'
        Set Test Variable    ${BASE_URL}    ${BASE_URL_KROTON}
    ELSE IF    '${AMBIENTE}' == 'mackenzie'
        Set Test Variable    ${BASE_URL}    ${BASE_URL_MACKENZIE}
    ELSE IF    '${AMBIENTE}' == 'stricto'
        Set Test Variable    ${BASE_URL}    ${BASE_URL_STRICTO}
    ELSE IF    '${AMBIENTE}' == 'gestor'
        Set Test Variable    ${BASE_URL}    ${GESTO_URL}
    ELSE IF    '${AMBIENTE}' == 'freto'
        Set Test Variable    ${BASE_URL}    ${URLfreto}
    ELSE IF    '${AMBIENTE}' == 'veryCode'
        Set Test Variable    ${BASE_URL}    ${UrlVeryCode}
    ELSE
        Fail    Ambiente ${AMBIENTE} não encontrado.
    END
Finalizar sessão web
    Close All Browsers
    # Integração Zephyr - Enviar resultado