import 'package:flutter/material.dart';

import 'Modelos.dart';
import 'dart:math' as math;
class DibujaNodo extends CustomPainter{
  List<ModeloNodo> vNodo;

  DibujaNodo(this.vNodo);

  aviso(x,y,msg,canvas){
    final textStyle = TextStyle(
        color: Colors.black,
        fontSize: 20
    );
    final testSpan = TextSpan(
        text: msg,
        style: textStyle
    );
    final textPainter= TextPainter(
        text: testSpan,
        textDirection: TextDirection.ltr
    );
    textPainter.layout(
        minWidth: 0,
        maxWidth: 30
    );
    final offset = Offset(x-10, y-10);
    textPainter.paint(canvas, offset);
  }


  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint lapizPintura = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.amber.shade400;
    Paint lapizborde = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.amber.shade400
      ..strokeWidth = 2;

    @override
    void pintarEtiqueta(Canvas canvas, String msg, double x, double y) {
      final textStyle = TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
      final textSpan = TextSpan(
        text: msg,
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: 500);
      final textSize = textPainter.size;
      print(textSize);
      textPainter.paint(
        canvas,
        Offset(x - (textSize.width) / 2,y-50),
      );
    }

    vNodo.forEach((element) {
      canvas.drawCircle(Offset(element.x, element.y), element.r, lapizPintura);
      canvas.drawCircle(Offset(element.x, element.y), element.r, lapizborde);
      pintarEtiqueta(canvas,element.msg, element.x, element.y);


    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
class DibujaArco extends CustomPainter{
  List<ModeloArco>arco;


  aviso(x,y,msg,canvas){
    final textStyle = TextStyle(
      color: Color.fromARGB(255, 38, 83, 126),
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );

    final testSpan = TextSpan(
        text: msg,
        style: textStyle
    );
    final textPainter= TextPainter(
        text: testSpan,
        textDirection: TextDirection.ltr
    );
    textPainter.layout(
        minWidth: 0,
        maxWidth: 150
    );
    final offset = Offset(x, y);
    textPainter.paint(canvas, offset);
  }
  DibujaArco(this.arco);
  @override
  void paint(Canvas canvas, Size size) {
    Paint lapiz = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..color = Color.fromARGB(255, 38, 83, 126);
    arco.forEach((element) {
      canvas.drawLine(Offset(element.nodopartida.x,element.nodopartida.y), Offset(element.nodollegada.x,element.nodollegada.y), lapiz);
      double x1=((element.nodollegada.x.toDouble()+element.nodopartida.x.toDouble())/2).abs();
      double y1=((element.nodollegada.y.toDouble()+element.nodopartida.y.toDouble())/2).abs();
      aviso(x1, y1, element.distancia.toString(), canvas);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


class DibujaArcoCiruclar extends CustomPainter{
  List<ModeloArcoCircular> arco;
  @override
  void aviso(x,y,msg,canvas){
    final textStyle = TextStyle(
        color: Color.fromARGB(255, 38, 83, 126),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
    );

    final testSpan = TextSpan(
        text: msg,
        style: textStyle
    );
    final textPainter= TextPainter(
        text: testSpan,
        textDirection: TextDirection.ltr
    );
    textPainter.layout(
        minWidth: 0,
        maxWidth: 150
    );
    final offset = Offset(x-10, y-10);
    textPainter.paint(canvas, offset);
  }

  DibujaArcoCiruclar(this.arco);
  @override
  void paint(Canvas canvas, Size size) {
      arco.forEach((element) {
        final Rect forma = Rect.fromLTWH(element.nodopartida.x+1.5,element.nodopartida.y-17,35, 35);
        final double angIni = -math.pi / 2;
        final double angFin = math.pi;
        final lapiz = Paint()
            ..color = Color.fromARGB(255, 38, 83, 126)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4;

        canvas.drawArc(forma, angIni ,angFin, false, lapiz);

        double x1=((element.nodollegada.x.toDouble()+element.nodopartida.x.toDouble())/2).abs();
        double y1=((element.nodollegada.y.toDouble()+element.nodopartida.y.toDouble())/2).abs();
        aviso(x1 + 50, y1, element.distancia.toString(), canvas);

        final p1 = Offset(element.nodopartida.x, element.nodopartida.y);
        final p2 = Offset(element.nodollegada.x.toDouble() + 10,element.nodollegada.y.toDouble() + 18);

        final angulo = angFin - 0.1;// ANGULO DE FLECHA
        final sizeFlecha = 13;// TAMAÑO DE FLECHA
        final anguloFlechaFinal =  25 * math.pi / 180;

        final path = Path();

        path.moveTo(p2.dx - sizeFlecha * math.cos(angulo - anguloFlechaFinal),
            p2.dy - sizeFlecha * math.sin(angulo - anguloFlechaFinal));
        path.lineTo(p2.dx, p2.dy);
        path.lineTo(p2.dx - sizeFlecha * math.cos(angulo + anguloFlechaFinal),
            p2.dy - sizeFlecha * math.sin(angulo + anguloFlechaFinal));

        final flecha = Paint()
          ..color = Color.fromARGB(255, 38, 83, 126)
          ..strokeWidth = 2;
        path.close();
        canvas.drawPath(path, flecha);
    });
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}