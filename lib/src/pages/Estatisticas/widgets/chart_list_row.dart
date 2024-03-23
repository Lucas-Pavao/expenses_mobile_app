import 'package:expenses_mobile_app/src/shared/model/extrato_model.dart';
import 'package:flutter/material.dart';

class ChartListRow extends StatelessWidget {
  const ChartListRow({super.key, required this.extrato});

  final Extrato extrato;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Colors.black12
                      : Colors.white12,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(extrato.icon, color: extrato.iconColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(extrato.nome,
                    style: Theme.of(context).textTheme.bodySmall),
                Text(
                  'R\$ ${extrato.valor.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: extrato.valor < 0 ? Colors.red : Colors.green),
                ),
              ],
            ),
          ],
        ));
  }
}
