*** Settings ***
Resource    ../resource/API.resource
Resource   ../resource/variables.resource

*** Test Cases ***
CT01 - Cadastrar um Departamento
   Incluir department
