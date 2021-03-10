# RPI-flutter-python

OI OI,

Começando pelo inicio, que é um otimo sitio para começar.


Toca a instalar a biblioteca do python. Pode ser corrida no pc direto, porque na raspberry pi será da mesma maneira. 
Apenas necessitamos de saber o IP da maquina para por como ip do servidor.

```bash
pip3 install simple_websocket_server
```

Depois, por a correr o código em python com o seguinte comando.

```bash
python3 main.py
```
Depois de começar a correr é necessário ligarmos lá um cliente, neste caso o telemóvel.
1. Fazer questão que estes estão ligados a mesma rede
2. Instalar a aplicação, necessário compilar para ios, no entanto pode ser usada a versão já pré compilada para androids (apk disponível no git)
3. Abrir aplicação
4. Correr código python com o comando demonstrado acima
5. Por link seguido da porta definida no código python na aplicação
6. Experimentar mandar tramas para um lado e para o outro

Para terminar o programa clicar ctrl+c
