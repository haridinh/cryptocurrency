// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// Loại bỏ import 'package:nb_utils/nb_utils.dart' và thay thế bằng mock/native code.

// --- MOCK DATA và Utility Classes ĐỂ THAY THẾ CHO CÁC PHẦN UNDEFINED ---

// Mock cho dữ liệu Coin/Crypto
class MockCoinData {
  final String name;
  final String symbol;
  final bool isFollowed;

  MockCoinData({
    required this.name,
    required this.symbol,
    this.isFollowed = false,
  });
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
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    );
  }
}

// Hàm mock để thay thế .translate
String mockTranslate(String key) {
  switch (key) {
    case 'lbl_add_coins_to_favourites':
      return 'Thêm Coins vào Mục Yêu Thích';
    case 'lbl_search':
      return 'Tìm kiếm Coin...';
    default:
      return key;
  }
}

// Hàm mock để thay thế boldTextStyle(size: 22)
TextStyle mockBoldTextStyle({double size = 14}) =>
    TextStyle(fontWeight: FontWeight.bold, fontSize: size);

// --- WIDGET THAY THẾ CryptoFollowWidget ---

// Thay thế CryptoFollowWidget bằng một widget placeholder đơn giản
class MockCryptoFollowWidget extends StatefulWidget {
  final MockCoinData coin;
  final int index;
  final VoidCallback onSuccess;

  const MockCryptoFollowWidget({
    super.key,
    required this.coin,
    required this.index,
    required this.onSuccess,
  });

  @override
  State<MockCryptoFollowWidget> createState() => _MockCryptoFollowWidgetState();
}

class _MockCryptoFollowWidgetState extends State<MockCryptoFollowWidget> {
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.coin.isFollowed;
  }

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
    widget.onSuccess();
    debugPrint(
      '${widget.coin.name} đã được ${isFollowing ? 'thêm' : 'bỏ'} khỏi mục yêu thích.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Text(
          widget.coin.symbol.substring(0, 1),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(widget.coin.name),
      subtitle: Text(
        widget.coin.symbol,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(
          isFollowing ? Icons.favorite : Icons.favorite_border,
          color: isFollowing ? Colors.red : Colors.grey,
        ),
        onPressed: _toggleFollow,
      ),
    );
  }
}

// --- BỐ CỤC CHÍNH CỦA WIDGET ---

class AddCryptoScreen extends StatefulWidget {
  const AddCryptoScreen({super.key});

  @override
  State<AddCryptoScreen> createState() => _AddCryptoScreenState();
}

class _AddCryptoScreenState extends State<AddCryptoScreen> {
  // Thay thế các biến bị undefined bằng các Controller và List mock
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<MockCoinData> allCoins = [
    MockCoinData(name: 'Bitcoin', symbol: 'BTC', isFollowed: true),
    MockCoinData(name: 'Ethereum', symbol: 'ETH'),
    MockCoinData(name: 'Tether', symbol: 'USDT'),
    MockCoinData(name: 'BNB', symbol: 'BNB'),
    MockCoinData(name: 'Solana', symbol: 'SOL'),
  ];
  List<MockCoinData> mainList = [];

  @override
  void initState() {
    super.initState();
    mainList = List.from(allCoins);
    // Gắn listener để gọi fetchCategoryData khi nhập liệu
    controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    fetchCategoryData();
  }

  // Thay thế hàm fetchCategoryData()
  void fetchCategoryData() {
    String query = controller.text.toLowerCase();
    setState(() {
      // Logic lọc dữ liệu mock:
      mainList = allCoins.where((coin) {
        return coin.name.toLowerCase().contains(query) ||
            coin.symbol.toLowerCase().contains(query);
      }).toList();
    });
    debugPrint('Đã lọc ${mainList.length} coins với từ khóa: $query');
  }

  @override
  Widget build(BuildContext context) {
    // Giá trị padding top cho ListView để tránh bị TextField che khuất
    const double topPaddingForListView = 60.0 + 16.0;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            // Thay thế 'lbl_add_coins_to_favourites'.translate
            mockTranslate('lbl_add_coins_to_favourites'),
            // Thay thế style: boldTextStyle(size: 22)
            style: mockBoldTextStyle(size: 22),
          ),
        ),
        // Giữ nguyên Container gốc
        body: Stack(
          children: [
            // 1. TextField (Thay thế AppTextField)
            Padding(
              // Thay thế .paddingSymmetric(horizontal: 16)
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller, // Thay thế controller
                keyboardType:
                    TextInputType.text, // Thay thế TextFieldType.OTHER
                decoration:
                    MockAppCommon.inputDecoration(
                      // Thay thế 'lbl_search'.translate
                      mockTranslate('lbl_search'),
                    ).copyWith(
                      // Giữ nguyên suffixIcon: Icon(Icons.search, color: Colors.white)
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ), // Thay màu trắng mặc định bằng màu có thể thấy
                    ),
                onChanged: (s) {
                  // Thay thế fetchCategoryData();
                  fetchCategoryData();
                },
              ),
            ),

            // 2. ListView (Danh sách kết quả)
            // Bắt buộc phải có padding phía trên để tránh bị TextField che khuất
            ListView.separated(
              shrinkWrap: true,
              // Giữ nguyên padding: EdgeInsets.zero (chỉ padding theo chiều dọc)
              padding: const EdgeInsets.only(top: topPaddingForListView),
              controller: scrollController, // Thay thế scrollController
              itemCount: mainList.length, // Thay thế mainList.length
              itemBuilder: (context, index) {
                // Thay thế CryptoFollowWidget
                return MockCryptoFollowWidget(
                  coin: mainList[index], // Thay thế mainList[index]
                  index: index + 1,
                  onSuccess: () {
                    // Cập nhật trạng thái sau khi thêm/bỏ yêu thích
                    setState(() {});
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
                      ? mockCardColor
                      // Thay thế grey.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.3),
                );
              },
            ),
            // Loại bỏ .paddingTop(60) ở cuối ListView vì đã xử lý bằng padding bên trong
          ],
        ),
      ),
    );
  }
}
