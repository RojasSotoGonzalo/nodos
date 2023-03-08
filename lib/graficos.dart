import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'Modelos.dart';
import 'dart:math' as math;

// CLASE PARA DIBUJAR NODO
class DibujaNodo extends CustomPainter{
  Map<String,dynamic> mapaNodos = {};
  DibujaNodo(this.mapaNodos);
  @override
  void paint(Canvas canvas, Size size) {
    // PINTAR RELLENO DEL NODO
    final lapizPintura = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.amber.shade400;
    // PINTAR BORDE DEL NODO
    final lapizborde = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 2;
    // METODO PARA PINTAR ETIQUETA
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
      textPainter.paint(
        canvas,
        Offset(x - (textSize.width) / 2,y-50),
      );
    }
    mapaNodos.forEach((key, value) {
      value.forEach((element) {
        if (element is ModeloNodo) {
          canvas.drawCircle(Offset(element.x, element.y), 24, lapizPintura);
          canvas.drawCircle(Offset(element.x, element.y), 25, lapizborde);
          pintarEtiqueta(canvas, element.msg, element.x, element.y);
        }
      });
    });
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


// CLASE PARA DIBUJAR ARCO
class DibujaArco extends CustomPainter{
  Map<String,dynamic> mapaNodos = {};
  DibujaArco(this.mapaNodos);

  // MÉTODO PARA CALCULO NUEVO PUNTO
  Offset? findIntersection(Offset start, Offset end, Offset center, double radius){
    // CALCULO DE PENDIENTE Y LA INTERSECCIÓN CON Y
    double dx = end.dx - start.dx;
    double dy = end.dy - start.dy;
    double m = dy / dx;
    double b = start.dy - m * start.dx;

    // REMPLAZANDO ECUACIÓN CIRCULO
    double A = 1.0 + pow(m, 2);
    double B = -2.0 * center.dx + 2.0 * m * (b - center.dy);
    double? C = (pow(center.dx, 2) + pow(b - center.dy, 2) - pow(radius, 2)) as double?;
    double discriminant = pow(B, 2) - 4 * A * C!;

    // SI EL DISCRIMINANTE ES = 0 NO EXISTEN INTERSECCIONES
    if (discriminant >= 0) {
      // CALCULANDO INTERSECCIONES
      double x1 = (-B + sqrt(discriminant)) / (2 * A);
      double y1 = m * x1 + b;
      double x2 = (-B - sqrt(discriminant)) / (2 * A);
      double y2 = m * x2 + b;
      // Check if the intersection point is within the bounds of the line segment
      Offset intersectionPoint = Offset.zero;
      if (x1 >= start.dx && x1 <= end.dx || x1 >= end.dx && x1 <= start.dx) {
        intersectionPoint = Offset(x1, y1);
      } else if (x2 >= start.dx && x2 <= end.dx || x2 >= end.dx && x2 <= start.dx) {
        intersectionPoint = Offset(x2, y2);
      }
      return intersectionPoint;
    } else {
      return null;
    }
  }
  // MÉTODO PARA PINTAR ANUNCIO
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
    final offset = Offset(x - 10, y - 10);
    textPainter.paint(canvas, offset);
  }
  //PINTAR ARCO
  final lapiz = Paint()
    ..color = Color.fromARGB(255, 38, 83, 126)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  // PINTAR FLECHAS
  final flechas = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 4
    ..color = Color.fromARGB(255, 38, 83, 126);

