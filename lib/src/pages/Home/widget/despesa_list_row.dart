import 'package:expenses_mobile_app/src/shared/model/dispesa_model.dart';
import 'package:flutter/material.dart';

class DespesaListRow extends StatelessWidget {
  const DespesaListRow({super.key, required this.dispesa});

  final Dispesa? dispesa;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16), // Mais espaço interno
      child: Row(
        children: [
          Icon(
            dispesa!.icon,
            color: Theme.of(context).colorScheme.primary,
            size: 30, // Ícone um pouco maior
          ),
          const SizedBox(width: 16), // Espaçamento entre ícone e texto
          Expanded(
            child: Text(
              dispesa!.nome,
              style: const TextStyle(
                fontSize:
                    18, // Tamanho um pouco reduzido para equilibrar o layout
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'R\$ ${dispesa!.valor.toStringAsFixed(2)}', // Formatação para duas casas decimais
            style: TextStyle(
              fontSize: 18, // Tamanho um pouco reduzido
              fontWeight: FontWeight.bold,
              color: dispesa!.valor < 0
                  ? Colors.red
                  : Colors.green, // Cores para indicar receita ou despesa
            ),
          ),
        ],
      ),
    );
  }
}
