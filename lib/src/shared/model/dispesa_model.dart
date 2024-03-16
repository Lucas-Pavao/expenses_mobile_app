import 'package:flutter/material.dart';

class Dispesa {
  final IconData icon;
  final Color iconColor;
  final String nome;
  final double valor;
  final String data;

  Dispesa({
    required this.icon,
    required this.iconColor,
    required this.nome,
    required this.valor,
    required this.data,
  });
}
