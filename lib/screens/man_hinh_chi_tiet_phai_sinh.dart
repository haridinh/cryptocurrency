// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// Mock model class để thay thế các model undefined
class Ticker {
  final String symbol;
  final String base;
  final String target;
  final String tradeUrl;
  final double openInterestUsd;
  final double last;
  final double h24Volume;

  Ticker({
    required this.symbol,
    required this.base,
    required this.target,
    required this.tradeUrl,
    required this.openInterestUsd,
    required this.last,
    required this.h24Volume,
  });
}

class DerivativesDetailResponse {
  final double tradeVolume24hBtc;
  final double openInterestBtc;
  final int yearEstablished;
  final String country;
  final int numberOfFuturesPairs;
  final int numberOfPerpetualPairs;
  final List<Ticker> tickers;

  DerivativesDetailResponse({
    required this.tradeVolume24hBtc,
    required this.openInterestBtc,
    required this.yearEstablished,
    required this.country,
    required this.numberOfFuturesPairs,
    required this.numberOfPerpetualPairs,
    required this.tickers,
  });
}

// Mock API call
Future<DerivativesDetailResponse> fetchDerivativesDetail() async {
  await Future.delayed(const Duration(seconds: 1));
  return DerivativesDetailResponse(
    tradeVolume24hBtc: 1234.56,
    openInterestBtc: 789.01,
    yearEstablished: 2019,
    country: 'USA',
    numberOfFuturesPairs: 20,
    numberOfPerpetualPairs: 15,
    tickers: List.generate(
      5,
      (index) => Ticker(
        symbol: 'BTC/USD',
        base: 'BTC',
        target: 'USD',
        tradeUrl: 'https://example.com',
        openInterestUsd: 123456,
        last: 67890,
        h24Volume: 54321,
      ),
    ),
  );
}

// Mock text style helpers
TextStyle boldTextStyle({double size = 16, Color color = Colors.black}) =>
    TextStyle(fontWeight: FontWeight.bold, fontSize: size, color: color);

TextStyle primaryTextStyle({double size = 14, Color color = Colors.black}) =>
    TextStyle(fontSize: size, color: color);

TextStyle secondaryTextStyle({double size = 14, Color color = Colors.grey}) =>
    TextStyle(fontSize: size, color: color);

// Mock UI widget thay cho StatsDetailWidget
class StatsDetailWidget extends StatelessWidget {
  final String title;
  final String value;

  const StatsDetailWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: primaryTextStyle()),
          Text(value, style: boldTextStyle()),
        ],
      ),
    );
  }
}

class DerivativesDetailScreen extends StatefulWidget {
  final String name;
  const DerivativesDetailScreen({super.key, this.name = "Mock Derivative"});

  @override
  State<DerivativesDetailScreen> createState() =>
      _DerivativesDetailScreenState();
}

class _DerivativesDetailScreenState extends State<DerivativesDetailScreen> {
  late Future<DerivativesDetailResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchDerivativesDetail();
  }

  @override
  Widget build(BuildContext context) {
    const themePrimaryColor = Colors.blue;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name, style: boldTextStyle(size: 22)),
        ),
        body: FutureBuilder<DerivativesDetailResponse>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No data found"));
            }

            final snap = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thông tin tổng quan
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatsDetailWidget(
                          title: '24H Volume',
                          value: snap.tradeVolume24hBtc.toString(),
                        ),
                        StatsDetailWidget(
                          title: 'Open Interest',
                          value: snap.openInterestBtc.toString(),
                        ),
                        StatsDetailWidget(
                          title: 'Year',
                          value: snap.yearEstablished.toString(),
                        ),
                        StatsDetailWidget(
                          title: 'Country',
                          value: snap.country,
                        ),
                        StatsDetailWidget(
                          title: 'Number of Futures Pairs',
                          value: snap.numberOfFuturesPairs.toString(),
                        ),
                        StatsDetailWidget(
                          title: 'Number of Perpetual Pairs',
                          value: snap.numberOfPerpetualPairs.toString(),
                        ),
                        const SizedBox(height: 16),
                        Text('Market', style: boldTextStyle(size: 20)),
                      ],
                    ),
                  ),

                  // Bảng tiêu đề
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: themePrimaryColor.withOpacity(0.2),
                        ),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: Text("Symbol", style: boldTextStyle()),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Price",
                              textAlign: TextAlign.start,
                              style: boldTextStyle(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Open Interest",
                              textAlign: TextAlign.start,
                              style: primaryTextStyle(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Expire In',
                              style: primaryTextStyle(),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Danh sách ticker
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snap.tickers.length,
                    itemBuilder: (context, index) {
                      final data = snap.tickers[index];
                      return GestureDetector(
                        onTap: () => showMoreDetail(context, data),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(4),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    data.symbol,
                                    style: boldTextStyle(size: 14),
                                  ),
                                  Text(
                                    '\$${data.last.toStringAsFixed(2)}',
                                    style: primaryTextStyle(size: 14),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '\$${data.openInterestUsd.toStringAsFixed(0)}',
                                    style: primaryTextStyle(size: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    '1 Month',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void showMoreDetail(BuildContext context, Ticker data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.name, style: boldTextStyle(size: 20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.credit_card,
                  size: 16,
                  color: Colors.white,
                ),
                label: Text(
                  '${data.base}/${data.target}',
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Trade URL: ${data.tradeUrl}')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Base Price', data.last.toStringAsFixed(2)),
              _buildDetailRow('Target Price', data.last.toStringAsFixed(2)),
              _buildDetailRow('Base Volume', data.h24Volume.toStringAsFixed(0)),
              _buildDetailRow(
                'Target Volume',
                data.h24Volume.toStringAsFixed(0),
              ),
              _buildDetailRow('24H Spread', '0.5%'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: primaryTextStyle()),
            Text(value, style: secondaryTextStyle()),
          ],
        ),
        const Divider(height: 16),
      ],
    );
  }
}
