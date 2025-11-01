// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// Thay thế import 'package:nb_utils/nb_utils.dart'; bằng các mock và widget mặc định.

// --- MOCK DATA và Utility Classes ĐỂ THAY THẾ CHO CÁC PHẦN UNDEFINED ---

// Mock cho dữ liệu Coin/Crypto
class MockCoinData {
  final String name;
  final String symbol;

  MockCoinData({required this.name, required this.symbol});
}

// Mock cho AppStore và Colors
class MockAppStore {
  final bool isDarkMode = true; // Giả định chế độ tối
}

final MockAppStore mockAppStore = MockAppStore();
const Color mockCardColor = Color(0xFF353535); // Màu giả định cho dark mode

// Mock cho AppCommon
class MockAppCommon {
  // Thay thế AppCommon.inputDecoration
  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    );
  }
}

// Hàm mock để thay thế .translate
String mockTranslate(String key) {
  switch (key) {
    case 'lbl_add_favourite_coin':
      return 'Thêm Coin Yêu Thích';
    case 'lbl_search':
      return 'Tìm kiếm...';
    default:
      return key;
  }
}

// Thay thế các extension methods của nb_utils:
// 1. AppScaffold -> Scaffold
// 2. boldTextStyle(size: 22) -> TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
// 3. AppTextField -> TextField
// 4. .paddingSymmetric(horizontal: 16) -> Padding
// 5. .expand() -> Expanded

// --- WIDGET THAY THẾ CÁC THÀNH PHẦN UNDEFINED ---

// Thay thế CryptoAddWidget bằng một widget placeholder đơn giản
class MockCryptoAddWidget extends StatelessWidget {
  final MockCoinData coin;
  final int index;
  final VoidCallback onSuccess;

  const MockCryptoAddWidget({
    super.key,
    required this.coin,
    required this.index,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(index.toString())),
      title: Text(coin.name),
      subtitle: Text(coin.symbol, style: const TextStyle(color: Colors.grey)),
      trailing: IconButton(
        icon: const Icon(Icons.add_circle, color: Colors.green),
        onPressed: onSuccess,
      ),
    );
  }
}

// --- BỐ CỤC CHÍNH CỦA WIDGET ---

class AddCoinToPortfolio extends StatefulWidget {
  const AddCoinToPortfolio({super.key});

  @override
  State<AddCoinToPortfolio> createState() => _AddCoinToPortfolioState();
}

class _AddCoinToPortfolioState extends State<AddCoinToPortfolio> {
  // Thay thế các biến bị undefined bằng các Controller và List mock
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<MockCoinData> mainList = [
    MockCoinData(name: 'Bitcoin', symbol: 'BTC'),
    MockCoinData(name: 'Ethereum', symbol: 'ETH'),
    MockCoinData(name: 'Ripple', symbol: 'XRP'),
    MockCoinData(name: 'Cardano', symbol: 'ADA'),
    MockCoinData(name: 'Solana', symbol: 'SOL'),
  ];

  @override
  void initState() {
    super.initState();
    // Khởi tạo logic tìm kiếm và fetch data mock
    controller.addListener(() {
      fetchCategoryData();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  // Thay thế hàm fetchCategoryData()
  void fetchCategoryData() {
    debugPrint('Đang tìm kiếm với từ khóa: ${controller.text}');
    setState(() {
      // Logic lọc dữ liệu mock (ví dụ: tìm kiếm theo tên hoặc symbol)
      String query = controller.text.toLowerCase();
      mainList =
          [
            MockCoinData(name: 'Bitcoin', symbol: 'BTC'),
            MockCoinData(name: 'Ethereum', symbol: 'ETH'),
            MockCoinData(name: 'Ripple', symbol: 'XRP'),
            MockCoinData(name: 'Cardano', symbol: 'ADA'),
            MockCoinData(name: 'Solana', symbol: 'SOL'),
          ].where((coin) {
            return coin.name.toLowerCase().contains(query) ||
                coin.symbol.toLowerCase().contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Thay thế AppScaffold bằng Scaffold mặc định
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            // Thay thế "lbl_add_favourite_coin".translate
            mockTranslate("lbl_add_favourite_coin"),
            // Thay thế style: boldTextStyle(size: 22)
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        body: Column(
          children: [
            // Thay thế AppTextField bằng TextField
            Padding(
              // Thay thế .paddingSymmetric(horizontal: 16)
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller, // Thay thế controller
                // Thay thế textFieldType: TextFieldType.OTHER
                keyboardType: TextInputType.text,
                decoration:
                    MockAppCommon.inputDecoration(
                      // Thay thế 'lbl_search'.translate
                      mockTranslate('lbl_search'),
                    ).copyWith(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ), // Giả định màu icon
                    ),
                onChanged: (s) {
                  // Thay thế fetchCategoryData()
                  fetchCategoryData();
                },
              ),
            ),

            // Thay thế .expand() bằng Expanded
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                // Giữ nguyên physics: ClampingScrollPhysics()
                physics: const ClampingScrollPhysics(),
                controller: scrollController, // Thay thế scrollController
                itemCount: mainList.length, // Thay thế mainList.length
                itemBuilder: (context, index) {
                  // Thay thế CryptoAddWidget
                  return MockCryptoAddWidget(
                    coin: mainList[index], // Thay thế mainList[index]
                    index: index + 1,
                    onSuccess: () {
                      setState(() {});
                      debugPrint('Đã thêm ${mainList[index].name}');
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  // Thay thế appStore.isDarkMode và cardColor
                  return Divider(
                    height: 0,
                    thickness: 0.8,
                    indent: 60,
                    color: mockAppStore.isDarkMode
                        ? mockCardColor // cardColor mock
                        // Thay thế Colors.grey.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.2),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
