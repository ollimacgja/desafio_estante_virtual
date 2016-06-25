# Desafio Estante Virtual

Este desafio consistia na elaboração de uma API para o COB. Seguindo os critérios apresentados em https://github.com/estantevirtual/teste_ev.

## Tecnologias
*Rails 4.2.6
*Ruby 2.3.0
*Postgresql
*Rspec

##Documentação da API

Está é a documentação de todos os Endpoints disponíves e seus respectivos Payloads.

**Obs:** Todos os requests devem conter o cabeçalho 'Content-type' setado para 'Application/json'

####Criar nova Competição

Este é o endpoint para a criação de uma nova competição.

'''
  POST /api/v1/competition
'''

Os dados a serem enviados para a API:

'''json
{
  "competition":{
    "name": "Competição Dardos",
    "competition_type": "dart"
  }
}
'''

######Tipos de Competição
As competições podem ser de Dardos ou de 100m Rasos. O campo 'competition_type' deve ser preenchido de acordo:

Competition_type | Explicação
-----------------|-----------
'dart'| Competição de Dardos
'dash'| Competição de 100m Rasos

Dados de Resposta

'''json
{
  "id": 14
  "name": "Competição Dardos"
  "competition_type": "dart"
  "finished": false
  "created_at": "2016-06-24T06:27:53.127Z"
  "updated_at": "2016-06-24T06:27:53.127Z"
}
'''

