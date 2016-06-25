# Desafio Estante Virtual

Este desafio consistia na elaboração de uma API para o COB. Seguindo os critérios apresentados em https://github.com/estantevirtual/teste_ev.

## Tecnologias
* Rails 4.2.6
* Ruby 2.3.0
* Postgresql
* Rspec

##Observações sobre Gems
Utilizei duas gems para me auxiliar na elaboração dos testes e refatoração do código.
* [Rubocop](https://github.com/bbatsov/rubocop)
* [SimpleCov](https://github.com/colszowka/simplecov)

A gem simplecov me mostra o percentual de cobertura de código toda vez que rodo os testes. Segundo o mesmo atingi 100% de cobertura. Essas informações podem ser vistas na pasta 'coverage\index.html'. Ele tem dividões interessantes e mostra as linhas que foram testadas pelos seus specs.

A gem Rubocop é uma gem que varre seu código em busca de más práticas. Ele se baseia no [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) que é um guia de boas práticas ao se programar em Ruby. Ao rodar o comando 'rubocop' ele procura as ofensas as boas práticas e alerta para as mesmas. Consegui zerar as advertencias apenas ignorando algumas questões de layout.

##Documentação da API

Está é a documentação de todos os Endpoints disponíves e seus respectivos Payloads.

**Obs:** Todos os requests devem conter o cabeçalho 'Content-type' setado para 'Application/json'

####Criar nova Competição

Este é o endpoint para a criação de uma nova competição.

```
  POST /api/v1/competition
```

#####Os dados a serem enviados para a API:

```json
{
  "competition":{
    "name": "Competição Dardos",
    "competition_type": "dart"
  }
}
```

######Tipos de Competição
As competições podem ser de Dardos ou de 100m Rasos. O campo 'competition_type' deve ser preenchido de acordo:

Competition_type | Explicação
-----------------|-----------
'dart'| Competição de Dardos
'dash'| Competição de 100m Rasos

#####Dados de Resposta

```json
{
  "id": 14,
  "name": "Competição Dardos",
  "competition_type": "dart",
  "finished": false,
  "created_at": "2016-06-24T06:27:53.127Z",
  "updated_at": "2016-06-24T06:27:53.127Z"
}
```

####Inserir Resultados em uma Competição

Este é o endpoint para a criação de resultados para uma competição.

```
  POST /api/v1/result
```

#####Os dados a serem enviados para a API:

```json
{
  "result":{
    "competition": "Competição Dardos",
    "athlete": "José das Couves",
    "value": "123.45",
    "unit": "m"
  }
}
```

######Observações
As competições de Dardos recebem 3 resultados por Atleta. A competição só pode ser finalizada quando os Atletas registrados tenham feito todos seus lançamentos. A competição de 100m Rasos necessita apenas de 1 resultado por Atleta.

**Obs:** Os Atletas são criados automaticamente na primeira vez que for adicionado um resultado para ele. A partir desse momento ele é localizado por seu nome.

unit | Explicação
-----------------|-----------
'm'| A Competição de Dardos é vencida por quem lançar seus dardos mais longe. Unidade: 'Metros'
's'| A Competição de 100m Rasos é vencida por quem alcaçar o menor tempo. Unidade: 'Segundos'

#####Dados de Resposta

```json
{
  "id": 60,
  "competition_id": 13,
  "athlete_id": 5,
  "value": 123.45,
  "unit": "m",
  "created_at": "2016-06-25T11:15:14.310Z",
  "updated_at": "2016-06-25T11:15:14.310Z"
}
```

####Finalizar uma Competição

Este é o endpoint para a finalização de uma competição.

```
  POST /api/v1/competition/finish_competition
```

#####Os dados a serem enviados para a API:

```json
{
  "competition":{
    "name": "Competição Dardos"
  }
}
```

#####Dados de Resposta

```
Finished Competition
```

####Ranking de uma Competição

Este é o endpoint para se obter o Ranking de uma competição. A competição não precisa estar encerrada para obter-se o Ranking.

```
  POST /api/v1/competition/ranking
```

#####Os dados a serem enviados para a API:

```json
{
  "competition":{
    "name": "Competição Dardos"
  }
}
```

#####Dados de Resposta

```json
{
  "competition": "Competição Dardos",
  "finished": true,
  "ranking": {
    1: {
    "name": "José das Verduras",
    "value": 125.43,
    "unit": "Meters"
    },
    2: {
    "name": "José das Couves",
    "value": 123.45,
    "unit": "Meters"
    }
  }
}
```