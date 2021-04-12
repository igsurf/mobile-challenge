
## Instruções para build e uso do projeto 

1. Primeiro será necessário rodar o comando pod install --repo-update na raiz do projeto (onde está localizado o arquivo Podfile).
2. Eu separei a camada de serviços em duas, uma camada mockada e outra real (API). Para rodar a mockada, mude para a build configuration Debug e para acessar a real (API), mude para a build configuration Homolog.
2.1 Para mudar a build configuration, vá em Product -> Scheme -> Edit Scheme e mude a build configuration da barra Run.


## Informações do projeto

Eu utilizei MVVM para a construção do projeto;

Os textos que serão apresentados ao usuário estão no arquivo Localizable.strings, com a finalidade de tradução para outras línguas, e são acessadas atravez da classe LocalizedStrings;

Versão do CocoaPods usado: 1.10.1;

Versão do XCode utilizado: 12.0;

Fiz testes unitários para todas as ViewModels;

## Informações do modulo de serviços

Criei o modulo SDKGithubServices para o gerenciamento das requests. Seu arquivo Podspec está hospedado no repositorio https://github.com/gabrielsousaleal/pod-specs. Ele pode ser importado como .xcframework utilizando pod 'SDKGithubServices' ou como modulo aberto utilizado pod 'SDKGithubServices/Debug'

