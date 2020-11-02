import 'package:flutter/scheduler.dart';

class Restriccion {
  int id;
  int id_causante;
  int id_restriccion;
  String causante;
  String restriccion;
  String tipo;
  String por;
  String de;

  Restriccion({this.id, this.id_causante, this.id_restriccion, this.causante, this.restriccion, this.tipo, this.por, this.de});

  factory Restriccion.fromJson(Map<String, dynamic> json) {
    return Restriccion(
      id: json['id'],
      id_causante: json['id_causante'],
      id_restriccion: json['id_restriccion'],
      causante: json['causante'],
      restriccion: json['restriccion'],
      tipo: json['tipo'],
      por: json['por'],
      de: json['de']
    );
  }
}