import 'package:fableland_application/quiz03.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'contact.dart'; // เพิ่มการนำเข้า ContactUs
import 'quiz03.dart';

class fable003 extends StatefulWidget {
  const fable003({Key? key}) : super(key: key);

  @override
  _FablePageState createState() => _FablePageState();
}

class _FablePageState extends State<fable003> {
  String _storyLanguage = 'th'; // 'th' for Thai, 'en' for English
  String _comment = '';
  String? _selectedAnimal; // For Radio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;

  final String _storyTh =
      'แม่หมูมีลูกน้อย 3 ตัว และได้ปล่อยให้ลูกๆ ได้ออกเดินทางไปเผชิญโลกภายนอกด้วยตัวเอง ลูกหมูตัวที่ 1 ผู้เกียจคร้านได้ออกไปสร้างบ้านที่ทำจากฟาง เพราะทำได้ง่ายและเร็วที่สุด แต่วันหนึ่งหมาป่าจ้องจะมากินลูกหมูตัวที่ 1 ซึ่งบ้านไม่มีความแข็งแรง ทำให้ลูกหมูต้องวิ่งหนีสุดชีวิตไปหลบที่บ้านของลูกหมูตัวที่ 2 ที่สร้างจากไม้ แม้จะมีความแข็งแรงกว่า แต่ก็ไม่สามารถต้านทานหมาป่าได้อีกเช่นกัน ลูกหมูทั้ง 2 ตัว จึงรีบวิ่งหนีออกไปยังบ้านของลูกหมูตัวที่ 3 ซึ่งสร้างด้วยอิฐ เมื่อหมาป่าตามมา ก็ไม่สามารถทำลายบ้านอิฐได้ ลูกหมูทั้ง 3 ตัวจึงรอดชีวิต'; // Thai story
  final String _storyEn =
      'Mother Pig had three little piglets and allowed them to venture out into the world on their own. The first piglet, who was lazy, built a house of straw because it was the easiest and quickest option. However, one day, a wolf came to eat the first piglet. The straw house was not strong enough, so the piglet had to run for its life to the house of the second piglet, which was made of wood. Although the wooden house was sturdier, it could not withstand the wolf either.'; // English story

  final List<Map<String, String>> _quizOptions = [
    {'one': 'pig', 'label': 'Pig หมู'},
    {'one': 'pig', 'label': 'Pig หมู'},
    {'one': 'pig', 'label': 'Pig หมู'},
  ];
  final List<String> _vocabularies = [
    'mother แปลว่า แม่',
    'pig   แปลว่า หมู',
    'wolf  แปลว่า หมาป่า',
  ];

  void _submitComment() {
    String thankYouMessage = _storyLanguage == 'th'
        ? 'คติสอนใจ : ความเกียจคร้านแม้จะทำให้เราสบาย แต่ก็อาจนำทุกข์ภัยมาสู่ตนได้'
        : 'Laziness may bring us comfort, but it can also lead to suffering and misfortune.';
    _showDialog(
        _storyLanguage == 'th' ? 'ขอบคุณ!' : 'Thank You!', thankYouMessage);
  }

  void _showQuiz() {
    String question =
        _storyLanguage == 'th' ? 'wolf แปลว่าอะไร?' : 'What does wolf mean?';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_storyLanguage == 'th' ? 'แบบทดสอบ' : 'Quiz'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(question),
              ..._quizOptions.map((option) => RadioListTile<String>(
                    title: Text(option['label']!),
                    value: option['value']!,
                    groupValue: _selectedAnimal,
                    onChanged: (value) {
                      setState(() {
                        _selectedAnimal = value;
                      });
                    },
                  )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String message = _selectedAnimal == 'wolf'
                    ? (_storyLanguage == 'th' ? "ถูกนะครับ" : "Correct!")
                    : (_storyLanguage == 'th' ? "ผิดนะครับ" : "Incorrect!");
                Navigator.of(context).pop(); // Close dialog
                _showResult(message); // Show result
              },
              child:
                  Text(_storyLanguage == 'th' ? 'ส่งคำตอบ' : 'Submit Answer'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(_storyLanguage == 'th' ? 'ยกเลิก' : 'Cancel'),
            ),
          ],
        );
      },
    );
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
      _storyLanguage = _storyLanguage == 'th' ? 'en' : 'th'; // Toggle language
    });
  }

  Future<void> _playAudio() async {
    String audioFile =
        _storyLanguage == 'th' ? 'sound/th03.mp3' : 'sound/en03.mp3';
    await _audioPlayer.play(AssetSource(audioFile)); // เล่นเสียงตามภาษา
    _isPlaying = true;
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  Future<void> _rewindAudio() async {
    Duration newPosition = _currentPosition - Duration(seconds: 10);
    await _audioPlayer
        .seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  Future<void> _forwardAudio() async {
    Duration newPosition = _currentPosition + Duration(seconds: 10);
    await _audioPlayer.seek(newPosition);
  }

  Future<void> _restartAudio() async {
    await _audioPlayer.seek(Duration.zero);
    await _audioPlayer.resume();
    _isPlaying = true;
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
        title: Text('นิทานอีสป ลูกหมูสามตัว'), // แสดงชื่อเรื่องแทนโลโก้
        actions: [
          IconButton(
            icon: Icon(Icons.contact_mail),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactUs()), // ไปที่หน้า ContactUs
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
                    Image.asset('assets/photo/8.jpg'), // Image path
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'นิทานอีสป ลูกหมูสามตัว',
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
                    onPressed: _isPlaying ? _playAudio : _playAudio,
                    child: Text(buttonLabels['play']!),
                  ),
                  ElevatedButton(
                    onPressed: _rewindAudio,
                    child: Text(buttonLabels['rewind']!),
                  ),
                  ElevatedButton(
                    onPressed: _isPlaying ? _pauseAudio : _pauseAudio,
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
                  backgroundColor:
                      Color.fromRGBO(175, 172, 255, 1), // Background color
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
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  displayedStory,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),

              // Comment section
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: _storyLanguage == 'th'
                        ? 'ข้อคิดที่ได้จากการอ่าน'
                        : 'Thoughts from reading',
                    contentPadding: EdgeInsets.all(16),
                  ),
                  onChanged: (value) {
                    _comment = value;
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitComment,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromRGBO(175, 172, 255, 1), // Background color
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                    _storyLanguage == 'th' ? 'ส่งข้อคิด' : 'Submit Thoughts'),
              ),
              SizedBox(height: 10),
              Text(
                _storyLanguage == 'th'
                    ? 'คำศัพท์ที่ได้จากนิทานเรื่องนี้'
                    : 'Vocabulary from this story',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _storyLanguage == 'th'
                          ? 'คำศัพท์ที่ได้จากนิทานเรื่องนี้'
                          : 'Vocabulary from this story',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ..._vocabularies.map((vocab) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            vocab,
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            quiz03()), // เปลี่ยนไปยัง quiz1.dart
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(175, 172, 255, 1),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(buttonLabels['quiz']!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
