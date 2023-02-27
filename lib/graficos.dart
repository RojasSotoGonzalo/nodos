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
    vNodo.forEach((element) {
      canvas.drawCircle(Offset(element.x, element.y), element.r, lapizPintura);
      canvas.drawCircle(Offset(element.x, element.y), element.r, lapizborde);
      aviso(element.x, element.y, element.msg, canvas);
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
  DibujaArcoCiruclar(this.arco);
  @override
  void paint(Canvas canvas, Size size) {
      arco.forEach((element) {
      final Rect forma = Rect.fromLTWH(element.nodopartida.x+3,element.nodopartida.y-16,35, 35);
      final double angIni = -math.pi / 2;
      final double angFin = math.pi;
      final lapiz = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;
      canvas.drawArc(forma, angIni ,angFin, false, lapiz);
      double x1=((element.nodollegada.x.toDouble()+element.nodopartida.x.toDouble())/2).abs();
      double y1=((element.nodollegada.y.toDouble()+element.nodopartida.y.toDouble())/2).abs();
      aviso(x1 + 0, y1, element.distancia.toString(), canvas);
    });
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}