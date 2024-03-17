import 'package:expenses_mobile_app/src/shared/model/dispesa_model.dart';
import 'package:flutter/material.dart';

class DespesaListRow extends StatelessWidget {
  const DespesaListRow(
      {super.key,
      required this.despesa,
      required this.isSelected,
      this.onLongPress});

  final Dispesa? despesa;
  final bool isSelected;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepPurple.withOpacity(0.1)
              : Theme.of(context).colorScheme.background,
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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: despesa!.iconColor,
                      borderRadius: BorderRadiusDirectional.circular(100),
                    ),
                    child: Center(
                      child: Icon(despesa!.icon,
                          color: Theme.of(context).colorScheme.background),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Text(
                          despesa!.nome,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        despesa!.data.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    despesa!.valor > 0 ? Icons.add : Icons.remove,
                    color: despesa!.valor > 0 ? Colors.green : Colors.red,
                  ),
                  Text(
                    despesa!.valor
                        .toStringAsFixed(2)
                        .replaceFirstMapped("-", (match) => ""),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: despesa!.valor > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
