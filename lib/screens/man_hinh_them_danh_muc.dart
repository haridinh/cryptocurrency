// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Cần thêm intl cho DateFormat
// Loại bỏ import 'package:nb_utils/nb_utils.dart' và thay thế bằng mock/native code.

// --- MOCK DATA và Utility Classes ĐỂ THAY THẾ CHO CÁC PHẦN UNDEFINED ---

// Mock cho AppStore và Currency
class MockCurrency {
  final String symbol;
  MockCurrency({required this.symbol});
}

class MockAppStore {
  final bool isDarkMode = true;
  final bool mIsLoading = false; // Mock trạng thái loading
  final MockCurrency? mSelectedCurrency = MockCurrency(symbol: 'VND');
}

final MockAppStore mockAppStore = MockAppStore();
const Color mockCardColor = Color(0xFF353535); // Mock cho cardColor

// Mock cho AppCommon
class MockAppCommon {
  // Thay thế AppCommon.webInputDecoration
  static InputDecoration webInputDecoration(
    String label,
    BuildContext context,
  ) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      // Giả định styling
      labelStyle: TextStyle(
        color: mockAppStore.isDarkMode ? Colors.white70 : Colors.black54,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: mockAppStore.isDarkMode ? Colors.white54 : Colors.black26,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }
}

// Hàm mock để thay thế các extension method của nb_utils
String mockTranslate(String key) {
  switch (key) {
    case 'lbl_add_portfolio':
      return 'Thêm Portfolio';
    case 'lbl_name':
      return 'Tên';
    case 'lbl_date':
      return 'Ngày giao dịch';
    case 'lbl_no_of_units':
      return 'Số lượng Units';
    case 'lbl_per_coin_price':
      return 'Giá mỗi Coin';
    case 'lbl_total_price':
      return 'Tổng giá trị';
    default:
      return key;
  }
}

// Hàm mock để thay thế boldTextStyle()
TextStyle mockBoldTextStyle({double size = 14, Color? color}) => TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: size,
  color: color ?? (mockAppStore.isDarkMode ? Colors.white : Colors.black),
);

// Hàm mock để thay thế secondaryTextStyle()
TextStyle mockSecondaryTextStyle({Color? color, double size = 12}) =>
    TextStyle(fontSize: size, color: color ?? Colors.grey);

// Hàm mock để thay thế createMaterialColor
MaterialColor createMockMaterialColor(Color color) {
  return MaterialColor(color.value, <int, Color>{
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    500: color.withOpacity(0.6),
    900: color,
  });
}

// Widget mock cho LoaderWidget
class MockLoaderWidget extends StatelessWidget {
  const MockLoaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

// Thay thế Timestamp bằng DateTime và thêm hàm mở rộng mock
extension MockTimestamp on DateTime {
  DateTime toDate() => this;
  static DateTime fromDate(DateTime date) => date;
}

// --- BỐ CỤC CHÍNH CỦA WIDGET ---

class AddPortfolioScreen extends StatefulWidget {
  const AddPortfolioScreen({super.key});

  @override
  State<AddPortfolioScreen> createState() => _AddPortfolioScreenState();
}

class _AddPortfolioScreenState extends State<AddPortfolioScreen> {
  // 1. Thay thế các biến bị undefined
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameCont = TextEditingController(
    text: 'Mock Coin Name',
  );
  final TextEditingController dateCont = TextEditingController(
    text: DateFormat('dd MMM yyyy').format(DateTime.now()),
  );
  final TextEditingController noOfUnitsCont = TextEditingController();
  final TextEditingController perCoinCont = TextEditingController();
  final TextEditingController priceCont = TextEditingController();
  final TextEditingController notesCont = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode noOfUnitsFocus = FocusNode();
  final FocusNode perCoinFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode notesFocus = FocusNode();

  DateTime pickedDate = DateTime.now(); // Thay thế pickedDate và Timestamp

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị mock cho giá/unit
    noOfUnitsCont.text = '1.0';
    perCoinCont.text = '50000.00';
    _updateTotalPrice();
  }

  @override
  void dispose() {
    nameCont.dispose();
    dateCont.dispose();
    noOfUnitsCont.dispose();
    perCoinCont.dispose();
    priceCont.dispose();
    notesCont.dispose();
    nameFocus.dispose();
    dateFocus.dispose();
    noOfUnitsFocus.dispose();
    perCoinFocus.dispose();
    priceFocus.dispose();
    notesFocus.dispose();
    super.dispose();
  }

