import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DespesaModal extends StatefulWidget {
  const DespesaModal({super.key});

  @override
  State<DespesaModal> createState() => _DespesaModalState();
}

class _DespesaModalState extends State<DespesaModal> {
  DateTime _selectedDate = DateTime.now();
  bool isAdding = true;

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
    IconData icon = _iconList[0];
    Color color = _colorList[0];
    final dateFormat = DateFormat('dd/MM/yyyy');
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Adicionar Despesa',
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
              const TextField(
                decoration: InputDecoration(
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
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Valor',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
