import 'package:expenses_mobile_app/src/pages/Home/controller/home_controller.dart';
import 'package:expenses_mobile_app/src/pages/Home/widget/extrato_list_row.dart';
import 'package:expenses_mobile_app/src/pages/Home/widget/extrato_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController? _controller;
  int _selectedExtrato = -1;

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
        return ExtratoModal(
          onAdd: _controller!.addExtrato,
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

  _showFinalizarMesDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Finalizar Mês'),
              content: const Text(
                  ''' Isso irá zerar o saldo disponível, saldo Inicial e o extrato!.'''),
              icon: Icon(
                Icons.warning_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _controller!.finalizarMes();
                    Navigator.popAndPushNamed(context, '/home');
                  },
                  child: const Text('Finalizar'),
                ),
              ],
            ));
  }

  _onExtratoLongPress(int index) {
    setState(() {
      _selectedExtrato = index;
    });

    // Show SnackBar and listen for it to close
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: const Text('Você deseja excluir esta residência?'),
            action: SnackBarAction(
              label: 'Excluir',
              onPressed: () {
                _controller?.deleteExtrato(index);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        )
        .closed
        .then((reason) {
      // Reset the selection when SnackBar closes
      setState(() {
        _selectedExtrato = -1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = context.read<HomeController>();
    _controller!.loadExtratos();
  }

  @override
  Widget build(BuildContext context) {
    _controller = context.watch<HomeController>();

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Estatisticas',
                  style: Theme.of(context).textTheme.bodyLarge),
              leading: Icon(
                Icons.show_chart,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/estatisticas', arguments: {
                  'saldoInicial': _controller!.saldoInicial,
                  'saldoDisponivel': _controller!.saldoDisponivel,
                  'extratoLista': _controller!.extratoLista,
                });
              },
            ),
            ListTile(
              title: Text('Gerar Relatório',
                  style: Theme.of(context).textTheme.bodyLarge),
              leading: Icon(
                Icons.table_chart_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Finalizar Mês',
                  style: Theme.of(context).textTheme.bodyLarge),
              leading: Icon(
                Icons.calendar_today_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                _showFinalizarMesDialog();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Meu Dinheiro',
          ),
        ),
        toolbarHeight: 40,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.show_chart),
          // ),
          IconButton(
            onPressed: () {
              _showBalanceDialog();
            },
            icon: Icon(_controller!.saldoInicial <= 0 ? Icons.add : Icons.edit),
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
                          'Saldo Inicial',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'R\$ ${_controller?.saldoInicial.toStringAsFixed(2)}',
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
                          'Saldo Disponível',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'R\$ ${_controller?.saldoDisponivel.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _controller!.saldoDisponivel < 0
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
                    'Seu Extrato:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _showExpensesDialog();
                      // _controller.addExtrato();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Adicionar"),
                  ),
                ],
              ),
            ),

            /*List View com as Extratos*/
            Expanded(
              // Adicionado para permitir que a ListView ocupe o espaço restante
              child: ListView.builder(
                itemCount: _controller?.extratoLista.length ?? 0,
                itemBuilder: (context, index) {
                  final extrato = _controller?.extratoLista[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExtratoListRow(
                      extrato: extrato,
                      onLongPress: () => _onExtratoLongPress(index),
                      isSelected: index == _selectedExtrato,
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
