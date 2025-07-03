# Financiei - App de Despesas Pessoais com Flutter e Firebase

Este é um aplicativo para gerenciamento de despesas pessoais desenvolvido com Flutter. Ele utiliza o Firebase Firestore como banco de dados para salvar e sincronizar as transações em tempo real.

## Funcionalidades

  * **Adicionar Transações**: Registre suas despesas com título, valor e data.
  * **Visualizar Transações**: Veja uma lista completa de todas as suas despesas.
  * **Gráfico Semanal**: Um gráfico de barras mostra um resumo visual dos seus gastos nos últimos 7 dias.
  * **Excluir Transações**: Remova transações com um simples toque.
  * **Persistência de Dados**: Todas as informações são salvas na nuvem com o Firebase Firestore.

## Estrutura do Projeto

```
/lib
|-- /models
|   |-- transactions.dart   # Define o modelo de dados de uma transação
|-- /view
|   |-- main_screen.dart    # A tela principal que organiza todos os widgets
|-- /widgets
|   |-- chart.dart          # Widget do gráfico de barras semanal
|   |-- chart_bar.dart      # Cada barra individual do gráfico
|   |-- new_transaction.dart# Formulário para adicionar nova transação
|   |-- transaction_list.dart # Widget que exibe a lista de transações
|-- main.dart               # Ponto de entrada do app, inicializa o Firebase
|-- firebase_options.dart   # Configurações do Firebase (gerado automaticamente)
```

-----

## 🚀 Como Configurar e Rodar o Projeto

Siga estes passos para configurar o ambiente e executar o aplicativo.

### Pré-requisitos

Antes de começar, garanta que você tenha o seguinte instalado:

1.  **Flutter SDK**: [Instruções de instalação](https://docs.flutter.dev/get-started/install)
2.  **Node.js e npm**: Necessário para a Firebase CLI. [Baixar aqui](https://nodejs.org/en/)
3.  **Firebase CLI**: Instale globalmente com o comando:
    ```shell
    npm install -g firebase-tools
    ```
4.  **FlutterFire CLI**: Instale globalmente com o comando:
    ```shell
    dart pub global activate flutterfire_cli
    ```

### Passo 1: Crie um Projeto no Firebase

1.  Vá para o [Console do Firebase](https://console.firebase.google.com/).
2.  Clique em **"Adicionar projeto"** e siga as instruções para criar um novo projeto.
3.  Dentro do seu novo projeto, vá para a seção **"Firestore Database"**.
4.  Clique em **"Criar banco de dados"**.
5.  Inicie no **modo de produção** (production mode) e escolha uma localização para os seus servidores (ex: `southamerica-east1`).
6.  Vá até **Project Settings** (ícone de engrenagem) \> **General** para ter certeza de que o projeto está pronto.

### Passo 2: Conecte o Flutter ao Firebase

1.  Abra um terminal na raiz do projeto (`financiei/`).
2.  Faça login na sua conta do Firebase:
    ```shell
    firebase login
    ```
3.  Execute o comando de configuração do FlutterFire:
    ```shell
    flutterfire configure
    ```
4.  O terminal listará os projetos Firebase da sua conta. Use as setas para **selecionar o projeto que você criou** no passo anterior e pressione Enter.
5.  Em seguida, ele perguntará para quais plataformas você quer configurar (android, ios, web, etc.). **Marque todas as opções** usando a barra de espaço e pressione Enter.
6.  Aguarde a ferramenta gerar o arquivo `lib/firebase_options.dart` e configurar as plataformas.

### Passo 3: Baixe as Dependências do Projeto

Ainda no terminal, na raiz do projeto, execute o comando para baixar todos os pacotes necessários:

```shell
flutter pub get
```

### Passo 4: Execute o Aplicativo

Agora você está pronto para rodar o app\!

1.  Abra um emulador de Android, simulador de iOS ou um navegador (Chrome é recomendado).
2.  No terminal, execute:
    ```shell
    flutter run
    ```
3.  O Flutter irá compilar o código e instalar o aplicativo no dispositivo/navegador escolhido.

Pronto\! Agora você pode adicionar e gerenciar suas despesas. Todas as alterações serão salvas automaticamente no seu banco de dados Firebase.
