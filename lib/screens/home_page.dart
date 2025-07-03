import 'package:flutter/material.dart';
import 'package:quransaid/component/category_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Map<String, dynamic>> categories = [
    {'title': 'التلاوة', 'color': Color.fromARGB(255, 152, 114, 58)},
    {'title': 'الترتيل', 'color': Color(0xFFA68A6D)},
    {'title': 'المصحف المعلم', 'color': Color(0xFF7B6142)},
    {'title': 'التجويد', 'color': Color(0xFFD8C68C)},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          '﴾تطبيق القرآن الكريم﴿',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'AmiriQuran',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFA68A6D),
        centerTitle: true,
        elevation: 4,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/A.jpg'),
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.2)),
          Column(
            children: [
              SizedBox(height: screenHeight * 0.16),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('assets/images/sheikh.jpg'),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.brown, width: 1.5),
                    ),
                    child: Text(
                      'فضيلة الشيخ سيد عبدالعظيم',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontFamily: 'AmiriQuran',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                      ),
                      child: CategoryItem(
                        title: '❖ ${category['title']} ❖',
                        color: category['color'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
