# Desenvolvimento

Foi desenvolvido um app de como desafio para a empresa Safra.

Desenvolvido por: Renato Ferraz Castelo Branco Ferreira

email: renato.ferraz@me.com

Tel: (61) 99368-4628

|  |  |
|--|--|
| <img src="https://github.com/rfcbf/" width="480" height="720" /> | <img src="https://github.com/rfcbf/" width="480" height="720" />
| <img src="https://github.com/rfcbf/" width="480" height="720" /> | 

|  |  |
|--|--|
| <img src="https://github.com/rfcbf/" width="480" height="720" /> | <img src="https://github.com/rfcbf/" width="480" height="720" />
| <img src="https://github.com/rfcbf/" width="480" height="720" /> | 


## Instalação e Pré-requistos

1) Maquina com MacOS

2) Xcode 12

3) Baixar esse repositório

5) Descompactar o projeto

6) Abrir o terminal, ir até a pasta onde foi descompactado o projeto

7) Executar pod install

8) Abrir o arquivo DesafioSafra.xcworkspace

9) Quando o projeto estiver aberto no Xcode, executar o app


## O que foi feito?
* Foi adicionado um icone ao app
* Foi criada uma tela de Splash
* Foi criada a tela principal retornando os repositórios de java ordenados conforme solicitado
	* A table view dinamica carregado a cada 20 registros
	* A imagem do usuário está sendo coloca em cache usando SDWebImage
* Ao clicar em um repositorio, e visualizada uma nova tela com todos os pulls requests
	* E feita a contagem de quantos Pulls requests estão aberto e fechados
	* E visualizada descrição e titulo do pull request
	* Dados do usuário que solicitou o pull request
* Ao clicar em um pull request é apresentado uma nova tela visualizado uma webview com a pagina do pull request
* AutoLayout
* App Universal, Ipad | Iphone | Landscape | Portrait

### O que não foi feito

* Testes unitários
* Testes funcionais

## Bibliotecas usadas ( CocoaPods ) 

* Alamofire -> https://github.com/Alamofire/Alamofire

* SDWebImage -> https://github.com/SDWebImage/SDWebImage

* Quick/Nimble -> https://github.com/Quick/Nimble

------------

# Desafio de programação mobile iOS

A idéia deste desafio é nos permitir avaliar melhor as habilidades de candidatos à vagas de programador, de vários níveis.

Este desafio deve ser feito por você em sua casa. Gaste o tempo que você quiser, porém normalmente você não deve precisar de mais do que algumas horas.

## Instruções de entrega do desafio

1. Primeiro, faça um fork deste projeto para sua conta no GitHub (crie uma se você não possuir).
1. Em seguida, implemente o projeto tal qual descrito abaixo, em seu próprio fork.
1. Por fim, empurre todas as suas alterações para o seu fork no GitHub e envie um pull request para este repositório original. Se você já entrou em contato com alguém da companhia sobre uma vaga, avise também essa pessoa por email, incluindo no email o seu usuário no GitHub.

### Instruções alternativas (caso você não queira que sua submissão seja pública)

1. Faça um clone deste repositório.
1. Em seguida, implemente o projeto tal qual descrito abaixo, em seu clone local.
1. Por fim, envie via email um arquivo patch para seu contato na Companhia.

## Descrição do projeto

Você deve criar um aplicativo que irá listar os repositórios públicos mais populares relacionados à Java no GitHub, usando a [API do GitHub](https://developer.github.com/v3/) para buscar os dados necessários.

O aplicativo deve exibir inicialmente uma lista paginada dos repositórios, ordenados por popularidade decrescente (exemplo de chamada da API: `https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1`).

Cada repositório deve exibir Nome do repositório, Descrição do Repositório, Nome / Foto do autor, Número de Stars, Número de Forks.

Ao tocar em um item, deve levar a lista de Pull Requests do repositório. Cada item da lista deve exibir Nome / Foto do autor do PR, Título do PR, Data do PR e Body do PR.

Ao tocar em um item, deve abrir no browser a página do Pull Request em questão.

Você pode se basear neste mockup para criar as telas:

![mockup](https://github.com/igsurf/mobile-challenge/blob/master/mockup-ios.png)

Sua aplicação deve:

- suportar versão mínima do iOS: 8.*
- usar um arquivo .gitignore no seu repositório
- usar Storyboard e Autolayout
- usar gestão de dependências no projeto. Ex: Cocoapods
- usar um Framework para Comunicação com API. Ex: AFNetwork
- fazer mapeamento json -> Objeto . Ex: [Mantle](https://github.com/Mantle/Mantle#mtlmodel)
- possuir boa cobertura de testes unitários no projeto. Ex: Quick / Nimble

Você ganha mais pontos se:

- persistir os dados localmente usando Core Data
- criar testes funcionais. Ex: KIF
- fazer um app Universal, Ipad | Iphone | Landscape | Portrait (Size Classes)
- fazer cache de imagens. Ex SDWebImage

As sugestões de bibliotecas fornecidas são só um guideline, sinta-se a vontade para usar soluções diferentes e nos surpreender. O importante de fato é que os objetivos macros sejam atingidos.

## Avaliação

Seu projeto será avaliado de acordo com os seguintes critérios.

1. Sua aplicação preenche os requerimentos básicos?
1. Você documentou a maneira de configurar o ambiente e rodar sua aplicação?
1. Você seguiu as instruções de envio do desafio?

Adicionalmente, tentaremos verificar a sua familiarização com as bibliotecas padrões (standard libs), bem como sua experiência com programação orientada a objetos a partir da estrutura de seu projeto.

## Referência

Este desafio foi baseado neste outro desafio: https://bitbucket.org/suporte_concrete/desafio-ios
