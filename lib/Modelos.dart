class ModeloNodo{
  double x,y; // COORDENADAS
  String msg; // ETOQIETA NODO
  ModeloNodo(this.x, this.y,this.msg);

  String toStringPrint(){
      return "Coordenadas: ($x,$y) || Mensaje: $msg";
  }
}

class ModeloArco{
  ModeloNodo nodopartida,nodollegada;// NODOS DE RECORRIDO
  double distancia; // PESO DEL ARCO
  int flag; // CONTROL DIBUJO (flag == 0 (LOOP); flag == 1(SENCILLO); flag == 2(DOBLE)
  ModeloArco(this.nodopartida,this.nodollegada, this.distancia, this.flag );

  String toStringPrint(){
    return "Nodo Partida : (${nodopartida.msg}) || Nodo Llegada: (${nodollegada.msg}) || Distancia: (${distancia}) || Flag: (${flag}";
  }
}