  void _updateTotalPrice() {
    // Thay thế logic tính toán giá
    double units = double.tryParse(noOfUnitsCont.text) ?? 0.0;
    double perCoinPrice = double.tryParse(perCoinCont.text) ?? 0.0;
    double totalPrice = units * perCoinPrice;

    // Sử dụng setState để cập nhật UI, thay vì dùng Observer
    setState(() {
      priceCont.text = totalPrice.toStringAsFixed(2);
    });
  }

  // Thay thế hàm saveData()
  void saveData() {
    if (formKey.currentState!.validate()) {
      debugPrint(
        'Dữ liệu Portfolio đã được lưu: ${nameCont.text}, ${noOfUnitsCont.text} units, Total: ${priceCont.text}',
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Thay thế AppScaffold bằng Scaffold mặc định
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // Thay thế 'lbl_add_portfolio'.translate
          mockTranslate('lbl_add_portfolio'),
          // Thay thế style: boldTextStyle(size: 22)
          style: mockBoldTextStyle(size: 22),
        ),
      ),
      // Thay thế Observer bằng Visibility + Builder
      body: Visibility(
        // Thay thế !appStore.mIsLoading.validate()
        visible: !mockAppStore.mIsLoading,
        // Thay thế defaultWidget: LoaderWidget()
        replacement: const MockLoaderWidget(),

        // Thay thế Observer(builder: (_)) bằng Builder
        child: Form(
          key: formKey, // Thay thế formKey
          child: Container(
            padding: const EdgeInsets.all(8),
            // Thay thế width: context.width()
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- 1. NAME FIELD ---
                  // Thay thế AppTextField bằng TextFormField
                  TextFormField(
                    keyboardType:
                        TextInputType.name, // Thay thế TextFieldType.NAME
                    controller: nameCont, // Thay thế controller
                    focusNode: nameFocus, // Thay thế focus
                    readOnly: true,
                    enabled: false,
                    onFieldSubmitted: (_) =>
                        dateFocus.requestFocus(), // Thay thế nextFocus
                    decoration: MockAppCommon.webInputDecoration(
                      // Thay thế "${"lbl_name".translate}*",
                      '${mockTranslate("lbl_name")}*',
                      context,
                    ),
                  ),

                  const SizedBox(height: 16), // Thay thế 16.height
                  // --- 2. DATE FIELD ---
                  TextFormField(
                    keyboardType:
                        TextInputType.name, // Thay thế TextFieldType.NAME
                    controller: dateCont, // Thay thế controller
                    focusNode: dateFocus, // Thay thế focus
                    onFieldSubmitted: (_) =>
                        noOfUnitsFocus.requestFocus(), // Thay thế nextFocus
                    readOnly: true,
                    onTap: () async {
                      // Thay thế onTap
                      // Logic DatePicker đã được sửa để sử dụng DateTime và Theme mặc định
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate:
                            pickedDate, // Thay thế pickedDate!.toDate()
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        builder: (context, child) => Theme(
                          data: ThemeData(
                            // Thay thế secondaryTextStyle(color: Colors.white, size: 12)
                            textTheme: TextTheme(
                              bodySmall: mockSecondaryTextStyle(
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                            // Thay thế createMaterialColor(cardColor)
                            primarySwatch: createMockMaterialColor(
                              mockCardColor,
                            ),
                            dialogTheme: DialogThemeData(
                              // Thay thế boldTextStyle(color: Colors.white)
                              contentTextStyle: mockBoldTextStyle(
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                          child: child!,
                        ),
                      );

                      if (date != null) {
                        setState(() {
                          pickedDate = date; // Cập nhật pickedDate
                          // Thay thế DateFormat('dd MMM yyyy').format(pickedDate!.toDate());
                          dateCont.text = DateFormat(
                            'dd MMM yyyy',
                          ).format(pickedDate);
                        });
                      }
                    },
                    decoration:
                        MockAppCommon.webInputDecoration(
                          // Thay thế "${"lbl_date".translate}*",
                          '${mockTranslate("lbl_date")}*',
                          context,
                        ).copyWith(
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                          ), // Thay màu trắng
                        ),
                  ),

                  const SizedBox(height: 16), // Thay thế 16.height
                  // --- 3. NO OF UNITS FIELD ---
                  TextFormField(
                    keyboardType:
                        TextInputType.number, // Thay thế TextFieldType.PHONE
                    controller: noOfUnitsCont, // Thay thế controller
                    focusNode: noOfUnitsFocus, // Thay thế focus
                    onFieldSubmitted: (_) =>
                        priceFocus.requestFocus(), // Thay thế nextFocus
                    onChanged: (unitPrice) {
                      // Thay thế onChanged
                      _updateTotalPrice();
                    },
                    decoration: MockAppCommon.webInputDecoration(
                      // Thay thế "${"lbl_no_of_units".translate}*",
                      '${mockTranslate("lbl_no_of_units")}*',
                      context,
                    ),
                    validator: (s) => (s!.isEmpty || double.tryParse(s) == null)
                        ? 'Vui lòng nhập số lượng hợp lệ'
                        : null,
                  ),

                  const SizedBox(height: 16), // Thay thế 16.height
                  // --- 4. PER COIN PRICE FIELD ---
                  // Thay thế Observer bằng Builder (vì _updateTotalPrice đã dùng setState)
                  Builder(
                    builder: (_) => TextFormField(
                      keyboardType:
                          TextInputType.number, // Thay thế TextFieldType.PHONE
                      controller: perCoinCont, // Thay thế controller
                      onChanged: (perCoinPrice) {
                        // Thay thế onChanged
                        _updateTotalPrice();
                      },
                      focusNode: perCoinFocus, // Thay thế focus
                      onFieldSubmitted: (_) =>
                          notesFocus.requestFocus(), // Thay thế nextFocus
                      decoration:
                          MockAppCommon.webInputDecoration(
                            // Thay thế "${"lbl_per_coin_price".translate}*",
                            '${mockTranslate("lbl_per_coin_price")}*',
                            context,
                          ).copyWith(
                            prefixIcon: IconButton(
                              onPressed: () {
                                debugPrint('Icon prefix pressed');
                              },
                              // Thay thế appStore.mSelectedCurrency?.symbol.validate()
                              icon: Text(
                                mockAppStore.mSelectedCurrency?.symbol ?? '\$',
                                style:
                                    mockBoldTextStyle(), // Thay thế boldTextStyle()
                              ),
                            ),
                          ),
                      validator: (s) =>
                          (s!.isEmpty || double.tryParse(s) == null)
                          ? 'Vui lòng nhập giá hợp lệ'
                          : null,
                    ),
                  ),

                  const SizedBox(height: 16), // Thay thế 16.height
                  // --- 5. TOTAL PRICE FIELD ---
                  // Thay thế Observer bằng Builder
                  Builder(
                    builder: (_) => TextFormField(
                      keyboardType:
                          TextInputType.number, // Thay thế TextFieldType.PHONE
                      controller: priceCont, // Thay thế controller
                      focusNode: priceFocus, // Thay thế focus
                      onFieldSubmitted: (_) =>
                          perCoinFocus.requestFocus(), // Thay thế nextFocus
                      enabled: false,
                      readOnly: true,
                      decoration:
                          MockAppCommon.webInputDecoration(
                            // Thay thế "lbl_total_price".translate
                            mockTranslate("lbl_total_price"),
                            context,
                          ).copyWith(
                            prefixIcon: IconButton(
                              onPressed: () {
                                debugPrint('Icon prefix pressed');
                              },
                              // Thay thế appStore.mSelectedCurrency?.symbol.validate()
                              icon: Text(
                                mockAppStore.mSelectedCurrency?.symbol ?? '\$',
                                style:
                                    mockBoldTextStyle(), // Thay thế boldTextStyle()
                              ),
                            ),
                          ),
                    ),
                  ),

                  const SizedBox(height: 16), // Thay thế 16.height
                  // --- 6. NOTES FIELD ---
                  // Thay thế Observer bằng Builder
                  Builder(
                    builder: (context) {
                      return TextFormField(
                        keyboardType:
                            TextInputType.name, // Thay thế TextFieldType.NAME
                        controller: notesCont, // Thay thế controller
                        focusNode: notesFocus, // Thay thế focus
                        onFieldSubmitted: (s) {
                          saveData(); // Thay thế saveData()
                        },
                        validator: (s) =>
                            null, // Thay thế isValidationRequired: false
                        maxLines: 6,
                        minLines: 3,
                        decoration: MockAppCommon.webInputDecoration(
                          "Notes",
                          context,
                        ).copyWith(alignLabelWithHint: true),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // --- FLOATING ACTION BUTTON ---
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          saveData(); // Thay thế saveData()
        },
        child: Builder(
          // Thay thế Observer
          builder: (_) => Icon(
            Icons.done,
            // Thay thế appStore.isDarkMode
            color: mockAppStore.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
