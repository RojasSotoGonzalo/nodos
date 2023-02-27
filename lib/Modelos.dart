

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
    double distancia,r;
    ModeloArcoCircular(this.nodopartida,this.nodollegada, this.distancia, this.r);
}