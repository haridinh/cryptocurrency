import 'package:flutter/material.dart';

class CoinDetailScreen extends StatefulWidget {
  final String? name;
  final String? id;

  const CoinDetailScreen({super.key, this.name, this.id});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  Map<String, dynamic>? coinData;

  // Mock data để hiển thị (thay cho API)
  Future<Map<String, dynamic>> getCoinDetail({String? name}) async {
    await Future.delayed(const Duration(seconds: 1)); // Giả lập loading
    return {
      "id": widget.id ?? "bitcoin",
      "name": widget.name ?? "Bitcoin",
      "symbol": "BTC",
      "image": {"large": "https://example.com/btc.png"},
      "market_data": {
        "current_price": {"usd": 65000},
        "market_cap": {"usd": 1200000000000},
        "price_change_percentage_24h": 2.5,
      },
      "tickers": ["binance", "coinbase"],
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name ?? 'Coin Detail',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Mock navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở Exchange Screen')),
                );
              },
              icon: const Icon(Icons.import_export_outlined, size: 24),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở Detail Component')),
                );
              },
              icon: const Icon(Icons.info_outline, size: 24),
            ),
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
          future: getCoinDetail(name: widget.id),
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

            return RefreshIndicator(
              color: Colors.blue,
              backgroundColor: Theme.of(context).cardColor,
              onRefresh: () async {
                setState(() {});
                await Future.delayed(const Duration(seconds: 2));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // CoinDetailComponent -> Thay bằng mock
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  data['image']['large'] ??
                                      'https://via.placeholder.com/60',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data['symbol'].toUpperCase(),
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // MarketTypeBasedOnDateComponent -> Thay bằng mock favorite button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Text(
                            'Yêu thích: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(
                              coinData?['isFavorite'] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: coinData?['isFavorite'] == true
                                  ? Colors.red
                                  : null,
                            ),
                            onPressed: () {
                              setState(() {
                                coinData?['isFavorite'] =
                                    !(coinData?['isFavorite'] ?? false);
                              });
                              ScaffoldMessenger.of(
                                context,
                              ).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    coinData?['isFavorite'] == true
                                        ? 'Đã thêm ${data['name']} vào yêu thích'
                                        : 'Đã xóa ${data['name']} khỏi yêu thích',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // MarketChartComponent -> Mock chart placeholder
                    Container(
                      height: 200,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Biểu đồ giá (Mock)',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),

                    // KeyMetricsComponent -> Mock metrics
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
                              const SizedBox(height: 8),
                              _buildMetricRow(
                                'Giá hiện tại',
                                '\$${data['market_data']['current_price']['usd']}',
                                Colors.green,
                              ),
                              _buildMetricRow(
                                'Vốn hóa',
                                '\$${data['market_data']['market_cap']['usd']}',
                                Colors.blue,
                              ),
                              _buildMetricRow(
                                'Thay đổi 24h',
                                '${data['market_data']['price_change_percentage_24h']}%',
                                data['market_data']['price_change_percentage_24h'] >
                                        0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
          ),
        ],
      ),
    );
  }
}
