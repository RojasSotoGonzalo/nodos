

class ModeloNodo{
    double x,y,r;
    String msg;
    ModeloNodo(this.x, this.y, this.r,this.msg);
}
class ModeloArco{
    ModeloNodo nodopartida,nodollegada;
    double distancia;
    ModeloArco(this.nodopartida,this.nodollegada, this.distancia);

}
class ModeloArcoCircular{
    ModeloNodo nodopartida,nodollegada;
    double distancia;
    ModeloArcoCircular(this.nodopartida,this.nodollegada, this.distancia);
}

class MatrizAdya{
    String msg1, msg2;
    double distancia;
    MatrizAdya(this.msg1,this.msg2,this.distancia);
}