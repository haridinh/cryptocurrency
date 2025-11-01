import 'package:flutter/material.dart';
// Thay thế import 'package:nb_utils/nb_utils.dart'; bằng các hàm mock và widget mặc định.

// --- MOCK DATA và Utility Classes ĐỂ THAY THẾ CHO CÁC PHẦN UNDEFINED ---

/// Mock cho appStore để thay thế 'appStore.isDarkMode'
class MockAppStore {
  final bool isDarkMode = false; // Giả định chế độ sáng
}

final MockAppStore mockAppStore = MockAppStore();

/// Mock cho AppImages
class MockAppImages {
  // ĐƯỜNG DẪN GIẢ ĐỊNH - HÃY THAY THẾ BẰNG ĐƯỜNG DẪN HÌNH ẢNH THỰC CỦA BẠN
  static const String placeholderImage = 'assets/images/placeholder.png';
  static const String coinGeckoImage = 'assets/images/coingecko_logo.png';

  static const String gifWithName = placeholderImage;
  static const String gifWithNameWhite = placeholderImage;
  static const String coinGecko = coinGeckoImage;
}

/// Mock cho Urls
class MockUrls {
  static const String coinGeckoUrl = 'https://www.coingecko.com/';
  static const String copyRight =
      '© 2025 Bản quyền thuộc về Tên Công Ty Của Bạn.';
}

/// Mock cho AppCommon
class MockAppCommon {
  // Thay thế AppCommon.commonLaunchUrl
  static void commonLaunchUrl(String url) {
    debugPrint('Đang cố gắng mở URL: $url');
    // Trong ứng dụng thực tế, bạn sẽ dùng 'url_launcher' tại đây
  }
}

/// Mock cho PackageInfoData
class PackageInfoData {
  final String versionName;
  PackageInfoData({required this.versionName});
}

/// Mock cho IqonicModel
class MockIqonicModel {
  final String? iconPath;
  final String url;

  MockIqonicModel({this.iconPath, required this.url});

  static List<MockIqonicModel> getData() {
    // Dữ liệu mock cho các icon mạng xã hội
    return [
      MockIqonicModel(
        iconPath: MockAppImages.placeholderImage,
        url: 'https://facebook.com/',
      ),
      MockIqonicModel(
        iconPath: MockAppImages.placeholderImage,
        url: 'https://twitter.com/',
      ),
      MockIqonicModel(
        iconPath: MockAppImages.placeholderImage,
        url: 'https://instagram.com/',
      ),
      MockIqonicModel(
        iconPath: MockAppImages.placeholderImage,
        url: 'https://linkedin.com/',
      ),
    ];
  }
}

/// Hàm mock để thay thế getPackageInfo()
Future<PackageInfoData> mockGetPackageInfo() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return PackageInfoData(versionName: '1.0.0'); // Dữ liệu phiên bản mock
}

// --- Các hàm tiện ích để thay thế extension methods của nb_utils ---

// Thay thế .translate
String mockTranslate(String key) {
  switch (key) {
    case 'lbl_Version':
      return 'Phiên bản';
    case 'lbl_data_provided_by_coinGecko':
      return 'Dữ liệu được cung cấp bởi CoinGecko';
    case 'lbl_follow_us_on':
      return 'Theo dõi chúng tôi trên';
    default:
      return key;
  }
}

// Thay thế .height
Widget mockHeight(double height) => SizedBox(height: height);

// Thay thế .width()
double mockContextWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

// Thay thế secondaryTextStyle()
TextStyle secondaryTextStyle() =>
    const TextStyle(fontSize: 14, color: Colors.grey);

// Thay thế boldTextStyle()
TextStyle boldTextStyle() =>
    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

// Thay thế CommonErrorBuilder (chỉ là một Text đơn giản)
Widget mockCommonErrorBuilder(String text) =>
    Text('Lỗi: $text', style: const TextStyle(color: Colors.red));

