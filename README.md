# **MAPFLUTTER-Study**

<img src="https://flutter.dev/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png">

<br><br><hr>


    Flutter é um kit de desenvolvimento de interface de usuário, de código aberto, criado pelo Google, que possibilita a criação de aplicativos compilados nativamente. Atualmente pode compilar para Android, iOS, Windows, Mac, Linux, Google Fuchsia e Web.

Este é um projeto baseado no kit Flutter sobre a linguagem Dart, fazendo uso dos benefícios da Google Cloud Plataform, tais como Google Maps e do Google Cloud Funciotions, o qual será a camada de serviço desta aplicação.


## Requisitos 
* A aplicação móvel deve exibir o mapa da localização atual do telefone.
* A aplicação móvel deve rastrear a localização do usuário.
* A cada atualização de localização, a aplicação móvel deve invocar a função lambda do GCF.
* A função lambda deve verificar se o aparelho se encontra a menos de 100 metros de alguma unidade da PUC Minas e retornar para o celular uma mensagem.
  * Mensagem:  **Bem vindo à PUC Minas unidade [nome da unidade mais próxima]**.


Seguirão abaixo orientações do uso do projeto  

## Utilização

### Dependências necessárias

Pacote Flutter de desenvolvimento
 
```sh
## Linux
 
    sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
    
    flutter config --enable-linux-desktop 

## Windows

    Você poderá encontrar mais informações sobre a instalação no site oficial do Flutter (https://flutter.dev/docs/get-started/install/linux)

## Para maiores suportes
    Você poderá seguir este https://www.youtube.com/watch?v=9m3PvcQ18Hk&t=412s

```
### Execução da aplicação  
 
```sh

* WEB APP
## Execução para aplicação WEB
flutter run -d chrome

* APP

## Execução para build de apk para o mobile (É necessário ter o celular conectado em modo debug)
flutter run 
 
```  

#### Ações  
##### * O que você poderá realizar dentro do sistema ?


```sh
* WEB APP

## Ao ser executado um novo ambiente será aberto para uso 

* APP

## Ao ser gerado, irá ser instalado uma versão debug do app
``` 

```sh 
1 - Ao habilitar a localização, será possivel validar se o app está de acordo
2 - A localização deve estar em tempo real
3 - Ele deverá notificar ao usuário quando este estiver perto de determinada localização 
``` 
 
<br>
<br>
<br>

#### LABORATÓRIO DE DESENVOLVIMENTO DE APLICAÇÕES MÓVEIS E DISTRIBUÍDAS

**06 de Junho de 2021**
 
