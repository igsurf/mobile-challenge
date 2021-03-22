# Safra - Mobile Challenge

Aplicativo teste para o Banco Safra, construido para a plataforma iOS com a linguagem de programação Swift, utilizando arquitetura VIPER.

## Summary

* [Introdução](#introducao)
	* [Técnologias utilizadas](#tecnlogia)
	* [Desenvolvimento](#desenvolvimento)
	* [Dificuldades e ideias durante o desenvolvimento](#dificuldades)
* [Configurando o Ambiente](#config)
	* [Configurando o Projeto](#config_projeto)
		* [Instalando os Framework e gerando seu workspac](#config_workspace)


## Introdução <a id="introducao"></a>

Com o objetivo de desenvolver um aplicativo com uma arquitetura modular, com reaproveitamento de código e adaptabilidade de soluções. Com tudo, houve alguns desafios durante o desenvolvimento, utilização de técnoligias entre outros processos necessário para o desenvolvimento.

### Técnologias <a id="tecnlogia"></a>
Para o desenvolvimento da soluçãp, utilizamos algumas técnologias, arquiteturas e padrões durante o processo. Segue algumas delas abaixo:
* **Alamofire**: Framework de HTTPRequest, utiizado pra realizar requisições da API.
* **AlamofireImage**: Framework de HTTPRequest voltado para imagens, trabalha de forma simples realizando download de imagens diretamente para UIImageViews e também realizando o cache dessas imagens.
* **ReachabilitySwift**: Framework de verificação de conexão de internet, pode ser utilizado para verificar o tipo de conexão utilizado, e se há conexão ou não com a internet.
* **Quick & Nimble**: Frameworks utilizados para realização de testes unitários.

### Desenvolvimento <a id="desenvolvimento"></a>
O processo de desenvolvimento iniciou-se com a ideia de desenvolver módulos separados, com isso, em ordem, foi desenvolvido separada cada módulo abaixo, tendo apenas o trabalho de adaptar a conexão entre eles para finalizar o projeto:

* **Network**: Módulo de HTTPRequest, é um módulo que acopla o Framework **Alamofire** e **ReachabilitySwift** por trás, por ele é realizado as requisições HTTP e a verificação da conexão de internet.
* **GithubAPI**: Módulo que realiza as requisições na API do Github, trazendo os dados e moldandos de forma que fiquem legiveis para o aplicativo de forma mais simples, nele consiste:
	* Requisições ao GithubAPI.
	* Parser dos objetos recebidos para objetos modelos para o aplicativo.
	* Persistencias de dados em CoreData, salvando os dados recebidos e os utilizando caso tenha erro durante as requisições ou falta de conexão de internet.
	* Feito o mais próximo possivel da Arquitetura **VIPER**
* **GithubUI**: Módulo de componentes de UI para apresentação dos dados de forma visual para o usuário.
	* **Component CounterView**: Component para visualização de contadores, como contador de **FORKS** e/ou **Estrelas** o repositório tem.
	*  **Component UserView**: Componente que mostra os dados do desenvolvedor dono do **repositório** ou **pullrequest**, mostra o login do usuário, tipo do usuário e avatar utilizados pelo o mesmo.
	* **RepositoryViewCell**:  Herdado do componente **UITableViewCell**, o componente é uma célula customizada com os dados do GithubAPI, para compor uma UITableView.
	* **PullRequestViewCell**:  Herdado do componente **UITableViewCell**, o componente é uma célula customizada com os dados do GithubAPI, para compor uma UITableView.
	* Todos os components não foi utilzado bem um arquitetura, porém poderá ver pequenas semelhanças com **MVC**.

* **App**: Ultimo módulo desenvolvido, e também trabalhado em cima da arquitetura **VIPER**, é responsavel por juntar todos os módulos anteriores e assim montar o Aplicativo em si, composto por duas telas, uma de listagem de repositórios e outra de listagem pull requests.

### Dificuldades e ideias durante o desenvolvimento <a id="dificuldades"></a>
Durante o desenvolvimento houve algumas dificuldades, sendo quase 100% delas por falta de tempo, para desenvolver a melhor solução, a ideia foi desenvolver pequenos modulos que poderiam ser feitos a curto prazos.

- O App foi desenvolvido de "trás para frente", realizando o desenvolvimento primeiramente de módulos back-end, como os módulos **Network** e **GithubAPI**, facilitando o desenvolvimento dos móduloas front-end, **GithubUI** e **App**.

- Durante o desenvolvimento da parte de UI, não foram utilizados **XIBs** ou **Storyboards**, pois a ideia era fazer um app leve de com um build mais rápido, deixando assim um aplicativo mais leve e rápida publicação.

## Configurando o Ambiente <a id="config"> </a>
Todo o projeto foi desenvolvido no Xcode 12 com a versão do Swift 5+, como a versão do Xcode utilizado é a 12.4, o App foi desenvolvido em cima da versão 13 do iOS, sendo assim, o projeto está com facil adaptabilidade para versões anteriores, porém será necessário alteração em alguns códigos, por isso, recomendo utilizar a mesma versão do Xcode com a versão minima iOS 13.

### Configurando o Projeto <a id="config_projeto"> </a>
Ao realizar o download do projeto, abra o terminal do seu MacOS e nave até a pasta do projeto que contém o arquivo **Podfile**, após realizar esses passos, siga os passos a seguir:

#### Instalando os Framework e gerando seu workspace <a id="config_workspace"></a>
Com o terminal do MacOS aberto, e já dentro do diretório do projeto que contém o arquivo **Podfile**, execute o comando abaixo no terminal:
* Comando: _pod install_
```Terminal MacOS
myuser@MyUsers-MacBook-Pro SafraChallenge % pod install
```
Ao realizar o passo anterior, espere que ele termine de instalar os frameworks e gerar seu workspace, após terminar de gerar o workspace, execute o comando a seguir:
* Comando: _open SafraChallenge.xcworkspace_
```Terminal MacOS
myuser@MyUsers-MacBook-Pro SafraChallenge % open SafraChallenge.xcworkspace
```
Executando o comando anterior, o seu projeto irá abrir no Xcode da sua máquina, espere ele terminar de carregar, após o termino do carregamento ele já estará pronto para ser buildado e executado, então clique no botão _"Build and then run the current schema"_ ou apencas aperte as teclas _"command+r"_, espere o projeto terminar de buildar e ser anexado ao Device/Simulador, após isso, o projeto está pronto para ser utilizado.

Após executar o projeto em sua máquina, aproveite e navegue por ele.