import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'contact.dart';
import 'quiz1.dart'; // นำเข้า quiz1.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'TCS4GiveTonKhao', // ตั้งค่าเป็นชื่อฟอนต์ที่คุณกำหนดใน pubspec.yaml
      ),
      home: fable01(),
    );
  }
}

class fable01 extends StatefulWidget {
  const fable01({Key? key}) : super(key: key);

  @override
  _FablePageState createState() => _FablePageState();
}

class _FablePageState extends State<fable01> {
  String _storyLanguage = 'th'; // 'th' สำหรับภาษาไทย, 'en' สำหรับภาษาอังกฤษ
  String _comment = '';
  String? _selectedAnimal; // สำหรับ Radio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  final String _storyTh =
      'ในแม่น้ำสายหนึ่งมีจระเข้ชุกชุมถึงสามสายพันธุ์ด้วยกัน จึงทำให้ไม่มีใครกล้ามาจับปลา มีเพียงตาอยู่คนเดียวเท่านั้นที่คลุกคลีกับจระเข้และจับปลามาขายได้ เมื่อชาวบ้านเดือดร้อนที่ใช้แม่น้ำหล่อเลี้ยงชีวิตไม่ได้ เรื่องนี้จึงร้อนถึงหูพระราชา ตาอยู่จึงได้บอกกับพระราชาไปว่า ได้เลี้ยงจระเข้ตัวหนึ่งตั้งแต่ยังเล็กมันจึงไม่ทำร้าย ส่วนจระเข้ตัวอื่นถ้ามันกินอิ่มมันก็จะไม่ทำร้ายคนพระราชาจึงได้มีพระราชโองการสั่งให้เสมียนไปนับจำนวนจระเข้เพื่อที่จะได้นำอาหารไปเลี้ยงพวกมันได้อย่างทั่วถึง เสมียนทั้งสามคนก็พยายามนับจระเข้ที่อยู่ทั้งบนบกและในน้ำ สุดท้ายก็นับจระเข้ได้คนละหนึ่งพันตัว รวมทั้งหมดมีจระเข้ถึงสามพันตัว และพระราชาก็ได้สั่งให้เลี้ยงอาหารจระเข้จนอิ่มและไม่ออกมาทำร้ายชาวบ้าน และหากินในแม่น้ำแห่งนี้ได้อย่างมีความสุข นิทานเรื่องนี้เป็นตำนานหรือนิทานพื้นบ้านของจังหวัดสุพรรณบุรี จนกลายมาเป็นชื่อตำบลจระเข้สามพันจนถึงทุกวันนี้'; // เนื้อหา Thai story (ย่อ)
  final String _storyEn =
      'In a certain river, there lived a thriving population of crocodiles of three different species, making it unsafe for anyone to catch fish. Only a man named Ta Yu dared to mingle with the crocodiles and catch fish to sell. When the villagers could no longer rely on the river for their livelihood, the matter reached the ears of the king. Ta Yu told the king that he had raised one crocodile since it was small, so it would not harm him. As for the other crocodiles, he explained, as long as they were well-fed, they would not attack people.The king then issued a royal decree for officials to count the number of crocodiles so that food could be provided for them adequately. The three officials tried to count the crocodiles both on land and in the water. In the end, they counted a thousand crocodiles each, totaling three thousand crocodiles. The king ordered that food be given to the crocodiles until they were full, so they would not harm the villagers and could live happily in the river.This tale is a legend or folktale from Suphan Buri Province, which is how the area got its name, "Chao Chae Sam Pan," which translates to "Three Thousand Crocodiles,'; // English story (ย่อ)

  final List<Map<String, String>> _quizOptions = [
    {'value': 'crocodiles', 'label': 'จระเข้'},
    {'value': 'river', 'label': 'แม่น้ำ'},
    {'value': 'species', 'label': 'สายพันธุ์'},
  ];

  final List<String> _vocabularies = [
    'Crocodile แปลว่า จระเข้',
    'River  แปลว่า แม่น้ำ',
    'Species  แปลว่า สายพันธุ์',
  ];

