// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DefaultSettingScreen extends StatefulWidget {
  const DefaultSettingScreen({super.key});

  @override
  State<DefaultSettingScreen> createState() => _DefaultSettingScreenState();
}

class _DefaultSettingScreenState extends State<DefaultSettingScreen> {
  int dashboardTypeIndex = 0;
  int chartTypeIndex = 0;
  int trendingCardTypeIndex = 0;
  int chartMarketDefaultTypeIndex = 0;
  int colorIndex = 0;

  // Mock data cho các mục cài đặt
  final List<Map<String, dynamic>> dashboardOptions = [
    {
      'name': 'Màn hình chi tiết 1',
      'image':
          'https://via.placeholder.com/300x400/4CAF50/white?text=Dashboard+1',
    },
    {
      'name': 'Màn hình chi tiết 2',
      'image':
          'https://via.placeholder.com/300x400/2196F3/white?text=Dashboard+2',
    },
  ];

  final List<Map<String, dynamic>> chartOptions = [
    {
      'name': 'Biểu đồ đường',
      'image': 'https://via.placeholder.com/300/FF9800/white?text=Line',
    },
    {
      'name': 'Biểu đồ cột',
      'image': 'https://via.placeholder.com/300/9C27B0/white?text=Bar',
    },
  ];

  final List<Map<String, dynamic>> trendingCardOptions = [
    {
      'name': 'Thẻ xu hướng 1',
      'image': 'https://via.placeholder.com/300/FF5722/white?text=Trend+1',
    },
    {
      'name': 'Thẻ xu hướng 2',
      'image': 'https://via.placeholder.com/300/795548/white?text=Trend+2',
    },
  ];

  final List<Map<String, dynamic>> marketTypeOptions = [
    {'name': 'Tất cả'},
    {'name': 'Tăng giá'},
    {'name': 'Giảm giá'},
  ];

  final List<Color> gradientColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cài đặt mặc định',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Section 1: Choose Detail Screen
              _buildSection(
                title: 'Chọn màn hình chi tiết',
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: List.generate(dashboardOptions.length, (index) {
                    final data = dashboardOptions[index];
                    final isSelected = dashboardTypeIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          dashboardTypeIndex = index;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đã chọn: ${data['name']}')),
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.44,
                        height: screenHeight * 0.4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue.withValues(alpha: 0.5)
                                : Theme.of(context).dividerColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            // Hình ảnh
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                data['image'],
                                width: screenWidth * 0.48,
                                height: screenHeight * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Lớp phủ
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              color: isSelected
                                  ? Colors.black.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.45),
                            ),
                            // Tên
                            Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 800),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.54),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  data['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            // Check icon
                            if (isSelected)
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 800),
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ).paddingOnly(left: 8, right: 8, top: 8, bottom: 8),
              ),

              const SizedBox(height: 16),

              // Section 2: Default Chart Type
              _buildSection(
                title: 'Loại biểu đồ mặc định',
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: List.generate(chartOptions.length, (index) {
                    final data = chartOptions[index];
                    final isSelected = chartTypeIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          chartTypeIndex = index;
                        });
                      },
                      child: Container(
                        width: screenWidth * 0.46,
                        height: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue.withValues(alpha: 0.5)
                                : Theme.of(context).dividerColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                data['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              color: isSelected
                                  ? Colors.black.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.45),
                            ),
                            Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 800),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.54),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  data['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 800),
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ).paddingOnly(left: 8, right: 8, top: 8, bottom: 8),
              ),

              const SizedBox(height: 16),

              // Section 3: Choose Trending Card
              _buildSection(
                title: 'Chọn thẻ xu hướng',
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: List.generate(trendingCardOptions.length, (index) {
                    final data = trendingCardOptions[index];
                    final isSelected = trendingCardTypeIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          trendingCardTypeIndex = index;
                        });
                      },
                      child: Container(
                        width: screenWidth * 0.46,
                        height: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue.withValues(alpha: 0.5)
                                : Theme.of(context).dividerColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                data['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              color: isSelected
                                  ? Colors.black.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.45),
                            ),
                            Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 800),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.54),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  data['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 800),
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ).paddingOnly(left: 8, right: 8, top: 8, bottom: 8),
              ),

              // Section 4: Market Type
              _buildSection(
                title: 'Loại thị trường mặc định',
                child: Column(
                  children: List.generate(marketTypeOptions.length, (index) {
                    final data = marketTypeOptions[index];
                    final isSelected = chartMarketDefaultTypeIndex == index;

                    return ListTile(
                      title: Text(
                        data['name'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () {
                        setState(() {
                          chartMarketDefaultTypeIndex = index;
                        });
                      },
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              // Section 5: Chart Color
              _buildSection(
                title: 'Màu biểu đồ mặc định',
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(gradientColors.length, (index) {
                    final color = gradientColors[index];
                    final isSelected = colorIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          colorIndex = index;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 800),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? color.withValues(alpha: 0.7)
                                  : color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.blue,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ).paddingOnly(left: 8, right: 8, top: 16, bottom: 16),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
