# manutencar_mobile

# Passo a passo para configurar este projeto e seu PC.

## 1. Verifique o Ambiente

* **Flutter SDK:**
    * Certifique-se de que o Flutter SDK esteja instalado e configurado corretamente no seu computador.
    * Execute o comando `flutter doctor` no terminal para verificar se há alguma dependência faltando ou problema de configuração.
    * Se houver algum problema, siga as instruções fornecidas pelo `flutter doctor` para corrigi-lo.
* **Editor de Código:**
    * Abra o projeto em seu editor de código preferido (VS Code, Android Studio, etc.).

## 2. Obtenha as Dependências

* **Pub get:**
    * No terminal, navegue até o diretório raiz do projeto Flutter.
    * Execute o comando `flutter pub get` para baixar todas as dependências do projeto listadas no arquivo `pubspec.yaml`.
    * Este passo é crucial, pois garante que todas as bibliotecas e pacotes necessários para o projeto estejam instalados.

## 3. Execute o Projeto

* **Dispositivo ou Emulador:**
    * Conecte um dispositivo Android ou iOS ao seu computador ou inicie um emulador.
    * Certifique-se de que o dispositivo ou emulador esteja detectado pelo Flutter.
    * Você pode verificar os dispositivos conectados executando o comando `flutter devices`.
* **Flutter run:**
    * No terminal, ainda no diretório raiz do projeto, execute o comando `flutter run`.
    * O Flutter irá compilar o projeto e instalá-lo no dispositivo ou emulador.
    * O aplicativo será iniciado automaticamente.

## 4. Resolução de Problemas

* **Erros de Compilação:**
    * Se ocorrerem erros de compilação, verifique as mensagens de erro no terminal para identificar a causa do problema.
    * Erros comuns incluem dependências ausentes, problemas de versão do SDK ou erros de código.
* **Problemas de Dependência:**
    * Se você encontrar problemas com dependências, verifique o arquivo `pubspec.yaml` para garantir que as versões das dependências sejam compatíveis com o seu ambiente.
    * Você pode tentar limpar o cache de dependências executando o comando `flutter clean` e, em seguida, executar `flutter pub get` novamente.
* **Problemas de Plataforma:**
    * Caso o projeto tenha sido desenvolvido para uma plataforma especifica, verifique se seu ambiente esta devidamente configurado para tal.
