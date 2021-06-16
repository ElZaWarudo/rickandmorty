import 'package:flutter/material.dart';
import 'package:rikcandmorty/contractsView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  late TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    _passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localizador de contratos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
                "https://pm1.narvii.com/6733/101c334865789cb52dd154a41600c4d142209c8fv2_hq.jpg"),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                "Ingrese el codigo suministrado para ver la información de los contratos a cazar",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Codigo aquí'),
              controller: _passController,
            ),
            TextButton(
              onPressed: () => _verify(context),
              child: Text("Consultar"),
            )
          ],
        ),
      ),
    );
  }

  void _verify(BuildContext context) {
    if (_passController.text == "where are my plumbus Morty?") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => contracts()),
      );
    } else {
      _alert(context);
    }
  }

  void _alert(BuildContext context) {
    var alert = AlertDialog(
      title: const Text('Codigo incorrecto'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Parece que su codigo no es valido'),
            Text('Reporte su problema a la federación galactica'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Reintentar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
