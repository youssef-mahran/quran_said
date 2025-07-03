import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle; 

class SurahPlayerPage extends StatefulWidget {
  final String surahName;
  final int surahIndex;
  final String section;

  const SurahPlayerPage({
    super.key,
    required this.surahName,
    required this.surahIndex,
    required this.section,
  });

  @override
  State<SurahPlayerPage> createState() => _SurahPlayerPageState();
}

class _SurahPlayerPageState extends State<SurahPlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // تعريف مشغل الصوت
  bool isPlaying = false; // حالة التشغيل (يعمل أم لا)
  Duration duration = Duration.zero; // مدة الملف الصوتي الكلية
  Duration position = Duration.zero; // الموضع الحالي للتشغيل

  @override
  void initState() {
    super.initState();

    // الاستماع لتغييرات حالة مشغل الصوت (تشغيل، إيقاف مؤقت، إيقاف)
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) { // التأكد أن الـ Widget لا يزال موجودًا في الشجرة
        setState(() {
          isPlaying = state == PlayerState.playing; // تحديث حالة التشغيل
        });
      }
    });

    // الاستماع لتغييرات مدة الملف الصوتي
    _audioPlayer.onDurationChanged.listen((d) {
      if (mounted) {
        setState(() => duration = d);
      }
    });

    // الاستماع لتغييرات موضع التشغيل الحالي
    _audioPlayer.onPositionChanged.listen((p) {
      if (mounted) {
        setState(() => position = p);
      }
    });

    // تشغيل الصوت تلقائيًا عند تحميل الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playAudio(); // استدعاء دالة تشغيل الصوت
    });
  }

  @override
  void dispose() {
    // هذه الدالة تعمل عند الخروج من الصفحة
    _audioPlayer.stop(); // إيقاف الصوت
    _audioPlayer.dispose(); // تحرير موارد مشغل الصوت لمنع المشاكل
    super.dispose();
  }

  // دالة لتشغيل الصوت
  Future<void> _playAudio() async {
    // اسم الملف الصوتي يكون هو رقم السورة مضافًا إليه 1 (لأن الفهرس يبدأ من 0 والملفات من 1)
    final String audioFileName = '${widget.surahIndex + 1}.mp3';
    // المسار الكامل للملف الصوتي بناءً على القسم المختار
    final String path = 'sounds/${widget.section}/$audioFileName';

    try {
      // (اختياري) تحقق من وجود الملف في الـ assets، يمكن حذفه بعد التأكد من صحة المسارات
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      if (!manifestContent.contains(path)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('لم يتم العثور على الملف الصوتي: $path'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        return;
      }
      
      await _audioPlayer.play(AssetSource(path)); // تشغيل الصوت من الـ assets
      if (mounted) {
        setState(() => isPlaying = true); // تحديث الحالة إلى "قيد التشغيل"
      }
    } catch (e) {
      // عرض رسالة خطأ إذا فشل التشغيل
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء التشغيل: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      print('Error playing audio: $e'); // للـ Debugging
    }
  }

  // دالة للتبديل بين التشغيل والإيقاف المؤقت
  Future<void> _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _playAudio(); // استئناف التشغيل أو بدء تشغيله لأول مرة
    }
  }

  // دالة للتقديم 10 ثواني
  void _seekForward() async {
    final newPos = position + const Duration(seconds: 10);
    if (newPos < duration) {
      await _audioPlayer.seek(newPos);
    } else {
      await _audioPlayer.seek(duration); // الانتقال للنهاية لو تجاوز المدى
    }
  }

  // دالة للرجوع 10 ثواني
  void _seekBackward() async {
    final newPos = position - const Duration(seconds: 10);
    await _audioPlayer.seek(newPos > Duration.zero ? newPos : Duration.zero); // عدم النزول تحت الصفر
  }

  // دالة لتنسيق المدة الزمنية (مثال: 00:00)
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة لجعل التصميم متجاوبًا
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // لإظهار زر الرجوع
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          '﴾تطبيق القرآن الكريم﴿',
          style: TextStyle(
            fontSize: screenWidth * 0.06, // حجم خط متجاوب
            fontFamily: 'AmiriQuran',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFA68A6D),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // خلفية الصورة
          Image.asset('assets/images/B.jpg', fit: BoxFit.cover),
          // طبقة شفافة لتعتيم الخلفية
          Container(color: Colors.black.withOpacity(0.6)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة الشيخ
                CircleAvatar(
                  radius: screenWidth * 0.16, // حجم دائرة متجاوب
                  backgroundImage: const AssetImage('assets/images/sheikh.jpg'),
                ),
                SizedBox(height: screenHeight * 0.025),
                // اسم السورة
                Text(
                  widget.surahName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.07, // حجم خط متجاوب
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF4E8C1),
                    shadows: const [Shadow(blurRadius: 4, color: Colors.black)],
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                // اسم القارئ
                Text(
                  'فضيلة الشيخ سيد عبدالعظيم',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // حجم خط متجاوب
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                // أزرار التحكم بالصوت (تقديم، تشغيل/إيقاف، تأخير)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_10),
                      iconSize: screenWidth * 0.09, // حجم أيقونة متجاوب
                      color: Colors.white,
                      onPressed: _seekBackward,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: IconButton(
                        iconSize: screenWidth * 0.13, // حجم أيقونة متجاوب
                        icon: Icon(
                          isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                          color: Colors.white,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_10),
                      iconSize: screenWidth * 0.09, // حجم أيقونة متجاوب
                      color: Colors.white,
                      onPressed: _seekForward,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                // شريط التقدم (Slider)
                SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                    trackHeight: 4.0,
                    activeTrackColor: const Color(0xFFF4E8C1),
                    inactiveTrackColor: Colors.white.withOpacity(0.4),
                    thumbColor: const Color(0xFFF4E8C1),
                    overlayColor: const Color(0xFFF4E8C1).withOpacity(0.2),
                  ),
                  child: Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final newPosition = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(newPosition);
                      // إذا كان الصوت متوقفاً، يبقى متوقفاً عند السحب
                      if (!isPlaying) {
                        await _audioPlayer.pause();
                      }
                    },
                  ),
                ),
                // عرض الوقت الحالي والوقت الكلي للسورة
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(position),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035, // حجم خط متجاوب
                        ),
                      ),
                      Text(
                        _formatDuration(duration),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035, // حجم خط متجاوب
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}