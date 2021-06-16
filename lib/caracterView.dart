import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rikcandmorty/models/caracter.dart';

class CaracterView extends StatelessWidget {
  Caracter caracter;

  CaracterView(this.caracter);

  @override
  Widget build(BuildContext context) {
    String estado, genero;
    if (caracter.status=="Alive"){
      estado="Vivo";
    }else{
      estado="Muerto";
    }
    if (caracter.gender=="Male"){
      genero="Hombre";
    }else{
      genero="Mujer";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(caracter.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(caracter.image,),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Nombre: "+caracter.name),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Estado: "+estado),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Especie: "+caracter.species),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Genero: "+genero),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Origen: "+caracter.origin),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Ubicación: "+caracter.location),
            )
          ],
        ),
      ),
    );
  }
}
