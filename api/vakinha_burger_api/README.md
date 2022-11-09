A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/` and `/echo/<message>`

# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
Hello, World!
$ curl http://0.0.0.0:8080/echo/I_love_Dart
I_love_Dart
```

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
Hello, World!
$ curl http://0.0.0.0:8080/echo/I_love_Dart
I_love_Dart
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```



## Database

```sql
--->> MySql Versão 8.0.23 ou superior

create database vakinha_burger;
use vakinha_burger;

CREATE TABLE IF NOT EXISTS usuario (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(200) NOT NULL,
  email VARCHAR(200) NOT NULL,
  senha VARCHAR(200) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS produto (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  descricao TEXT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  imagem TEXT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS pedido (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  id_transacao TEXT NULL,
  cpf_cliente VARCHAR(45) NULL,
  endereco_entrega TEXT NOT NULL,
  status_pedido VARCHAR(20) NOT NULL DEFAULT 'pendente',
  PRIMARY KEY (id),
  INDEX fk_pedido_usuario_idx (usuario_id ASC),
  CONSTRAINT fk_pedido_usuario
    FOREIGN KEY (usuario_id)
    REFERENCES usuario (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS pedido_item (
  id INT NOT NULL AUTO_INCREMENT,
  quantidade VARCHAR(45) NOT NULL,
  pedido_id INT NOT NULL,
  produto_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_pedido_produto_pedido1_idx (pedido_id ASC),
  INDEX fk_pedido_produto_produto1_idx (produto_id ASC),
  CONSTRAINT fk_pedido_produto_pedido1
    FOREIGN KEY (pedido_id)
    REFERENCES pedido (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_pedido_produto_produto1
    FOREIGN KEY (produto_id)
    REFERENCES produto (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO produto(id, nome, descricao, preco, imagem)
VALUES (null, 'X-Tudão + Suco', '', 12.99, '/xtudo_suco.jpeg');

INSERT INTO produto(id, nome, descricao, preco, imagem)
VALUES (null, 'Misto Quente', 'Pão, presunto, muçarela, Orégano', 6.99, '/xtudo_suco.jpeg');

INSERT INTO produto(id, nome, descricao, preco, imagem)
VALUES (null, 'X-Quente', 'Pão, Hambúrger (Tradicional 56g), Muçarela e Tomate', 10.99, '/xtudo_suco.jpeg');

INSERT INTO produto(id, nome, descricao, preco, imagem)
VALUES (null, 'X-Salada',
        'Pão, Hambúrguer (Tradicional 56g), Presunto, Muçarela, Ovo, Alface, Tomate, Milho e Batata Palha.', 11.99,
        '/xtudo_suco.jpeg');

INSERT INTO produto(id, nome, descricao, preco, imagem)
VALUES (null, 'X-Tudo',
        'Pão, Hambúrguer (Tradicional 56g), Presunto, Muçarela, Salsicha, Bacon, Calabresa, Ovo, Catupiry, Alface, Tomate, Milho e Batata Palha.',
        15.99, '/xtudo_suco.jpeg');


```
