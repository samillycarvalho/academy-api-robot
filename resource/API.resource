*** Settings ***
Library   SeleniumLibrary
Library   Collections
Library   String
Library   RequestsLibrary
Resource  variables.resource

 
*** Keywords ***
Create API Session
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session     alias=APITheOriginals      url=https://the-originals.qacoders-academy.com.br  
    ...                                                                        headers=${headers}
    

Login de acesso   
   ${body}    Create Dictionary       mail=${mail}   password=${password}t    
   Log  ${body}
   Create API Session    # Chamando a keyword diretamente
   ${response}=    POST On Session  alias=APITheOriginals  url=/api/login   json=${body}
   Log  ${response.json()}
   Set Test Variable    ${TOKEN}     ${response.json()["token"]}

    
Validar o token e gravar em um header de autorização
   ${headers}  Create Dictionary  Authorization=Bearer ${TOKEN}
   ${response}  GET On Session   alias=APITheOriginals   url=/api/validateToken  headers=${headers}
    Log    ${response.content}
    Log   ${TOKEN}



Criar um novo usuário 
    ${palavra_randomica}=    Generate Random String    8    chars=[LETTERS]
    ${palavra_randomica}=    Convert To Lower Case    ${palavra_randomica}
    ${cpf_randomico}=        Generate Random String   11    chars=[NUMBERS]
    Set Test Variable        ${CPF}    ${cpf_randomico}
    Set Test Variable        ${EMAIL_TEST}    ${palavra_randomica}@hotmail.com

    

Cadastrar um usuario
    ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary        fullName=Fulano da Silva   mail=${EMAIL_TEST}    password=1234@Test  confirmPassword=1234@Test   accessProfile=ADMIN     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  json=${body}  expected_status=201  headers=${headers}
    Log  ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['user']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


Editar usuário
    ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary        fullName=Jubileu Silva   mail=${EMAIL_TEST}    password=1234@Test  confirmPassword=1234@Test   accessProfile=ADMIN     cpf=${CPF}
    Log  ${body}
    Create API Session
    ${response}  PUT On Session   alias=APITheOriginals   url=/api/user/6620212ba8c16a1961d97120    json=${body}   headers=${headers}
    Log  ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


Listar usuários
    ${headers}=    Create Dictionary    Authorization=${token} 
    ${response}   GET On Session   alias=APITheOriginals   url=/api/user  headers=${headers}
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()} 


Incluir department
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=diretaaaaaa&&   costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}    headers=${headers}
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newDepartment']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}




Listar department
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}  GET On Session  alias=APITheOriginals   url=/api/department  headers=${headers}
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()} 


Editar departamento
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=Registrosss    costCenterId=65855af6a2d3ae70485da0b7
    Create API Session
    ${response}  PUT On Session  alias=APITheOriginals   url=/api/department/66201627a8c16a1961d9710e    json=${body}    headers=${headers}
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


Listar diretoria
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}  GET On Session  alias=APITheOriginals   url=/api/board  headers=${headers}    
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()} 


Incluir diretoria
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary      boardName=diretoria&a 
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board   json=${body}    headers=${headers}
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newBoard']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}