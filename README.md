# API-REST-PROTHEUS

[![licence badge]][licence]
[![stars badge]][stars]
[![forks badge]][forks]
[![issues badge]][issues]

[licence badge]:https://img.shields.io/github/license/jerfweb/api-rest-protheus
[stars badge]:https://img.shields.io/github/stars/jerfweb/API-REST-PROTHEUS.svg
[forks badge]:https://img.shields.io/github/forks/jerfweb/API-REST-PROTHEUS.svg
[issues badge]:https://img.shields.io/github/issues/jerfweb/API-REST-PROTHEUS.svg

[licence]:https://github.com/jerfweb/API-REST-PROTHEUS/blob/master/LICENSE
[stars]:https://github.com/jerfweb/API-REST-PROTHEUS/stargazers
[forks]:https://github.com/jerfweb/API-REST-PROTHEUS/network
[issues]:https://github.com/jerfweb/API-REST-PROTHEUS/issues

Exemplos de utilização das API's Rest do ERP Protheus.

## API PADRÃO

 - ### API USERS	
	API para informações de usuário do ERP Protheus.
	No exemplo, foi criada uma rotina que recebe o código do usuário e a operação à ser executada como parâmetro, realiza a operação e obtêm o retorno do serviço no formato JSON. Foram implementadas algumas validações básicas para garantir a execução.

	#### Documentação disponível no site da TOTVS:
	- [O serviço Rest users do Protheus de criação de usuários utilizando Webservice REST.](http://tdn.totvs.com/pages/releaseview.action?pageId=274327398)
	- [Exemplo de consumo com HTTP Basic.](http://tdn.totvs.com/display/framework/Exemplo+de+consumo+com+HTTP+Basic)

 - ### API TOKEN
	Implementação do OAuth 2.0 (https://tools.ietf.org/html/rfc6749) para requisição de token para acesso aos sistema TOTVS. É altamente recomendado o uso de segurança SSL.
	
	#### Documentação disponível no site da TOTVS e sites de apoio:
	- [Detalhamento de consumo da API TOKEN](https://api.totvs.com.br/apidetails/Token_v1_000.json)
	- [ADVPL + REACT – Parte 03 | Segurança e API de Login + BÔNUS.](https://augustopontin.com.br/programacao/advpl-react-parte-03-seguranca-e-api-de-login-bonus/)
		>Documentação desenvolvida por [Augusto Pontin](https://augustopontin.com.br/author/augusto-bsinfogmail-com/ "Posts de Augusto Pontin") 24 de abril de 2020

## API CUSTOMIZADAS

- ### API de manutenção de pedidos de venda
	API para manutenção de pedidos de venda utilizando o Executo de MATA410, viabilizando a realização das validações desenvolvidos para efetuar o processo.



Qualquer dúvida/sugestão, por favor, entre em contato através do e-mail [jerfweb@gmail.com](mailto:jerfweb@gmail.com).
