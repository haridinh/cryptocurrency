// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CurrencySelectionScreen extends StatefulWidget {
  const CurrencySelectionScreen({super.key});

  @override
  State<CurrencySelectionScreen> createState() =>
      _CurrencySelectionScreenState();
}

class _CurrencySelectionScreenState extends State<CurrencySelectionScreen> {
  String searchString = '';
  int selectedIndex = 0;

  // Mock danh sách tiền tệ
  Future<List<Map<String, dynamic>>> getCurrencies() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {"name": "United States Dollar", "symbol": "\$", "cc": "usd"},
      {"name": "Euro", "symbol": "€", "cc": "eur"},
      {"name": "British Pound", "symbol": "£", "cc": "gbp"},
      {"name": "Japanese Yen", "symbol": "¥", "cc": "jpy"},
      {"name": "Canadian Dollar", "symbol": "C\$", "cc": "cad"},
      {"name": "Australian Dollar", "symbol": "A\$", "cc": "aud"},
      {"name": "Swiss Franc", "symbol": "CHF", "cc": "chf"},
      {"name": "Chinese Yuan", "symbol": "¥", "cc": "cny"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Tiền tệ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: getCurrencies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Lỗi tải dữ liệu'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Không có dữ liệu'));
            }

            final currencies = snapshot.data!;

            return Stack(
              children: [
                // Search Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                  ),
                ),

                // ListView
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: ListView.builder(
                    itemCount: currencies.length,
                    itemBuilder: (context, index) {
                      final data = currencies[index];
                      final name = data['name'].toString().toLowerCase();
                      final isVisible = name.contains(searchString);

                      if (!isVisible) return const SizedBox.shrink();

                      final isSelected = index == selectedIndex;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          // Mock lưu vào SharedPreferences
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Đã chọn: ${data['name']}')),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.withOpacity(0.2)
                                : null,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              // Leading: Symbol
                              Container(
                                width: 60,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  data['symbol'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Title & Subtitle
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      data['cc'].toString().toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Trailing: Check icon
                              if (isSelected)
                                const Icon(Icons.check, color: Colors.blue),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Banner Ad (mock - ẩn hoàn toàn)
                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: Container(
                //     height: 50,
                //     color: Colors.grey[300],
                //     child: const Center(child: Text('Quảng cáo (Mock)')),
                //   ),
                // ).visible(false),
              ],
            );
          },
        ),
      ),
    );
  }
}