  @override
  void paint(Canvas canvas, Size size) {
    mapaNodos.forEach((key, value) {
      value.forEach((element) {
        if (element is ModeloArco) {
          // ARCO LOOP
          if (element.nodopartida.msg == element.nodollegada.msg){ // SI EL NODO DE PARTIDA ES IGUAL AL DE LLEGADA
            final Rect forma = Rect.fromLTWH(element.nodopartida.x+1.5,element.nodopartida.y-16,35, 35);
            final double angIni = -math.pi / 2;
            final double angFin = math.pi;

            canvas.drawArc(forma, angIni ,angFin, false, lapiz);
            double x1=((element.nodollegada.x.toDouble()+element.nodopartida.x.toDouble())/2).abs();
            double y1=((element.nodollegada.y.toDouble()+element.nodopartida.y.toDouble())/2).abs();
            aviso(x1 + 52, y1, element.distancia.toString(), canvas);

            //final p1 = Offset(element.nodopartida.x, element.nodopartida.y);
            final p2 = Offset(element.nodollegada.x.toDouble() + 8,element.nodollegada.y.toDouble() + 18);

            final angulo = angFin;// ANGULO DE FLECHA
            final sizeFlecha = 13;// TAMAÑO DE FLECHA
            final anguloFlechaFinal =  25 * math.pi / 180;

            final path = Path();

            path.moveTo(p2.dx - sizeFlecha * math.cos(angulo - anguloFlechaFinal),
                p2.dy - sizeFlecha * math.sin(angulo - anguloFlechaFinal));
            path.lineTo(p2.dx, p2.dy);
            path.lineTo(p2.dx - sizeFlecha * math.cos(angulo + anguloFlechaFinal),
                p2.dy - sizeFlecha * math.sin(angulo + anguloFlechaFinal));

            path.close();
            canvas.drawPath(path, flechas);
          }
          else {
            // OFFSET DE COORDENADAS DE INICIO Y FIN DE LA LINEA Y CIRCULO
            Offset start = Offset(element.nodopartida.x,element.nodopartida.y);
            Offset end = Offset(element.nodollegada.x,element.nodollegada.y);
            Offset center1 = Offset(element.nodopartida.x,element.nodopartida.y);
            Offset center2 = Offset(element.nodollegada.x,element.nodollegada.y);
            // CALCULO PUNTOS DE INTERSECCION CIRCULO
            Offset? intersect1 = findIntersection(start,end,center1,25);
            Offset? intersect2 = findIntersection(end,start,center2,25);
            // DIBUJAR LINEA CON COORDENADAS INTERSECCION
            canvas.drawLine(intersect1!, intersect2!, lapiz);
            // DIBUJAR ETIQUETA
            double x1=((element.nodollegada.x.toDouble() +element.nodopartida.x.toDouble())/2).abs();
            double y1=((element.nodollegada.y.toDouble()+element.nodopartida.y.toDouble())/2).abs();
            aviso(x1 -15, y1 - 15, element.distancia.toString(), canvas);
            // DIBUJAR FLECHAS
            final dX = intersect2.dx - intersect1.dx; // COORDENADAS PRIMER PUNTO
            final dY = intersect2.dy - intersect1.dy; // COORDENADAS SEGUNDO PUNTO
            final angulo = math.atan2(dY, dX);// ANGULO DE FLECHA
            final sizeFlecha = 15;// TAMAÑO DE FLECHA
            final anguloFlechaFinal =  25 * math.pi / 180;
            final anguloFlechaInicio = 50 * math.pi / 45;
            final path = Path();

            // PATH FLECHA DESTINO
            path.moveTo(intersect2.dx - sizeFlecha * math.cos(angulo - anguloFlechaFinal),
                intersect2.dy - sizeFlecha * math.sin(angulo - anguloFlechaFinal));
            path.lineTo(intersect2.dx, intersect2.dy);
            path.lineTo(intersect2.dx - sizeFlecha * math.cos(angulo + anguloFlechaFinal),
                intersect2.dy - sizeFlecha * math.sin(angulo + anguloFlechaFinal));
            if (element.flag == 2){// SI ES MODELO GRÁFICO DOBLE
              // PATH FLECHA INICIO
              path.moveTo(intersect1.dx - sizeFlecha * math.cos(angulo - anguloFlechaInicio),
                  intersect1.dy - sizeFlecha * math.sin(angulo - anguloFlechaInicio));
              path.lineTo(intersect1.dx, intersect1.dy);
              path.lineTo(intersect1.dx - sizeFlecha * math.cos(angulo + anguloFlechaInicio),
                  intersect1.dy - sizeFlecha * math.sin(angulo + anguloFlechaInicio));
            }
            path.close();
            canvas.drawPath(path, flechas);

          }
        }
      });
    });
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}