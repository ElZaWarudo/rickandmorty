import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rikcandmorty/models/caracter.dart';
import 'package:http/http.dart' as http;

import 'caracterView.dart';

class contracts extends StatefulWidget {
  const contracts({Key? key}) : super(key: key);

  @override
  _contractsState createState() => _contractsState();
}

class _contractsState extends State<contracts> {
  var list = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15"
  ];
  late Future<List<Caracter>> _caracters;

  List<Caracter> caracters = [];
  Future<List<Caracter>> _getCaracters() async {
    var number = (list.toList()..shuffle()).first;
    final response = await http.get(
        Uri.parse("https://rickandmortyapi.com/api/character/?page=" + number));
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);
      for (var caracter in json["results"]) {
        caracters.add(Caracter(
            caracter["name"],
            caracter["status"],
            caracter["species"],
            caracter["gender"],
            caracter["origin"]["name"],
            caracter["location"]["name"],
            caracter["image"]));
      }
      return caracters;
    } else {
      throw Exception("Error");
    }
    return caracters;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _caracters = _getCaracters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de contratos"),
      ),
      body: FutureBuilder(
        future: _caracters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              children: _caractersList(snapshot.data),
            );
          } else if (snapshot.hasError) {
            return (Text("error"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> _caractersList(data) {
    List<Widget> caracters = [];
    for (var caracter in data) {
      caracters.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CaracterView(caracter)),
            );
          },
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(caracter.image, fit: BoxFit.fill)),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    caracter.name,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return caracters;
  }

  Widget search() {
    final styleActive = TextStyle(color: Colors.black);
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
