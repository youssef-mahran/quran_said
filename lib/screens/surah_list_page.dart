import 'package:flutter/material.dart';
import 'package:quransaid/screens/surah_player_page.dart';

String getAudioSectionFolder(String category) {
  String cleanCategory = category.replaceAll('❖ ', '').replaceAll(' ❖', '');
  final Map<String, String> sectionMap = {
    'التلاوة': 'tilawa',
    'الترتيل': 'tarteel',
    'المصحف المعلم': 'muallim',
    'التجويد': 'tajweed',
  };

  return sectionMap[cleanCategory.trim()] ?? 'tajweed';
}

class SurahListPage extends StatefulWidget {
  final String category;

  const SurahListPage({super.key, required this.category});

  @override
  _SurahListPageState createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  final List<Map<String, dynamic>> _allSurahsData = const [
    {'arabic': 'الفاتحة', 'english': 'Al-Fatiha', 'verses': 7},
    {'arabic': 'البقرة', 'english': 'Al-Baqarah', 'verses': 286},
    {'arabic': 'آل عمران', 'english': 'Al-Imran', 'verses': 200},
    {'arabic': 'النساء', 'english': 'An-Nisa', 'verses': 176},
    {'arabic': 'المائدة', 'english': 'Al-Ma\'idah', 'verses': 120},
    {'arabic': 'الأنعام', 'english': 'Al-An\'am', 'verses': 165},
    {'arabic': 'الأعراف', 'english': 'Al-A\'raf', 'verses': 206},
    {'arabic': 'الأنفال', 'english': 'Al-Anfal', 'verses': 75},
    {'arabic': 'التوبة', 'english': 'At-Tawbah', 'verses': 129},
    {'arabic': 'يونس', 'english': 'Yunus', 'verses': 109},
    {'arabic': 'هود', 'english': 'Hud', 'verses': 123},
    {'arabic': 'يوسف', 'english': 'Yusuf', 'verses': 111},
    {'arabic': 'الرعد', 'english': 'Ar-Ra\'d', 'verses': 43},
    {'arabic': 'إبراهيم', 'english': 'Ibrahim', 'verses': 52},
    {'arabic': 'الحجر', 'english': 'Al-Hijr', 'verses': 99},
    {'arabic': 'النحل', 'english': 'An-Nahl', 'verses': 128},
    {'arabic': 'الإسراء', 'english': 'Al-Isra', 'verses': 111},
    {'arabic': 'الكهف', 'english': 'Al-Kahf', 'verses': 110},
    {'arabic': 'مريم', 'english': 'Maryam', 'verses': 98},
    {'arabic': 'طه', 'english': 'Taha', 'verses': 135},
    {'arabic': 'الأنبياء', 'english': 'Al-Anbiya', 'verses': 112},
    {'arabic': 'الحج', 'english': 'Al-Hajj', 'verses': 78},
    {'arabic': 'المؤمنون', 'english': 'Al-Mu\'minun', 'verses': 118},
    {'arabic': 'النور', 'english': 'An-Nur', 'verses': 64},
    {'arabic': 'الفرقان', 'english': 'Al-Furqan', 'verses': 77},
    {'arabic': 'الشعراء', 'english': 'Ash-Shu\'ara', 'verses': 227},
    {'arabic': 'النمل', 'english': 'An-Naml', 'verses': 93},
    {'arabic': 'القصص', 'english': 'Al-Qasas', 'verses': 88},
    {'arabic': 'العنكبوت', 'english': 'Al-Ankabut', 'verses': 69},
    {'arabic': 'الروم', 'english': 'Ar-Rum', 'verses': 60},
    {'arabic': 'لقمان', 'english': 'Luqman', 'verses': 34},
    {'arabic': 'السجدة', 'english': 'As-Sajda', 'verses': 30},
    {'arabic': 'الأحزاب', 'english': 'Al-Ahzab', 'verses': 73},
    {'arabic': 'سبأ', 'english': 'Saba', 'verses': 54},
    {'arabic': 'فاطر', 'english': 'Fatir', 'verses': 45},
    {'arabic': 'يس', 'english': 'Ya-Sin', 'verses': 83},
    {'arabic': 'الصافات', 'english': 'As-Saffat', 'verses': 182},
    {'arabic': 'ص', 'english': 'Sad', 'verses': 88},
    {'arabic': 'الزمر', 'english': 'Az-Zumar', 'verses': 75},
    {'arabic': 'غافر', 'english': 'Ghafir', 'verses': 85},
    {'arabic': 'فصلت', 'english': 'Fussilat', 'verses': 54},
    {'arabic': 'الشورى', 'english': 'Ash-Shura', 'verses': 53},
    {'arabic': 'الزخرف', 'english': 'Az-Zukhruf', 'verses': 89},
    {'arabic': 'الدخان', 'english': 'Ad-Dukhan', 'verses': 59},
    {'arabic': 'الجاثية', 'english': 'Al-Jathiya', 'verses': 37},
    {'arabic': 'الأحقاف', 'english': 'Al-Ahqaf', 'verses': 35},
    {'arabic': 'محمد', 'english': 'Muhammad', 'verses': 38},
    {'arabic': 'الفتح', 'english': 'Al-Fath', 'verses': 29},
    {'arabic': 'الحجرات', 'english': 'Al-Hujurat', 'verses': 18},
    {'arabic': 'ق', 'english': 'Qaf', 'verses': 45},
    {'arabic': 'الذاريات', 'english': 'Adh-Dhariyat', 'verses': 60},
    {'arabic': 'الطور', 'english': 'At-Tur', 'verses': 49},
    {'arabic': 'النجم', 'english': 'An-Najm', 'verses': 62},
    {'arabic': 'القمر', 'english': 'Al-Qamar', 'verses': 55},
    {'arabic': 'الرحمن', 'english': 'Ar-Rahman', 'verses': 78},
    {'arabic': 'الواقعة', 'english': 'Al-Waqi\'ah', 'verses': 96},
    {'arabic': 'الحديد', 'english': 'Al-Hadid', 'verses': 29},
    {'arabic': 'المجادلة', 'english': 'Al-Mujadila', 'verses': 22},
    {'arabic': 'الحشر', 'english': 'Al-Hashr', 'verses': 24},
    {'arabic': 'الممتحنة', 'english': 'Al-Mumtahanah', 'verses': 13},
    {'arabic': 'الصف', 'english': 'As-Saff', 'verses': 14},
    {'arabic': 'الجمعة', 'english': 'Al-Jumu\'ah', 'verses': 11},
    {'arabic': 'المنافقون', 'english': 'Al-Munafiqun', 'verses': 11},
    {'arabic': 'التغابن', 'english': 'At-Taghabun', 'verses': 18},
    {'arabic': 'الطلاق', 'english': 'At-Talaq', 'verses': 12},
    {'arabic': 'التحريم', 'english': 'At-Tahrim', 'verses': 12},
    {'arabic': 'الملك', 'english': 'Al-Mulk', 'verses': 30},
    {'arabic': 'القلم', 'english': 'Al-Qalam', 'verses': 52},
    {'arabic': 'الحاقة', 'english': 'Al-Haqqah', 'verses': 52},
    {'arabic': 'المعارج', 'english': 'Al-Ma\'arij', 'verses': 44},
    {'arabic': 'نوح', 'english': 'Nuh', 'verses': 28},
    {'arabic': 'الجن', 'english': 'Al-Jinn', 'verses': 28},
    {'arabic': 'المزمل', 'english': 'Al-Muzzammil', 'verses': 20},
    {'arabic': 'المدثر', 'english': 'Al-Muddaththir', 'verses': 56},
    {'arabic': 'القيامة', 'english': 'Al-Qiyamah', 'verses': 40},
    {'arabic': 'الإنسان', 'english': 'Al-Insan', 'verses': 31},
    {'arabic': 'المرسلات', 'english': 'Al-Mursalat', 'verses': 50},
    {'arabic': 'النبأ', 'english': 'An-Naba', 'verses': 40},
    {'arabic': 'النازعات', 'english': 'An-Nazi\'at', 'verses': 46},
    {'arabic': 'عبس', 'english': 'Abasa', 'verses': 42},
    {'arabic': 'التكوير', 'english': 'At-Takwir', 'verses': 29},
    {'arabic': 'الانفطار', 'english': 'Al-Infitar', 'verses': 19},
    {'arabic': 'المطففين', 'english': 'Al-Mutaffifin', 'verses': 36},
    {'arabic': 'الانشقاق', 'english': 'Al-Inshiqaq', 'verses': 25},
    {'arabic': 'البروج', 'english': 'Al-Buruj', 'verses': 22},
    {'arabic': 'الطارق', 'english': 'At-Tariq', 'verses': 17},
    {'arabic': 'الأعلى', 'english': 'Al-A\'la', 'verses': 19},
    {'arabic': 'الغاشية', 'english': 'Al-Ghashiyah', 'verses': 26},
    {'arabic': 'الفجر', 'english': 'Al-Fajr', 'verses': 30},
    {'arabic': 'البلد', 'english': 'Al-Balad', 'verses': 20},
    {'arabic': 'الشمس', 'english': 'Ash-Shams', 'verses': 15},
    {'arabic': 'الليل', 'english': 'Al-Layl', 'verses': 21},
    {'arabic': 'الضحى', 'english': 'Ad-Duha', 'verses': 11},
    {'arabic': 'الشرح', 'english': 'Ash-Sharh', 'verses': 8},
    {'arabic': 'التين', 'english': 'At-Tin', 'verses': 8},
    {'arabic': 'العلق', 'english': 'Al-Alaq', 'verses': 19},
    {'arabic': 'القدر', 'english': 'Al-Qadr', 'verses': 5},
    {'arabic': 'البينة', 'english': 'Al-Bayyinah', 'verses': 8},
    {'arabic': 'الزلزلة', 'english': 'Az-Zalzalah', 'verses': 8},
    {'arabic': 'العاديات', 'english': 'Al-Adiyat', 'verses': 11},
    {'arabic': 'القارعة', 'english': 'Al-Qari\'ah', 'verses': 11},
    {'arabic': 'التكاثر', 'english': 'At-Takathur', 'verses': 8},
    {'arabic': 'العصر', 'english': 'Al-Asr', 'verses': 3},
    {'arabic': 'الهمزة', 'english': 'Al-Humazah', 'verses': 9},
    {'arabic': 'الفيل', 'english': 'Al-Fil', 'verses': 5},
    {'arabic': 'قريش', 'english': 'Quraysh', 'verses': 4},
    {'arabic': 'الماعون', 'english': 'Al-Ma\'un', 'verses': 7},
    {'arabic': 'الكوثر', 'english': 'Al-Kawthar', 'verses': 3},
    {'arabic': 'الكافرون', 'english': 'Al-Kafirun', 'verses': 6},
    {'arabic': 'النصر', 'english': 'An-Nasr', 'verses': 3},
    {'arabic': 'المسد', 'english': 'Al-Masad', 'verses': 5},
    {'arabic': 'الإخلاص', 'english': 'Al-Ikhlas', 'verses': 4},
    {'arabic': 'الفلق', 'english': 'Al-Falaq', 'verses': 5},
    {'arabic': 'الناس', 'english': 'An-Nas', 'verses': 6},
  ];

