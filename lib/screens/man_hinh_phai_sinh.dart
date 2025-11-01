import 'package:flutter/material.dart';

class DerivativesScreen extends StatefulWidget {
  const DerivativesScreen({super.key});

  @override
  State<DerivativesScreen> createState() => _DerivativesScreenState();
}

class _DerivativesScreenState extends State<DerivativesScreen> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = true;

  // Mock danh sách phái sinh
  final List<Map<String, dynamic>> mainList = List.generate(
    10,
    (index) => {
      'exchange': 'Binance',
      'pair': 'BTC/USDT',
      'volume_24h': 1250000000 + index * 100000000,
      'open_interest': 450000000 + index * 50000000,
      'funding_rate': (index % 3 == 0) ? -0.012 : 0.008,
      'index_price': 65000 + index * 100,
      'mark_price': 65010 + index * 95,
    },
  );

  @override
  void initState() {
    super.initState();
    // Giả lập loading
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Phái sinh',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 60),
                controller: scrollController,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mainList.length,
                      padding: const EdgeInsets.only(top: 8),
                      itemBuilder: (context, index) {
                        final data = mainList[index];
                        return _buildDerivativesItem(data);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // Widget hiển thị từng mục phái sinh
  Widget _buildDerivativesItem(Map<String, dynamic> data) {
    final bool isNegative = data['funding_rate'] < 0;
    final String fundingRateStr =
        '${isNegative ? '' : '+'}${data['funding_rate'].toStringAsFixed(4)}%';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Exchange + Pair
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        data['exchange'].substring(0, 1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data['exchange'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  data['pair'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Dòng 1: Volume 24h + Open Interest
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn(
                  'Khối lượng 24h',
                  '\$${(data['volume_24h'] / 1000000).toStringAsFixed(1)}M',
                ),
                _buildInfoColumn(
                  'Lãi mở',
                  '\$${(data['open_interest'] / 1000000).toStringAsFixed(1)}M',
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Dòng 2: Funding Rate + Index Price + Mark Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn(
                  'Funding Rate',
                  fundingRateStr,
                  valueColor: isNegative ? Colors.red : Colors.green,
                ),
                _buildInfoColumn('Giá chỉ số', '\$${data['index_price']}'),
                _buildInfoColumn('Giá đánh dấu', '\$${data['mark_price']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
