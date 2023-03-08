import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grafos_own/Help.dart';
import 'Modelos.dart';
import 'graficos.dart';

import 'package:fluttertoast/fluttertoast.dart';


class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();


}

class _MyHomeState extends State<MyHome> {
  // VARIABLES UNIVERSALES
  Map<String,List<dynamic>> mapaNodos = {}; // MAPA PARA ALMACENAR NODO, LISTA[NODOS]
  int modo = 0; // VARIABLE CONTROLADORA ACCIÓN
  String nodoInicial = ''; // VARIABLE PARA RECONOCER ETIQUETA DE NODOS EN SWIPE
  String nodoFinal = '';  // VARIABLE PARA RECONOCER ETIQUETA DE NODOS EN SWIPE
  List<List<double>> matriz = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              painter: DibujaNodo(mapaNodos),
            ),
            CustomPaint(
              painter: DibujaArco(mapaNodos),
            ),
            CustomPaint(

            ),
            GestureDetector(
              onPanDown: (ubi) async {
                  switch(modo){
                    // INICIO DE CREAR NODO Y AÑADE ETIQUETA
                    case 1:{
                      String key = await getEtiquetaNodo(ubi);
                      bool flag = true;
                      key = key.toUpperCase();
                      if (key != '')
                        flag = mapaNodos.containsKey(key);
                      else{
                        customToast("Mensaje vacio");
                        return;
                      }
                      if (!flag)
                        mapaNodos[key] = [ModeloNodo(ubi.globalPosition.dx, ubi.globalPosition.dy, key)];
                      else
                        customToast("Etiqueta repetida");

                    }
                    break;

                  // INICIO DE ARCO AUTO REFERENCIADO
                    case 4:{
                      String etiquetaNodo = buscarNodo(ubi.globalPosition.dx, ubi.globalPosition.dy);
                      bool flag = true;
                      String arco = "";
                      if (etiquetaNodo!= ''){
                        flag = isArcoLoopRepetido(etiquetaNodo);
                      }
                      else {
                        customToast("No se selecciono ningún nodo");
                        return;
                      }
                      if (!flag){
                        arco = await getValorArcoLoop(ubi);
                      }
                      else {
                        customToast("\"$etiquetaNodo\" ya tiene un arco de este tipo");
                        return;
                      }
                      try{
                        if (arco != '' )
                        {
                          mapaNodos[etiquetaNodo]?.add(ModeloArco(mapaNodos[etiquetaNodo]![0],mapaNodos[etiquetaNodo]![0], double.parse(arco), 0));
                        }
                      }
                      catch(e){
                        customToast("Valor ingresado erroneo");
                      }
                    }
                    break;
                    // BORRAR PANTALLA
                    case 5:{
                      if (mapaNodos.length != 0){
                        mapaNodos.clear();
                        matriz = [];
                        customToast("Nodos eliminados");
                      }
                      else
                        customToast("No hay nada que borrar");
                    }
                    break;
                  case 6:{
                   //    print(mapaNodos);
                   // mapaNodos.forEach((key, value) {
                   //      print('$key: ');
                   //      value.forEach((element) {
                   //        if (element is ModeloNodo) {
                   //          print(element.toStringPrint());
                   //        }
                   //      });
                   //    });
                      print("La longitud es: " + mapaNodos.length.toString());
                      print(mapaNodos);
                      mapaNodos.forEach((key, value) {
                        print('$key: ');
                        value.forEach((element) {
                          if (element is ModeloArco) {
                            print(element.toStringPrint());
                          }
                        });
                      });
                    }
                    break;
                    // GENERAR MATRIZ DE ADYACENCIA
                    case 7: {
                      if (mapaNodos.length > 0){
                        matriz = List.generate(mapaNodos.length, (_) => List.filled(mapaNodos.length, 0));

                        String header = '';
                        // String xx = '';
                        String mt = '';
                        List<String> keyList = mapaNodos.keys.toList();

                        int i = 0;
                        mapaNodos.forEach((key, value) {
                          int j = 0;// COLUMNAS
                          header += "$key\t";
                          keyList.forEach((lk) {
                            value.forEach((element) {
                                if (element is ModeloArco && element.nodollegada.msg == lk){
                                  //xx += element.distancia.toString() + "\t";
                                  matriz[i][j] = element.distancia;
                                }
                            });
                            // xx += "($i,$j)";
                            j+=1;
                          });
                          i += 1;
                          // xx +="\n";
                        });


                        for(int i = 0; i < matriz.length; i += 1){
                          for (int j = 0; j < matriz.length; j += 1){
                            mt += matriz[i][j].toString() + '\t';
                          }
                          mt += '\n';
                        }
                        print(header);
                        print (mt);

                      }
                      else{
                        customToast("Agrege nodos para generar la matriz");
                      }

                    }
                    break;
                };
                  setState(() {

                  });
              },
              onPanUpdate: (ubi) async {
                switch (modo) {
                  // DE MOVER NODO
                  case 2:
                    {
                      setState(() {
                        // INICIO DE MOVER NODO
                        if (modo == 2) {
                          String etiquetaNodo = buscarNodo(
                              ubi.globalPosition.dx, ubi.globalPosition.dy);
                          if (etiquetaNodo != '') {
                            (mapaNodos[etiquetaNodo]![0] as ModeloNodo).x =
                                ubi.globalPosition.dx;
                            (mapaNodos[etiquetaNodo]![0] as ModeloNodo).y =
                                ubi.globalPosition.dy;
                          }
                        }
                      });
                    }
                    break;
                // AÑADIR ARCO (BUSCAR NODO FINAL)
                  case 3:
                    {
                      if (nodoInicial != '') {
                        nodoFinal = buscarNodo(
                            ubi.globalPosition.dx, ubi.globalPosition.dy);
                      }
                      if (nodoInicial != nodoFinal && nodoFinal != '') {
                        bool flag = isArcoRepetido(nodoInicial,nodoFinal); // CONDICION CHECKEO NODO REPETIDO
                        if (!flag) {
                          List<String>? arco = await getValorArco(ubi);
                          if (arco != null && double.tryParse(arco[0]) != null) {
                            arco.add(nodoInicial);
                            arco.add(nodoFinal);
                            addArcoNormal(arco!);
                            setState(() {
                              nodoInicial = '';
                              nodoFinal = '';
                            });
                          }
                          else {
                            customToast("Valor ingresado erroneo");
                          }
                        } else {
                          customToast("\"$nodoInicial\" ya tiene un arco de ese tipo");
                          setState(() {
                            nodoInicial = '';
                            nodoFinal = '';
                          });
                          return;
                        }
                      }

                    }
                  break;
                }
              },
              onPanStart:(details){
                // AÑADIR ARCO (BUSCAR NODO INICIAL)
                if (modo == 3){
                  nodoInicial = '';
                  nodoFinal = '';
                  nodoInicial = buscarNodo(details.globalPosition.dx, details.globalPosition.dy);
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.amber.shade700,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ICONO AÑADIR NODO
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 1;
                    });
                  },
                  icon: Icon(Icons.add_circle_outline,
                      color: (modo == 1) ? Colors.green : Colors.red)),
              // ICONO MOVER NODO
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 2;
                    });
                  },
                  icon: Icon(Icons.open_with,
                      color: (modo == 2) ? Colors.green : Colors.red)),
              // ICONO CREAR ARCO
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 3;
                    });
                  },
                  icon: Icon(Icons.open_in_full, //swipe
                      color: (modo == 3) ? Colors.green : Colors.red)),
              // ICONO CREAR ARCO AUTO REFERENCIADO
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 4;
                    });
                  },
                  icon: Icon(Icons.replay,
                      color: (modo == 4) ? Colors.green : Colors.red)),
              // ICONO BORRAR
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 5;
                    });
                  },
                  icon: Icon(Icons.cleaning_services,
                      color: (modo == 5) ? Colors.green : Colors.red)),
              // ICONO MODIFICAR ETIQUETAS
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 6;
                    });
                  },
                  icon: Icon(Icons.auto_fix_high_outlined,
                      color: (modo == 6) ? Colors.green : Colors.red)),
              // ICONO GENERAR MATRIZ
              IconButton(
                  onPressed: () {
                    setState(() {
                      modo = 7;
                    });
                  },
                  icon: Icon(Icons.data_array,
                      color: (modo == 7) ? Colors.green : Colors.red)),
              // ICONO AYUDA
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Help()));
                    });
                  },
                  icon: Icon(Icons.help, color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }


  // FUNCION PARA OBTENER ETIQUETA DE ARCO LOOP POR showDialog<String>
  Future<String> getValorArcoLoop(ubi) async {
    String? output;
    final controlador = TextEditingController();
      final ans = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Crear arco referenciado'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Ingrese peso del arco'),
              keyboardType: TextInputType.number,
              controller: controlador,
            ),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed:() => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Crear nodo'),
                onPressed:() => Navigator.pop(context,controlador.text.toString().trimRight()),
              ),
            ],
          )
      );
      output = ans;
      return output ?? '';// RETURNS '' SI ESTA NULO
  }



 // FUNCION PARA OBTENER ETIQUETA DE ARCO NORMAL POR showDialog<String>
  Future<List<String>?> getValorArco(ubi) async {
    String? output;
    String combo = '->';
    final controlador = TextEditingController();
    final ans = await showDialog<String>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Crear arco'),
            content: StatefulBuilder(
              builder: (BuildContext context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: 'Ingrese peso del arco'),
                      keyboardType: TextInputType.number,
                      controller: controlador,
                    ),
                    Text(''),
                    Text('TIPO DE ARCO'),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(nodoInicial),
                          DropdownButton(
                            style: const TextStyle(color: Colors.deepPurple),
                            items: [
                              DropdownMenuItem(
                                  value: '->',
                                  child: Icon(
                                      Icons.arrow_right_alt_rounded, size: 25,
                                      color: Colors.black)),
                              DropdownMenuItem(
                                  value: '<->',
                                  child: Icon(Icons.swap_horiz, size: 25,
                                      color: Colors.black)),
                            ],
                            value: combo,
                            onChanged: (val) {
                              state(() {
                                if (val != null)
                                  combo = val;
                              });
                            },
                          ),
                          Text(nodoFinal),
                        ]
                    )
                  ],
                );
              },
            ),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Crear nodo'),
                onPressed: () =>
                    Navigator.pop(
                        context, controlador.text.toString().trimRight()),
              ),
            ],
          ),
      );
      output = ans;
      if (output =='' || output == null)
        return null;
      else{
        List<String> x =[output,combo];
        return x;
      }
    }




  void addArcoNormal(List<String> arco)
  {
    bool flag = true;
    if (arco[1] == '->') flag = true;
    else flag = false;

    String ni = arco[2];
    String nf = arco[3];
    double peso = double.parse(arco[0]);
    print(arco);
    if (flag == true){ // ARCO UNIDIRIGIDO
      mapaNodos[ni]?.add(ModeloArco(mapaNodos[ni]![0],mapaNodos[nf]![0], peso,1));
    }else{ // ARCO DOBLE
      mapaNodos[ni]?.add(ModeloArco(mapaNodos[ni]![0],mapaNodos[nf]![0], peso,2));
      mapaNodos[nf]?.add(ModeloArco(mapaNodos[nf]![0],mapaNodos[ni]![0], peso,2));
    }

  }





  // FUNCION PARA OBTENER ETIQUETA DE NODO POR showDialog<String>
  Future<String> getEtiquetaNodo(ubi) async {
    final controlador = TextEditingController();
    final ans = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Etiqueta de nodo'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Ingrese etiqueta'),
            keyboardType: TextInputType.text,
            controller: controlador,
          ),
          actions: [
            TextButton(
                child: Text('Cancelar'),
                onPressed:() => Navigator.pop(context),
            ),
            TextButton(
                child: Text('Crear nodo'),
                onPressed:() => Navigator.pop(context,controlador.text.toString().trimRight()),
            ),
          ],
        )
    );
    return ans ?? ''; // RETURNS '' SI ESTA NULO
  }

  // FUNCION PARA MOSTRAR TOAST CON MENSAJE CUSTOM
  void customToast(String mensaje){
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  // FUNCION PARA BUSCAR POSICIÓN DE NODO AL HACER CLICK SOBRE EL
  String buscarNodo(double x2, double y2) {
    String ans = "";
    double x1 = 0;
    double y1 = 0;
    double r = 25;
    double dist = 0;

    mapaNodos.forEach((key, value) {
      value.forEach((element) {
        if (element is ModeloNodo) {
          x1 = element.x;
          y1 = element.y;
          dist = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
          if (dist <= r) {
            ans = element.msg;
            return;
          }
        }
      });
    });
    return ans ?? '';
  }

  // FUNCION PARA VERIFICAR SI NODO YA TIENE UN ARCO LOOP
  bool isArcoLoopRepetido(etiquetaNodo)
  {
    bool flag = false;
    mapaNodos[etiquetaNodo]?.forEach((element) {
          if (element is ModeloArco) {
            if (element.nodopartida.msg == element.nodollegada.msg && element.nodollegada.msg == etiquetaNodo) {
              flag = true;// ES REPETIDO
              return;
            }
          }
       });
    return flag;
  }

  // FUNCION PARA VERIFICAR SI EL NODO YA TIENE UN ARCO (SIMPLE O DOBLE)
  isArcoRepetido(String nodoInicial, String nodoFinal){
    bool flag = false;
    print("NodoInicial: $nodoInicial || NodoFInal: $nodoFinal");
    mapaNodos[nodoInicial]?.forEach((element) {
      if (element is ModeloArco) {
        if (element.nodopartida.msg == nodoInicial && element.nodollegada.msg == nodoFinal){
            flag = true;
            return;
        }
      }
    });

    mapaNodos[nodoFinal]?.forEach((element) {
      if (element is ModeloArco) {
        if (element.nodopartida.msg == nodoFinal && element.nodollegada.msg == nodoInicial){
          flag = true;
          return;
        }
      }
    });
    return flag;

  }
}