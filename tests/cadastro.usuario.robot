*** Settings ***
Resource    ../resource/API.resource
Resource   ../resource/variables.resource
*** Test Cases ***
Cenário com POST: Cadastrar um novo usuário com sucesso
   Create API Session
   Login de acesso  
   Criar um novo usuário
   Cadastrar um usuario
   Editar usuário
    