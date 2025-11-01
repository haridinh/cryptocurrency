import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Categories Demo',
      theme: ThemeData(primarySwatch: Colors.blue, cardColor: Colors.white),
      home: const CategoriesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Mock data thay thế cho mainList
  final List<String> mainList = [
    'Technology',
    'Health & Fitness',
    'Education',
    'Business',
    'Entertainment',
    'Lifestyle',
    'Travel',
    'Food & Drink',
  ];

  // Mock trạng thái loading
  bool isLoading = false;

  // Mock selected sort type
  String selectedSortType = 'Name A-Z';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(
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
              padding: const EdgeInsets.only(bottom: 60),
              itemCount: mainList.length,
              physics: const ClampingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CategoriesComponent(categoryName: mainList[index]);
              },
            ).paddingTop(46),
            // Loader thay thế cho LoaderWidget
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
          // Thay Observer + TextIcon bằng Container + Row
          GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet<bool>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: Theme.of(context).cardColor,
                builder: (context) {
                  return const CategorySortingTypeComponent();
                },
              );

              // Tránh dùng context sau async gap → kiểm tra mounted
              if (!mounted) return;

              if (result == true) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                setState(() {
                  isLoading = true;
                  // Giả lập fetch data
                  Future.delayed(const Duration(seconds: 1), () {
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue, // themePrimaryColor → thay bằng màu cố định
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedSortType,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
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

// Thay thế CategoriesComponent bằng widget đơn giản
class CategoriesComponent extends StatelessWidget {
  final String categoryName;

  const CategoriesComponent({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.category, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            categoryName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

// Thay thế CategorySortingTypeComponent bằng danh sách mock
class CategorySortingTypeComponent extends StatelessWidget {
  const CategorySortingTypeComponent({super.key});

  final List<String> sortOptions = const [
    'Name A-Z',
    'Name Z-A',
    'Most Popular',
    'Newest First',
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
          ...sortOptions.map((option) {
            return ListTile(
              title: Text(option),
              onTap: () {
                Navigator.pop(context, true); // Trả về true để trigger reload
              },
            );
          }),
        ],
      ),
    );
  }
}

// Extension để thay thế .paddingTop() từ nb_utils
extension WidgetPadding on Widget {
  Widget paddingTop(double top) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: this,
    );
  }

  Widget paddingBottom(double bottom) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: this,
    );
  }
}
