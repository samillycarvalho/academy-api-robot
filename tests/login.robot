*** Settings ***
Resource    ../resource/API.resource

*** Variables ***


*** Test Cases ***
CT01 - GET Obter Token de Acesso
    Create API Session  
    Login de acesso 
    Validar o token e gravar em um header de autorização