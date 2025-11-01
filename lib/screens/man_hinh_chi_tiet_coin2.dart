// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';

class CoinDetailScreen2 extends StatefulWidget {
  final String id;
  final String name;
  final String image;

  const CoinDetailScreen2({
    super.key,
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  _CoinDetailScreen2State createState() => _CoinDetailScreen2State();
}

class _CoinDetailScreen2State extends State<CoinDetailScreen2> {
  Map<String, dynamic>? coinData;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await fetchCoinData();
    // Quảng cáo bị loại bỏ hoàn toàn (không dùng google_mobile_ads)
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> fetchCoinData() async {
    // Mock: giả lập lấy dữ liệu yêu thích
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      isFav = widget.id == 'bitcoin'; // Ví dụ: bitcoin là yêu thích
    });
  }

  @override
  void dispose() {
    // Không hiển thị quảng cáo khi thoát
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            children: [
              CircleAvatar(
                radius: 17.5,
                backgroundImage: NetworkImage(widget.image),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 12),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở Companies Screen')),
                );
              },
              icon: Image.network(
                'https://img.icons8.com/color/48/000000/company.png',
                height: 24,
                width: 24,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _getCoinDetailMock(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('Không có dữ liệu'));
            }

            final data = snapshot.data!;
            coinData ??= data;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // CoinDetailComponent (mock)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data['symbol'].toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${data['market_data']['current_price']['usd']}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            data['market_data']['price_change_percentage_24h'] >
                                                0
                                            ? Colors.green.withOpacity(0.2)
                                            : Colors.red.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${data['market_data']['price_change_percentage_24h'] > 0 ? '+' : ''}${data['market_data']['price_change_percentage_24h']}%',
                                        style: TextStyle(
                                          color:
                                              data['market_data']['price_change_percentage_24h'] >
                                                  0
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                IconButton(
                                  icon: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFav ? Colors.red : null,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      isFav = !isFav;
                                    });
                                    ScaffoldMessenger.of(
                                      context,
                                    ).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isFav
                                              ? 'Đã thêm ${data['name']} vào yêu thích'
                                              : 'Đã xóa ${data['name']} khỏi yêu thích',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // MarketChartComponent (mock)
                  Container(
                    height: 220,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Center(
                      child: Text(
                        'Biểu đồ giá (Mock)',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // KeyMetricsComponent (mock)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Chỉ số chính',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildMetric(
                              'Vốn hóa thị trường',
                              '\$${data['market_data']['market_cap']['usd']}',
                              Colors.blue,
                            ),
                            _buildMetric(
                              'Khối lượng 24h',
                              '\$${data['market_data']['total_volume']['usd']}',
                              Colors.purple,
                            ),
                            _buildMetric(
                              'Cao nhất 24h',
                              '\$${data['market_data']['high_24h']['usd']}',
                              Colors.green,
                            ),
                            _buildMetric(
                              'Thấp nhất 24h',
                              '\$${data['market_data']['low_24h']['usd']}',
                              Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // CoinDescriptionWidget (mock)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mô tả',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              data['description'] ?? 'Không có mô tả.',
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700])),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  // Mock API
  Future<Map<String, dynamic>> _getCoinDetailMock() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      "id": widget.id,
      "name": widget.name,
      "symbol": widget.id == 'bitcoin' ? 'BTC' : 'ETH',
      "market_data": {
        "current_price": {"usd": 65000},
        "market_cap": {"usd": 1200000000000},
        "total_volume": {"usd": 35000000000},
        "high_24h": {"usd": 67000},
        "low_24h": {"usd": 63000},
        "price_change_percentage_24h": 2.5,
      },
      "description":
          "${widget.name} là một loại tiền mã hóa phổ biến. Đây là mô tả mẫu để hiển thị giao diện.",
    };
  }
}
