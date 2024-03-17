import 'package:expenses_mobile_app/src/pages/Home/controller/home_controller.dart';
import 'package:expenses_mobile_app/src/pages/Home/widget/despesa_modal.dart';
import 'package:expenses_mobile_app/src/pages/Home/widget/despesa_list_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController? _controller;
  int _selectedDespesa = 0;

  _showExpensesDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return DespesaModal(
          onAdd: _controller!.addDispesa,
        );
      },
    );
  }

  _showBalanceDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Adicionar Saldo'),
              content: TextField(
                controller: _controller!.saldoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Saldo',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _controller!.addSaldo();
                    Navigator.pop(context);
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            ));
  }

  _OnDespesaLongPress(int index) {
    setState(() {
      _selectedDespesa = index;
    });

    // Show SnackBar and listen for it to close
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: const Text('Você deseja excluir esta residência?'),
            action: SnackBarAction(
              label: 'Excluir',
              onPressed: () {
                _controller?.deleteDespesa(index);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        )
        .closed
        .then((reason) {
      // Reset the selection when SnackBar closes
      setState(() {
        _selectedDespesa = -1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Meu Dinheiro',
          ),
        ),
        toolbarHeight: 40,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.show_chart),
          ),
          IconButton(
            onPressed: () {
              _showBalanceDialog();
            },
            icon: Icon(_controller!.saldo <= 0 ? Icons.add : Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).colorScheme.onPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? const Color.fromARGB(28, 0, 0, 0)
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                      offset: const Offset(0, 5),
                      blurRadius: 7,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saldo',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'R\$ ${_controller?.saldo.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Despesas',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'R\$ ${_controller?.despesas.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _controller!.despesas < 0
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Suas Despesas:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _showExpensesDialog();
                      // _controller.addDispesa();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Adicionar"),
                  ),
                ],
              ),
            ),

            /*List View com as despesas*/
            Expanded(
              // Adicionado para permitir que a ListView ocupe o espaço restante
              child: ListView.builder(
                itemCount: _controller?.dispesaLista.length ?? 0,
                itemBuilder: (context, index) {
                  final despesa = _controller?.dispesaLista[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DespesaListRow(
                      despesa: despesa,
                      onLongPress: () => _OnDespesaLongPress(index),
                      isSelected: index == _selectedDespesa,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
