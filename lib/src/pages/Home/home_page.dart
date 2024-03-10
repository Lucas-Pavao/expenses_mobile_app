import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                      color: const Color(0x00000000).withOpacity(1),
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
                      children: [
                        Text(
                          'Saldo',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'R\$ 1000,00',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Despesas',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'R\$ 1000,00',
                          style: Theme.of(context).textTheme.bodyLarge,
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
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("Adicionar"),
                  ),
                ],
              ),
            )
            /*List View com as despesas*/
          ],
        ),
      ),
    );
  }
}