  void _submitComment() {
    String thankYouMessage = _storyLanguage == 'th'
        ? 'ขอบคุณที่ตั้งใจฟัง'
        : 'Thank you for your attention';
    _showDialog(
        _storyLanguage == 'th' ? 'ขอบคุณ!' : 'Thank You!', thankYouMessage);
  }

  void _showResult(String message) {
    _showDialog(_storyLanguage == 'th' ? 'ผลลัพธ์' : 'Result', message);
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(_storyLanguage == 'th' ? 'ปิด' : 'Close'),
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage() {
    setState(() {
      _storyLanguage = _storyLanguage == 'th' ? 'en' : 'th'; // สลับภาษา
    });
  }

  Future<void> _playAudio() async {
    String audioFile =
        _storyLanguage == 'th' ? 'sound/th1.mp3' : 'sound/en1.mp3';
    await _audioPlayer.play(AssetSource(audioFile)); // เล่นเสียงตามภาษา
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _rewindAudio() async {
    Duration currentPosition =
        await _audioPlayer.getCurrentPosition() ?? Duration.zero;
    Duration newPosition = currentPosition - Duration(seconds: 10);
    await _audioPlayer
        .seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  Future<void> _forwardAudio() async {
    Duration currentPosition =
        await _audioPlayer.getCurrentPosition() ?? Duration.zero;
    Duration newPosition = currentPosition + Duration(seconds: 10);
    await _audioPlayer.seek(newPosition);
  }

  Future<void> _restartAudio() async {
    await _audioPlayer.seek(Duration.zero);
    await _audioPlayer.resume();
    setState(() {
      _isPlaying = true;
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop(); // หยุดเสียงเมื่อ widget ถูกปิด
    _audioPlayer.dispose(); // ปล่อยทรัพยากร
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String displayedStory = _storyLanguage == 'th' ? _storyTh : _storyEn;
    final buttonLabels = {
      'play': _storyLanguage == 'th' ? 'เล่น' : 'Play',
      'rewind': _storyLanguage == 'th' ? '<<10' : '<<10',
      'pause': _storyLanguage == 'th' ? 'พัก' : 'Pause',
      'forward': _storyLanguage == 'th' ? '10>>' : '10>>',
      'restart': _storyLanguage == 'th' ? 'เริ่มใหม่' : 'Restart',
      'quiz': _storyLanguage == 'th' ? 'แบบทดสอบ' : 'Test vocabulary',
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(175, 172, 255, 1),
        title: Text('นิทาน จระเข้สามพัน'),
        actions: [
          IconButton(
            icon: Icon(Icons.contact_mail),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUs()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFB3E4FF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.asset(
                        'assets/photo/1.jpg'), // รูปนิทานเรื่องจระเข้สามพัน
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'นิทานเรื่องจระเข้สามพัน',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),

              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _playAudio,
                    child: Text(buttonLabels['play']!),
                  ),
                  ElevatedButton(
                    onPressed: _rewindAudio,
                    child: Text(buttonLabels['rewind']!),
                  ),
                  ElevatedButton(
                    onPressed: _isPlaying ? _pauseAudio : _playAudio,
                    child: Text(buttonLabels['pause']!),
                  ),
                  ElevatedButton(
                    onPressed: _forwardAudio,
                    child: Text(buttonLabels['forward']!),
                  ),
                  ElevatedButton(
                    onPressed: _restartAudio,
                    child: Text(buttonLabels['restart']!),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Language change button
              ElevatedButton(
                onPressed: _changeLanguage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(175, 172, 255, 1),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('เปลี่ยนภาษา'),
              ),
              SizedBox(height: 20),

              // Story text with white background
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  displayedStory,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),

              // Comment section
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: _storyLanguage == 'th'
                      ? 'ข้อคิดที่ได้จากการอ่าน'
                      : 'Thoughts from reading',
                  contentPadding: EdgeInsets.all(16),
                ),
                onChanged: (value) {
                  _comment = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitComment,
                child: Text(_storyLanguage == 'th'
                    ? 'ส่งข้อคิด'
                    : 'Submit Comment'),
              ),

              // Test Vocabulary
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => quiz1()),
                  );
                },
                child: Text(buttonLabels['quiz']!),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
