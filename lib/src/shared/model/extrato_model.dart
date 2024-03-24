import 'dart:convert';

import 'package:flutter/material.dart';

class Extrato {
  final IconData icon;
  final Color iconColor;
  final String nome;
  final double valor;
  final String data;
  final String diaSemana;

  Extrato({
    required this.icon,
    required this.iconColor,
    required this.nome,
    required this.valor,
    required this.data,
    required this.diaSemana,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon.codePoint,
      'iconColor': iconColor.value,
      'nome': nome,
      'valor': valor,
      'data': data,
      'diaSemana': diaSemana,
    };
  }

  factory Extrato.fromMap(Map<String, dynamic> map) {
    return Extrato(
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      iconColor: Color(map['iconColor'] as int),
      nome: map['nome'] as String,
      valor: map['valor'] as double,
      data: map['data'] as String,
      diaSemana: map['diaSemana'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Extrato.fromJson(String source) =>
      Extrato.fromMap(json.decode(source) as Map<String, dynamic>);
}
