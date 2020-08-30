import 'dart:ui';

import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  var _masa = '';
  var _altura = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IMC kalkulator")),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage('images/homens.png'),
            ),
          ),
          Divider(),
          _crearMasaField(),
          Divider(),
          _crearAlturaField(),
          Divider(),
          _crearBoton(context)
        ],
      ),
    );
  }

  Widget _crearMasaField() {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: "Masa(Kg)",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          icon: Icon(Icons.accessibility),
          helperText: "Use el punto"),
      onChanged: (valor) {
        this._masa = valor;
      },
    );
  }

  Widget _crearAlturaField() {
    return TextField(
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Altura(m)",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          icon: Icon(Icons.accessibility),
          helperText: "Use el punto"),
      onChanged: (valor) {
        this._altura = valor;
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: Text("Obtener IMC"),
      shape: StadiumBorder(),
      onPressed: () => _getIMC(context),
    );
  }

  void _getIMC(BuildContext context) {
    try {
      if (this._masa.length == 0 || this._altura.length == 0) {
        _showMessageError(context,
            "Campos Vacío, verifique que todos los campos esten correctamente llenados");
      } else {
        var imcResult = double.parse(this._masa) /
            (double.parse(this._altura) * double.parse(this._altura));
        if (imcResult < 16) {
          _showResultados(
              context,
              "Delgadez severa",
              Colors.red[400],
              Image(
                image: AssetImage("images/degasevere.png"),
              ),
              imcResult.toStringAsFixed(2));
        } else if (imcResult < 17) {
          _showResultados(
              context,
              "Delgadez moderada",
              Colors.orange[400],
              Image(
                image: AssetImage("images/degamoderate.jpg"),
              ),
              imcResult.toStringAsFixed(2));
        } else if (imcResult < 18.5) {
          _showResultados(
              context,
              "Delgadez acpetable",
              Colors.yellow[400],
              Image(
                image: AssetImage("images/delgacceptable.jpg"),
              ),
              imcResult.toStringAsFixed(2));
        } else if (imcResult < 25) {
          _showResultados(
              context,
              "Normal",
              Colors.green[400],
              Image(
                image: AssetImage("images/normal.jpg"),
              ),
              imcResult.toStringAsFixed(2));
        } else if (imcResult < 30) {
          _showResultados(
              context,
              "Sobrepeso",
              Colors.yellow[400],
              Image(
                image: AssetImage("images/sobrep.jpg"),
              ),
              imcResult.toStringAsFixed(2));
        } else if (imcResult < 35) {
          _showResultados(
              context,
              "Obesidad tipo I",
              Colors.orange[400],
              Image(
                image: AssetImage("images/obs1.jpg"),
              ),
              imcResult.toStringAsFixed(2));
        } else if (imcResult < 40) {
          _showResultados(
              context,
              "Obesidad tipo II",
              Colors.orange[400],
              Image(
                image: AssetImage("images/obs2.jpg"),
              ),
              imcResult.toStringAsFixed(2));
        } else if (imcResult < 50) {
          _showResultados(
              context,
              "Obesidad tipo III",
              Colors.orange[900],
              Image(
                image: AssetImage("images/obs3.jpg"),
              ),
              imcResult.toStringAsFixed(2));
        } else {
          _showResultados(
              context,
              "Obesidad tipo IV",
              Colors.redAccent[700],
              Image(
                image: AssetImage("images/obs4.jpg"),
              ),
              imcResult.toStringAsFixed(2));
        }
      }
    } on Exception {
      _showMessageError(
          context, "Valores inválidos como: \n ', / () # & : = * + -' ");
    }
  }

  void _showMessageError(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nombre Alerta"),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                child: Text("OK"), onPressed: () => Navigator.of(context).pop())
          ],
        );
      },
    );
  }

  void _showResultados(BuildContext context, String info, Color color,
      Image image, String resultado) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Estado de IMC:\n $info'),
          backgroundColor: color,
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('IMC = $resultado'),
              Container(child: image)
            ],
          ),
          actions: <Widget>[
            FlatButton(
                textColor: Colors.white,
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop())
          ],
        );
      },
    );
  }
}
