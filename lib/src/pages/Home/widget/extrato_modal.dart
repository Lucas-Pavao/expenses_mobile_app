import 'package:expenses_mobile_app/src/shared/model/extrato_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExtratoModal extends StatefulWidget {
  const ExtratoModal({super.key, required this.onAdd});
  final Function? onAdd;

  @override
  State<ExtratoModal> createState() => _ExtratoModalState();
}

class _ExtratoModalState extends State<ExtratoModal> {
  DateTime _selectedDate = DateTime.now();
  bool isAdding = true;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  final List<IconData> _iconList = [
    Icons.shopping_cart,
    Icons.fastfood,
    Icons.home,
    Icons.local_gas_station,
    Icons.local_hospital,
    Icons.school,
    Icons.card_giftcard,
    Icons.airplanemode_active,
    Icons.phone_android,
    Icons.sports_soccer,
  ];

  final List<Color> _colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
    Colors.brown,
  ];

  IconData icon = Icons.shopping_cart;
  Color color = Colors.red;

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.41,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Adicionar Valor',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              DropdownButton(
                                value: icon,
                                items: _iconList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Icon(e),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    icon = value!;
                                  });
                                  icon = value!;
                                },
                              ),
                              const SizedBox(width: 16),
                              DropdownButton(
                                value: color,
                                items: _colorList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Icon(Icons.circle, color: e),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    color = value!;
                                  });
                                  color = value!;
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  final DateTime? pickedDate = await _selectDate(
                                      context); // Chame a função separada para abrir o DatePicker
                                  if (pickedDate != null &&
                                      pickedDate != _selectedDate) {
                                    setState(() {
                                      _selectedDate = pickedDate;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.calendar_month),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: dateFormat.format(_selectedDate),
                                  ),
                                  decoration: const InputDecoration(
                                    // labelText: 'Data',
                                    enabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isAdding = !isAdding;
                                });
                              },
                              icon: Icon(isAdding ? Icons.add : Icons.remove,
                                  color: isAdding ? Colors.green : Colors.red)),
                          Expanded(
                            child: TextField(
                              controller: _valorController,
                              decoration: const InputDecoration(
                                labelText: 'Valor',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_valorController.text.isEmpty &&
                              _nomeController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Preencha os campos'),
                              ),
                            );
                          } else {
                            String valorText =
                                _valorController.text.replaceAll(',', '.');

                            double valor = double.tryParse(valorText) ?? 0.0;

                            if (!isAdding) {
                              valor *= -1;
                            }

                            Extrato extrato = Extrato(
                              nome: _nomeController.text,
                              data: dateFormat.format(_selectedDate),
                              valor: valor,
                              icon: icon,
                              iconColor: color,
                              diaSemana:
                                  DateFormat('EEEE').format(_selectedDate),
                            );
                            widget.onAdd!(extrato);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Adicionar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
