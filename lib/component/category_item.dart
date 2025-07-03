import 'package:flutter/material.dart';
import 'package:quransaid/screens/surah_list_page.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  const CategoryItem({super.key, required this.title, required this.color});

  IconData _getIcon(String title) {
    switch (title) {
      case 'التلاوة':
        return Icons.headphones;
      case 'الترتيل':
        return Icons.library_music;
      case 'المصحف المعلم':
        return Icons.school;
      case 'التجويد':
        return Icons.menu_book;
      default:
        return Icons.menu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SurahListPage(category: title),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.9,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.92),
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/images/decor.png'),
            fit: BoxFit.cover,
            opacity: 0.07,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              radius: 28,
              child: Icon(
                _getIcon(title),
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'AmiriQuran',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
