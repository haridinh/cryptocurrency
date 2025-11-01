// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ExchangeScreen extends StatefulWidget {
  final List<Map<String, dynamic>> ticker;

  const ExchangeScreen({super.key, required this.ticker});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  String selectedValue = '1';
  Map<String, dynamic>? selectedTypeValue;

  final List<Map<String, dynamic>> sortOptions = [
    {'id': '1', 'name': 'Giá'},
    {'id': '2', 'name': 'Khối lượng'},
    {'id': '3', 'name': 'Độ tin cậy'},
  ];

  @override
  void initState() {
    super.initState();
    selectedTypeValue = sortOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sàn giao dịch',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  Row(
                    children: List.generate(sortOptions.length, (index) {
                      final data = sortOptions[index];
                      return Expanded(
                        child: RadioListTile<String>(
                          value: data['id'],
                          groupValue: selectedValue,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                              selectedTypeValue = data;
                            });
                          },
                          title: Text(
                            data['name'],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Table(
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        children: [
                          _headerCell('Sàn'),
                          _headerCell('Cặp'),
                          _headerCell('Giá'),
                          _headerCell('KL 24h'),
                        ],
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.ticker.length,
                    itemBuilder: (context, index) {
                      final data = widget.ticker[index];
                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Chi tiết: ${data['market']}'),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['market'] ?? 'N/A',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 4),
                                    LinearProgressIndicator(
                                      value: (data['trust_score'] ?? 5) / 10,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _getTrustColor(
                                          data['trust_score'] ?? 5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${data['base'] ?? 'N/A'}\n${data['target'] ?? 'N/A'}',
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '\$${data['price'] ?? 0}',
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '\$${(data['volume'] ?? 0).toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color _getTrustColor(int score) {
    if (score >= 8) return Colors.green;
    if (score >= 5) return Colors.orange;
    return Colors.red;
  }
}
