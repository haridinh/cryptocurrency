import 'package:flutter/material.dart';
import 'dart:async';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Giả lập timer tự động refresh mỗi 40 giây
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 40), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Mock API
  Future<Map<String, dynamic>> _fetchDashboardData() async {
    await Future.delayed(const Duration(seconds: 1)); // Giả lập mạng
    return {
      "trendingCoins": [
        {
          "id": "bitcoin",
          "name": "Bitcoin",
          "symbol": "BTC",
          "price": 65000,
          "change24h": 2.5,
        },
        {
          "id": "ethereum",
          "name": "Ethereum",
          "symbol": "ETH",
          "price": 3200,
          "change24h": -1.2,
        },
        {
          "id": "binancecoin",
          "name": "BNB",
          "symbol": "BNB",
          "price": 580,
          "change24h": 0.8,
        },
      ],
      "coinModel": List.generate(
        20,
        (index) => {
          "id": "coin_$index",
          "name": "Coin Name $index",
          "symbol": "SYM$index",
          "price": 100 + index * 10,
          "change24h": (index % 3 == 0) ? -2.1 : 1.5,
          "marketCap": 1000000000 + index * 10000000,
        },
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bảng điều khiển',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          actions: [
            // Nút Exchanges
            Tooltip(
              message: 'Sàn giao dịch',
              child: IconButton(
                icon: const Icon(Icons.import_export_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mở ExchangesScreen')),
                  );
                },
              ),
            ),
            // Nút Derivatives
            Tooltip(
              message: 'Phái sinh',
              child: IconButton(
                icon: const Icon(Icons.stacked_line_chart_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mở DerivativesScreen')),
                  );
                },
              ),
            ),
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _fetchDashboardData(),
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text('Lỗi: ${snapshot.error}', textAlign: TextAlign.center),
                  ],
                ),
              );
            }

            // Dữ liệu
            final data = snapshot.data ?? {};

            return RefreshIndicator(
              color: Colors.blue,
              backgroundColor: Theme.of(context).cardColor,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                setState(() {});
                await Future.delayed(const Duration(seconds: 2));
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 36),
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trending Coins
                    _buildTrendingSection(data['trendingCoins'] ?? []),

                    const SizedBox(height: 8),

                    // Market List
                    _buildMarketList(data['coinModel'] ?? []),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Trending Component
  Widget _buildTrendingSection(List<dynamic> trendingCoins) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Xu hướng',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingCoins.length,
              itemBuilder: (context, index) {
                final coin = trendingCoins[index];
                final isPositive = coin['change24h'] >= 0;
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              coin['symbol'].substring(0, 1),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            coin['symbol'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${coin['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${isPositive ? '+' : ''}${coin['change24h']}%',
                        style: TextStyle(
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Market Component
  Widget _buildMarketList(List<dynamic> coins) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: coins.length,
      itemBuilder: (context, index) {
        final coin = coins[index];
        final isPositive = coin['change24h'] >= 0;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Text(
                coin['symbol'].substring(0, 2),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              coin['name'],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('\$${coin['price']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isPositive ? '+' : ''}${coin['change24h']}%',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'MCap: \$${coin['marketCap']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
