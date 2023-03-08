import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Help extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade700,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.help, size:30,color: Colors.red),
              SizedBox(width: 10.0),
              Text('Ayuda',style: TextStyle(fontSize: 30, color:Colors.red)),
              SizedBox(width: 10.0),
              Icon(Icons.help, size:30,color: Colors.red),
            ],
          ),
        ),
        body: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle_outline, size:80,color: Colors.red),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Crear nodo',style: TextStyle(fontSize: 30, color:Colors.red,fontWeight: FontWeight.bold,)),
                            Text('Crea nuevos nodos y le asigna una etiquetas', style: TextStyle(fontSize: 15, color:Colors.black, fontStyle: FontStyle.italic)),

                          ]
                      )
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.blueGrey),

                  Row(
                    children: [
                      Icon(Icons.open_with, size:80,color: Colors.red),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mover nodo',style: TextStyle(fontSize: 30, color:Colors.red,fontWeight: FontWeight.bold,)),
                            Text('Cambia nodo y arcos de posición',style: TextStyle(fontSize: 15, color:Colors.black, fontStyle: FontStyle.italic)),
                          ]
                      )
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.blueGrey),

                  Row(
                    children: [
                      Icon(Icons.open_in_full, size:80,color: Colors.red),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Crear arco',style: TextStyle(fontSize: 30, color:Colors.red,fontWeight: FontWeight.bold,)),
                            Text('Crear arcos dobles, simples o sin dirección',style: TextStyle(fontSize: 15, color:Colors.black, fontStyle: FontStyle.italic)),
                          ]
                      )
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.blueGrey),

                  Row(
                    children: [
                      Icon(Icons.replay, size:80,color: Colors.red),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Crear arco referencial',style: TextStyle(fontSize: 30, color:Colors.red,fontWeight: FontWeight.bold,)),
                            Text('Crear arco referencial al mismo nodo',style: TextStyle(fontSize: 15, color:Colors.black, fontStyle: FontStyle.italic)),
                          ]
                      )
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.blueGrey),

                  Row(
                    children: [
                      Icon(Icons.cleaning_services, size:80,color: Colors.red),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Limpiar o borrar',style: TextStyle(fontSize: 30, color:Colors.red,fontWeight: FontWeight.bold,)),
                            Text('Limpia toda la pantalla o un componente',style: TextStyle(fontSize: 15, color:Colors.black, fontStyle: FontStyle.italic)),
                          ]
                      )
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.blueGrey),

                  Row(
                    children: [
                      Icon(Icons.auto_fix_high_outlined, size:80,color: Colors.red),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cambiar etiqueta',style: TextStyle(fontSize: 30, color:Colors.red,fontWeight: FontWeight.bold,)),
                            Text('Cambia el valor de una etiqueta creada',style: TextStyle(fontSize: 15, color:Colors.black, fontStyle: FontStyle.italic)),
                          ]
                      )
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.blueGrey),

                  Row(
                    children: [
                      Icon(Icons.data_array, size:80,color: Colors.red),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Generar matriz',style: TextStyle(fontSize: 30, color:Colors.red,fontWeight: FontWeight.bold,)),
                            Text('Genera la matriz para disposición actual',style: TextStyle(fontSize: 15, color:Colors.black, fontStyle: FontStyle.italic)),
                          ]
                      )
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.blueGrey),
                  Row(
                    children: [
                      Icon(Icons.help, size:80,color: Colors.red),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ayuda',style: TextStyle(fontSize: 30, color:Colors.red,fontWeight: FontWeight.bold,)),
                            Text('Información de interfaz',style: TextStyle(fontSize: 15, color:Colors.black, fontStyle: FontStyle.italic)),
                          ]
                      )
                    ],
                  ),

                ],
              ),
              //child: Text("HOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLAHOLA", style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),


        bottomNavigationBar: BottomAppBar(
          color: Colors.amber.shade700,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ICONO AÑADIR NODO
              IconButton(
                  onPressed: () {
                    customToast("Para salir, presione atras o el botón de ayuda");
                  },
                  icon: Icon(Icons.add_circle_outline, color: Colors.red)),
              // ICONO MOVER NODO
              IconButton(
                  onPressed: () {
                    customToast("Para salir, presione atras o el botón de ayuda");
                  },
                  icon: Icon(Icons.open_with, color: Colors.red)),
              // ICONO CREAR ARCO
              IconButton(
                  onPressed: () {
                    customToast("Para salir, presione atras o el botón de ayuda");
                  },
                  icon: Icon(Icons.open_in_full, color: Colors.red)),
              // ICONO CREAR ARCO AUTO REFERENCIADO
              IconButton(
                  onPressed: () {
                    customToast("Para salir, presione atras o el botón de ayuda");
                  },
                  icon: Icon(Icons.replay, color: Colors.red)),
              // ICONO BORRAR
              IconButton(
                  onPressed: () {
                    customToast("Para salir, presione atras o el botón de ayuda");
                  },
                  icon: Icon(Icons.cleaning_services,color: Colors.red)),
              // ICONO MODIFICAR ETIQUETAS
              IconButton(
                  onPressed: () {
                    customToast("Para salir, presione atras o el botón de ayuda");
                  },
                  icon: Icon(Icons.auto_fix_high_outlined, color: Colors.red)),
              // ICONO GENERAR MATRIZ
              IconButton(
                  onPressed: () {
                    customToast("Para salir, presione atras o el botón de ayuda");
                  },
                  icon: Icon(Icons.data_array,color: Colors.red)),
              // ICONO AYUDA
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.exit_to_app, color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
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
}