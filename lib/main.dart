import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// requisição assíncrona é aquela que ao ser realizada, não precisamos ficar esperando após receber os dados
//Ou seja, assim que recebermos os dados, a aplicação imediatamente faz algo com eles. Sem ficar travada.
import 'dart:convert';

import 'home.dart';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=012b6cd6";

void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.amber[300],
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

//Criando uma função que vai me retornar um dado no futuro. Nesse caso, vai retornar um MAPA no futuro.
Future<Map> getData() async {
  //getData é o nome da função
  http.Response response = await http
      .get(request); //Response significa a resposta que vou obter da API.
  //http.get(request) significa que vou mandar um get para o servidor com a URL do request.
  //o await deve ser usado pois vamos esperar os dados chegarem do get, e para isso precisamos declarar o async.
  return json.decode(response.body);
}
