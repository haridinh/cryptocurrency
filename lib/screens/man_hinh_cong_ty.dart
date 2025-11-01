import 'package:flutter/material.dart';

class CompaniesScreen extends StatefulWidget {
  final String? coinId; // Thêm tham số coinId

  const CompaniesScreen({super.key, this.coinId});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Công ty',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _getCompaniesListMock(),
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://via.placeholder.com/160?text=No+Data',
                      height: 160,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Không tìm thấy dữ liệu công ty',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            // No data
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://via.placeholder.com/160?text=No+Data',
                      height: 160,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Không tìm thấy dữ liệu công ty',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            final data = snapshot.data!;

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Header: Total Holdings & Entry Value
                  Positioned(
                    top: 0,
                    right: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Tổng nắm giữ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${data['total_holdings']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'Tổng giá trị đầu vào',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${data['total_value_usd']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // List Companies
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 80,
                    ), // Đẩy xuống dưới header
                    child: SingleChildScrollView(
                      child: _buildCompaniesList(data),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Mock danh sách công ty
  Widget _buildCompaniesList(Map<String, dynamic> data) {
    final List<Map<String, dynamic>> companies = [
      {
        "name": "MicroStrategy",
        "holdings": 214400,
        "value_usd": 14000000000,
        "percentage": 1.2,
      },
      {
        "name": "Tesla",
        "holdings": 43200,
        "value_usd": 2800000000,
        "percentage": 0.2,
      },
      {
        "name": "Galaxy Digital",
        "holdings": 16400,
        "value_usd": 1070000000,
        "percentage": 0.09,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      company['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${company['percentage']}%',
                      style: TextStyle(
                        color: company['percentage'] > 1
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nắm giữ: ${company['holdings']} BTC'),
                    Text('Giá trị: \$${company['value_usd']}'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Mock API
  Future<Map<String, dynamic>> _getCompaniesListMock() async {
    await Future.delayed(const Duration(seconds: 1)); // Giả lập loading
    return {
      "total_holdings": 275800,
      "total_value_usd": 18000000000,
      // Danh sách công ty sẽ được mock trong UI
    };
  }
}
