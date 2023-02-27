

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'Modelos.dart';
import 'graficos.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}
class _MyHomeState extends State<MyHome> {
  List<ModeloNodo> vNodo = [];
  List<ModeloArco> vArco = [];
  List<ModeloArcoCircular> cArco = [];

  int nruNodo = 1;
  int modo = -1;
  var _nodo,_in,_fi,ruta;
  Map re = {};

  final nodos = new TextEditingController();
  final inicio = new TextEditingController();
  final fin = new TextEditingController();
  ModeloNodo nodopartida= ModeloNodo(-1, -1, 0, '-1');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              painter: DibujaArco(vArco),
            ),
            CustomPaint(
              painter: DibujaNodo(vNodo),
            ),
            CustomPaint(
              painter: DibujaArcoCiruclar(cArco),
            ),

            GestureDetector(
              onPanDown: (ubi) {
                setState(() {
                  if (modo == 1) {
                    vNodo.add(ModeloNodo(
                        ubi.globalPosition.dx, ubi.globalPosition.dy, 25,
                        nruNodo.toString()));
                    nruNodo++;
                  } else {
                    if (modo == 3) {
                      int pos = BuscaNodo(
                          ubi.globalPosition.dx, ubi.globalPosition.dy);
                      if (pos >= 0) {
                        if (nodopartida.x == -1) {
                          nodopartida = vNodo[pos];
                          openDialogo();
                        } else {
                          double r = double.parse(_nodo);
                          vArco.add(ModeloArco(nodopartida, vNodo[pos], r));
                          llena(double.parse(nodopartida.msg.toString()), double.parse(vNodo[pos].msg.toString()), r);
                          nodopartida = vNodo[pos];
                          openDialogo();
                          llena(double.parse(nodopartida.msg.toString()), double.parse(vNodo[pos].msg.toString()), r);
                          nodopartida = vNodo[pos];
                        }
                      }
                    }

                    if (modo == 4) {
                      int pos = BuscaNodo(
                          ubi.globalPosition.dx, ubi.globalPosition.dy);
                      nodopartida = vNodo[pos];
                      double r = 5000;
                      cArco.add(ModeloArcoCircular(nodopartida,nodopartida, 0, r));
                      llena(double.parse(nodopartida.msg.toString()), double.parse(vNodo[pos].msg.toString()), r);
                      nodopartida = vNodo[pos];
                      

                    } else {
                      if (modo == 5) {
                        nruNodo = 0;
                        vArco.clear();
                        vNodo.clear();
                        cArco.clear(); 
                        re.clear();
                      }
                    }
                  }
                });
              },
              onPanUpdate: (ubi) {
                setState(() {
                  if (modo == 2) {
                    int pos = BuscaNodo(
                        ubi.globalPosition.dx, ubi.globalPosition.dy);
                    if (pos >= 0) {
                      print('Esta dentro el Nodo Pos..$pos');
                      vNodo[pos].x = ubi.globalPosition.dx;
                      vNodo[pos].y = ubi.globalPosition.dy;
                    }
                  }
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.amber.shade700,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 1;
                    });
                  },
                  icon: Icon(Icons.add,
                      color: (modo == 1) ? Colors.green : Colors.red)),

              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 2;
                    });
                  },
                  icon: Icon(Icons.back_hand,
                      color: (modo == 2) ? Colors.green : Colors.red)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 3;
                    });
                  },
                  icon: Icon(Icons.arrow_downward,
                      color: (modo == 3) ? Colors.green : Colors.red)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 4;
                    });
                  },
                  icon: Icon(Icons.airline_stops,
                      color: (modo == 4) ? Colors.green : Colors.red)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 5;
                    });
                  },
                  icon: Icon(Icons.block,
                      color: (modo == 5) ? Colors.green : Colors.red)),

            ],
          ),
        ),
      ),
    );
  }

  int BuscaNodo(double x2, double y2) {
    int pos = -1,
        i;
    for (i = 0; i < vNodo.length; i++) {
      double x1 = vNodo[i].x;
      double y1 = vNodo[i].y;
      double r1 = vNodo[i].r;
      double dist = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
      if (dist <= r1) {
        pos = i;
        i = vNodo.length + 1;
      }
    }
    return pos;
  }



  void llena(double a, double b, double c) {
    for (double key in re.keys) {
      if (a == key) {
        re[key].addAll({c: b});
      } else
        re.addAll({a: {c: b}});
    }
  }

  Future<String?> openDialogo() =>
      showDialog<String>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Nuevo Dato'),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: 'Nuevo dato'),
                keyboardType: TextInputType.number,
                controller: nodos,

              ),
              actions: [
                TextButton(
                  child: Text('Nuevo dato'),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                      _nodo = nodos.text;
                      nodos.text="";
                    });
                  },
                ),
              ],
            ),
      );

 


}