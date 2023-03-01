

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'Modelos.dart';
import 'graficos.dart';

import 'package:fluttertoast/fluttertoast.dart';


class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}
class _MyHomeState extends State<MyHome> {
  List<ModeloNodo> vNodo = [];
  List<ModeloArco> vArco = [];
  List<ModeloArcoCircular> cArco = [];
  List<MatrizAdya> Rmatriz = [];

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
                  switch(modo) {
                    // CREAR NODO Y AÑADE ETIQUETA
                    case 1: {
                      crearNodo(ubi);

                    }
                    break;
                    // NO SE SABE COMO SE MUEVE EL NODO
                    case 2: {
                      //statements;
                    }
                    break;

                    // CREAR ARCO Y ETIQUETA DE PESO
                    case 3: {
                      int pos = BuscaNodo(ubi.globalPosition.dx, ubi.globalPosition.dy);


                      if (pos >= 0 && nodopartida.x == - 1) {
                        nodopartida = vNodo[pos];
                        openDialogo();
                      }
                      else if (pos >= 0 && nodopartida.x != - 1) {
                        openDialogo();
                        double r = double.parse(_nodo);
                        vArco.add(ModeloArco(nodopartida, vNodo[pos], r));

                        String msg1 = nodopartida.msg;
                        String msg2 = vNodo[pos].msg;

                        nodopartida = vNodo[pos];

                        //llena(double.parse(nodopartida.msg.toString()), double.parse(vNodo[pos].msg.toString()), r);
                        nodopartida = vNodo[pos];

                        Rmatriz.add(MatrizAdya(msg1, msg2, r));
                      }
                    }
                    break;


                    // CREAR ARTO REFERENCIADO Y ETIQUETA DE PESO
                    case 4: {
                      int pos = BuscaNodo(
                          ubi.globalPosition.dx, ubi.globalPosition.dy);
                      arcoAuto(ubi, pos);

                    }
                    break;


                    case 5: {
                      nruNodo = 0;
                      vArco.clear();
                      vNodo.clear();
                      cArco.clear();
                      re.clear();
                    }
                    break;

                    // MATRIZ ADYACENTE
                    case 6: {

                    }
                    break;
                  }
                });
              },
              onPanUpdate: (ubi) {
                setState(() {
                  switch (modo)
                  {
                    // MOVIMIENTO DE NODO
                    case 2:{
                      int pos = BuscaNodo(ubi.globalPosition.dx, ubi.globalPosition.dy);
                      print('Esta dentro el Nodo Pos..$pos');
                      vNodo[pos].x = ubi.globalPosition.dx;
                      vNodo[pos].y = ubi.globalPosition.dy;
                    }
                    break;
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
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 6;
                    });
                  },
                  icon: Icon(Icons.app_registration_rounded,
                      color: (modo == 6) ? Colors.green : Colors.red)),

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

  Future<void> arcoAuto(ubi, pos) =>
      showDialog<void>(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Arco auto referido'),
                content: TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Valor de arco'),
                  keyboardType: TextInputType.number,
                  controller: nodos,
                ),
                actions: [
                  TextButton(
                      child: Text('Cancelar'),
                      onPressed:() {
                        setState(() {
                         // Navigator.of(context).pop(nodos.text.toString());
                          Navigator.of(context).pop();
                        });
                      }
                  ),
                  TextButton(
                      child: Text('Crear arco'),
                      onPressed:() {
                        setState(() {
                          nodopartida = vNodo[pos];

                          cArco.add(ModeloArcoCircular(nodopartida,nodopartida, double.parse(nodos.text)));
                          //  llena(double.parse(nodopartida.msg.toString()), double.parse(vNodo[pos].msg.toString()), r);
                          nodopartida = vNodo[pos];
                          // llena(double.parse(nodopartida.msg.toString()), double.parse(vNodo[pos].msg.toString()), r);
                          nodopartida = vNodo[pos];
                          nodos.text="";
                          Navigator.of(context).pop(nodos.text.toString());
                        });
                      }
                  ),
                ],
              )
      );

  Future<void> crearNodo(ubi) =>
      showDialog<void>(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Etiqueta de nodo'),
                content: TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Ingrese etiqueta'),
                  keyboardType: TextInputType.number,
                  controller: nodos,
                ),
                actions: [
                  TextButton(
                      child: Text('Cancelar'),
                      onPressed:() {
                        setState(() {
                          Navigator.of(context).pop(nodos.text.toString());
                        });
                      }
                  ),
                  TextButton(
                      child: Text('Crear nodo'),
                      onPressed:() {
                        setState(() {
                          bool flag = true;
                          if (vNodo.length == 0)
                            {
                              vNodo.add(ModeloNodo(
                                  ubi.globalPosition.dx, ubi.globalPosition.dy, 25, nodos.text.toString()));
                            }
                          else{
                            vNodo.forEach((element) {
                              if (nodos.text.toString() == element.msg)
                                {
                                  flag = false;
                                }
                            });
                            if (flag){
                              vNodo.add(ModeloNodo(
                                  ubi.globalPosition.dx, ubi.globalPosition.dy, 25, nodos.text.toString()));
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "Nodo Repetido",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.grey[800],
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          }
                          nodos.text="";
                          Navigator.of(context).pop();
                        });
                      }
                  ),
                ],
              )
      );


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

  Future<String?> camino_inicio() =>
      showDialog<String>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Punto inicial: '),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: '` inicio de la ruta`'),
                keyboardType: TextInputType.number,
                controller: inicio,
              ),
              actions: [
                TextButton(
                  child: Text('Nuevo dato'),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                      _in = inicio.text;
                    });
                  },
                ),
              ],
            ),
      );
  Future<String?> camino_fin() =>
      showDialog<String>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Punto Final: '),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: '`fin de la ruta`'),
                keyboardType: TextInputType.number,
                controller: fin,
              ),
              actions: [
                TextButton(
                  child: Text('Nuevo dato'),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                      _fi = fin.text;
                    });
                  },
                ),
              ],
            ),
      );


}