// --- BỐ CỤC CHÍNH CỦA WIDGET ---

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    // Kiểm tra xem hình ảnh placeholder có sẵn không
    // Nếu bạn chưa thêm hình ảnh vào 'assets/', ứng dụng sẽ lỗi.
    // Đảm bảo bạn có file 'assets/images/placeholder.png' và 'assets/images/coingecko_logo.png'
    // HOẶC thay thế đường dẫn trong MockAppImages.

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(mockTranslate('lbl_AboutUs')), // Tiêu đề AppBar mock
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // --- PHẦN GIỮA MÀN HÌNH (LOGO, VERSION, COINGECKO) ---
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  // Thay thế appStore.isDarkMode ? AppImages.gifWithName : AppImages.gifWithNameWhite
                  mockAppStore.isDarkMode
                      ? MockAppImages.gifWithName
                      : MockAppImages.gifWithNameWhite,
                  scale: 3,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.info_outline,
                    size: 100,
                  ), // Xử lý lỗi nếu không tìm thấy ảnh
                ),

                // Thay thế SnapHelperWidget bằng FutureBuilder
                FutureBuilder<PackageInfoData>(
                  future: mockGetPackageInfo(), // Thay thế getPackageInfo()
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Thay thế CommonErrorBuilder
                      return mockCommonErrorBuilder(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      return Text(
                        // Thay thế '${'lbl_Version'.translate} ${data.versionName}'
                        '${mockTranslate('lbl_Version')} ${snapshot.data!.versionName}',
                        style:
                            secondaryTextStyle(), // Thay thế secondaryTextStyle()
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                mockHeight(16), // Thay thế 16.height
                // Thay thế TextIcon bằng Row
                GestureDetector(
                  // Thay thế .onTap
                  onTap: () {
                    // Thay thế AppCommon.commonLaunchUrl(Urls.coinGeckoUrl)
                    MockAppCommon.commonLaunchUrl(MockUrls.coinGeckoUrl);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Giảm kích thước Row
                    children: [
                      Image.asset(
                        MockAppImages.coinGecko, // Thay thế AppImages.coinGecko
                        width: 25,
                        height: 25,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.warning,
                              size: 25,
                            ), // Xử lý lỗi ảnh
                      ),
                      const SizedBox(width: 8), // Khoảng cách giữa icon và text
                      Text(
                        // Thay thế 'lbl_data_provided_by_coinGecko'.translate
                        mockTranslate('lbl_data_provided_by_coinGecko'),
                        style: secondaryTextStyle(),
                      ),
                    ],
                  ),
                ),

                mockHeight(16), // Thay thế 16.height
              ],
            ),

            // --- PHẦN DƯỚI MÀN HÌNH (FOLLOW US) ---
            Positioned(
              bottom: 60,
              child: SizedBox(
                // Giữ nguyên Container, thay thế context.width()
                width: mockContextWidth(context),
                child: Column(
                  children: [
                    Text(
                      // Thay thế 'lbl_follow_us_on'.translate
                      mockTranslate('lbl_follow_us_on'),
                      style: boldTextStyle(), // Thay thế boldTextStyle()
                    ),
                    mockHeight(16), // Thay thế 16.height

                    Padding(
                      // Thay thế .paddingSymmetric(horizontal: 16)
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // Thay thế List.generate(IqonicModel.getData().length, ...)
                        children: List.generate(MockIqonicModel.getData().length, (
                          index,
                        ) {
                          // Thay thế IqonicModel data = IqonicModel.getData()[index];
                          MockIqonicModel data =
                              MockIqonicModel.getData()[index];

                          return GestureDetector(
                            // Thay thế .onTap
                            onTap: () {
                              // Thay thế AppCommon.commonLaunchUrl(data.url.validate());
                              MockAppCommon.commonLaunchUrl(
                                data.url,
                              ); // Bỏ .validate() vì url đã là String
                            },
                            // Thay thế Container không cần thiết bằng một SizedBox cho kích thước
                            child: SizedBox(
                              width: 50, // Giả định kích thước cho nút
                              height: 50,
                              child: Image.asset(
                                // Thay thế data.icon!.assetImage(width: 30, height: 30)
                                data.iconPath!,
                                width: 30,
                                height: 30,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.share,
                                      size: 30,
                                      color: Colors.blue,
                                    ), // Icon thay thế
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- PHẦN DƯỚI CÙNG (COPYRIGHT) ---
            Positioned(
              bottom: 16,
              left: 16,
              right: 0,
              child: Center(
                // Thay thế .center()
                child: Text(
                  MockUrls.copyRight, // Thay thế Urls.copyRight
                  style: secondaryTextStyle(), // Thay thế secondaryTextStyle()
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
