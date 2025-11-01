// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CoinAllListScreen extends StatefulWidget {
  final String? categoryName;
  const CoinAllListScreen({super.key, this.categoryName});

  @override
  State<CoinAllListScreen> createState() => _CoinAllListScreenState();
}

class _CoinAllListScreenState extends State<CoinAllListScreen> {
  // Scroll controller
  final ScrollController scrollController = ScrollController();

  // Mock data
  final List<CoinModel> mainList = List.generate(
    20,
    (index) => CoinModel(
      name: 'Coin ${index + 1}',
      symbol: 'C${index + 1}',
      price: 1000.0 + index * 100,
      change24h: (index % 3 == 0) ? -5.2 : 3.8,
    ),
  );

  // FAB visibility
  bool fabIsVisible = true;
  bool isEnabled = false; // Thay cho logic thực tế

  // Loading
  bool isLoading = false;

  // Sort & Interval
  String selectedSortType = 'Name A-Z';
  String selectedIntervalType = '24h';

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        fabIsVisible = scrollController.offset > 300;
      });
    });
  }

  void animateToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
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
        floatingActionButton: AnimatedOpacity(
          opacity: isEnabled ? 0.0 : 1.0,
          duration: const Duration(seconds: 1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: fabIsVisible ? 1.0 : 0.0,
            child: FloatingActionButton(
              onPressed: animateToTop,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.vertical_align_top, color: Colors.white),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            widget.categoryName ?? 'Crypto Coins',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: [
            sortingWidget(),
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 60, right: 16, left: 16),
              itemCount: mainList.length,
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CryptoDashboardWidget(coin: mainList[index]);
              },
            ).paddingTop(46),
            // Loader
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
          ],
        ),
      ),
    );
  }

  Widget sortingWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: Row(
        children: [
          // Sort Button
          GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: Theme.of(context).cardColor,
                builder: (context) => const CoinSortingTypeComponent(),
              );

              if (!mounted) return;

              if (result == true) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                setState(() {
                  isLoading = true;
                  Future.delayed(const Duration(seconds: 1), () {
                    if (mounted) {
                      setState(() => isLoading = false);
                    }
                  });
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedSortType,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_downward_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Interval Button
          GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet<bool>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: Theme.of(context).cardColor,
                builder: (context) => const CoinIntervalComponent(),
              );

              if (!mounted) return;

              if (result == true) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                setState(() {
                  isLoading = true;
                  Future.delayed(const Duration(seconds: 1), () {
                    if (mounted) {
                      setState(() => isLoading = false);
                    }
                  });
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedIntervalType,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_downward_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Mock Model
class CoinModel {
  final String name;
  final String symbol;
  final double price;
  final double change24h;

  CoinModel({
    required this.name,
    required this.symbol,
    required this.price,
    required this.change24h,
  });
}

// Thay thế CryptoDashboardWidget
class CryptoDashboardWidget extends StatelessWidget {
  final CoinModel coin;

  const CryptoDashboardWidget({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Text(
              coin.symbol,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  coin.symbol,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${coin.price.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${coin.change24h > 0 ? '+' : ''}${coin.change24h.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: coin.change24h > 0 ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Bottom Sheet: Sort
class CoinSortingTypeComponent extends StatelessWidget {
  const CoinSortingTypeComponent({super.key});

  final List<String> options = const [
    'Name A-Z',
    'Name Z-A',
    'Price High-Low',
    'Price Low-High',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text(
            'Sort By',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ).paddingBottom(16),
          ...options.map(
            (opt) => ListTile(
              title: Text(opt),
              onTap: () => Navigator.pop(context, true),
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom Sheet: Interval
class CoinIntervalComponent extends StatelessWidget {
  const CoinIntervalComponent({super.key});

  final List<String> intervals = const ['1h', '24h', '7d', '30d'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text(
            'Time Interval',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ).paddingBottom(16),
          ...intervals.map(
            (intv) => ListTile(
              title: Text(intv),
              onTap: () => Navigator.pop(context, true),
            ),
          ),
        ],
      ),
    );
  }
}

// Extension cho paddingTop, paddingBottom
extension WidgetPadding on Widget {
  Widget paddingTop(double top) => Padding(
    padding: EdgeInsets.only(top: top),
    child: this,
  );
  Widget paddingBottom(double bottom) => Padding(
    padding: EdgeInsets.only(bottom: bottom),
    child: this,
  );
}