  List<Map<String, dynamic>> _filteredSurahsData = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredSurahsData = List.from(_allSurahsData);
  }

  void _filterSurahs(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        _filteredSurahsData = List.from(_allSurahsData);
      } else {
        _filteredSurahsData =
            _allSurahsData.where((s) {
              return s['arabic'].contains(query) ||
                  s['english'].toLowerCase().contains(query.toLowerCase());
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(
            fontSize: screenWidth * 0.065,
            fontFamily: 'AmiriQuran',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/download (1).png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFC0A06B).withOpacity(0.8),
                  const Color(0xFFE6D6B9).withOpacity(0.8),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height:
                    kToolbarHeight +
                    MediaQuery.of(context).padding.top +
                    screenHeight * 0.015,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '...ابحث عن السورة',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: 'AmiriQuran',
                        fontSize: screenWidth * 0.045,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: const Color(0xFF8D6E63),
                        size: screenWidth * 0.07,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.012,
                      ),
                    ),
                    onChanged: _filterSurahs,
                    style: TextStyle(
                      color: const Color(0xFF3E2723),
                      fontFamily: 'AmiriQuran',
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    bottom: screenHeight * 0.02,
                    top: screenHeight * 0.01,
                  ),
                  itemCount: _filteredSurahsData.length,

                  separatorBuilder:
                      (_, __) => SizedBox(height: screenHeight * 0.015),
                  itemBuilder: (context, index) {
                    final surah = _filteredSurahsData[index];
                    final int surahIndexInAll = _allSurahsData.indexOf(surah);

                    return Card(
                      elevation: 4,
                      color: const Color(0xFFFEFDF6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        splashColor: Colors.amber.shade100,
                        highlightColor: Colors.amber.shade50,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SurahPlayerPage(
                                    surahName: surah['arabic'],
                                    surahIndex: surahIndexInAll,
                                    section: getAudioSectionFolder(
                                      widget.category,
                                    ),
                                  ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.015,
                            horizontal: screenWidth * 0.04,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${surahIndexInAll + 1}',
                                style: TextStyle(
                                  color: Colors.brown.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                  fontFamily: 'AmiriQuran',
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),

                              Expanded(
                                child: Text(
                                  'سورة ${surah['arabic']}',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.055,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF3E2723),
                                    fontFamily: 'AmiriQuran',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.02,
                                      vertical: screenHeight * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0E6D2),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.brown.shade200,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      '${surah['verses']} آياتها',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown.shade800,
                                        fontFamily: 'AmiriQuran',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),

                                  Text(
                                    surah['english'],
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      color: Colors.grey.shade700,
                                      fontFamily: 'AmiriQuran',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
