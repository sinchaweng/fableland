import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'contact.dart'; // เพิ่มการนำเข้า ContactUs
import 'quiz005.dart';

class fable0005 extends StatefulWidget {
  const fable0005({Key? key}) : super(key: key);

  @override
  _FablePageState createState() => _FablePageState();
}

class _FablePageState extends State<fable0005> {
  String _storyLanguage = 'th'; // 'th' for Thai, 'en' for English
  String _comment = '';
  String? _selectedAnimal; // For Radio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;

  final String _storyTh =
      'ณ สวนสวรรค์อันไกลโพ้น นางฟ้าน้อยทุกคนตั้งใจศึกษาเพื่อเป็นนางฟ้าที่สมบูรณ์ ในวันสำเร็จหลักสูตร พวกเธอได้รับคฑาวิเศษเพื่อใช้ในการร่ายมนตร์กำกับดวงดาวให้ส่องแสงระยิบระยับเมื่อนางฟ้าหน้าใหม่เริ่มใช้คฑา ดวงดาวนับล้านบนฟ้าสว่างไสว แต่แสงสว่างนี้อยู่ได้ไม่นาน จึงต้องแบ่งปันดวงดาวให้แต่ละคนรับผิดชอบ หากดาวของใครเริ่มอ่อนแสง จะต้องทำให้สว่างสดใสอีกครั้งคืนแล้วคืนเล่า ดวงดาวสว่างอยู่เสมอ จนคืนหนึ่งมีดวงดาวใหม่เพิ่มขึ้น และดาวที่เคยสดใสกลับเริ่มริบหรี่ นางฟ้าต่างตื่นตระหนกและตามหานางฟ้าที่กำกับดาวนั้น จนพบว่าเธอสนุกกับการกำกับดาวพร้อมกันสองดวงนางฟ้าองค์น้อยจึงรู้ว่า ดวงดาวคือภาระ ไม่ใช่ทรัพย์สิน เธอรีบหันไปร่ายมนตรากำกับดาวของตนอีกครั้ง แสงดาวที่ริบหรี่กลับสว่างไสวสดใสเหมือนเดิม'; // Thai story
  final String _storyEn =
      'In a distant heavenly garden, all the little fairies dedicated themselves to studying to become complete fairies. On the day of their graduation, they received magical wands to use for casting spells to make the stars shine brightly.As the new fairies began to use their wands, millions of stars in the sky sparkled brilliantly. However, this light did not last long, so they had to share the responsibility of guiding the stars. If anyone s star began to dim, they needed to make it bright again.Night after night, the stars remained bright until one night a new star appeared, and a previously bright star began to flicker. The fairies were alarmed and searched for the fairy responsible for that dimming star. They found her having fun guiding two stars at once.The little fairy realized that guiding the stars was a responsibility, not a possession. She quickly turned her attention back to her own star, casting a spell to make it shine brightly again, restoring its brilliance.'; // English story

  final List<Map<String, String>> _quizOptions = [
    {'value': 'star', 'label': 'Star ดาว'},
    {'value': 'star', 'label': 'Star ดาว'},
    {'value': 'star', 'label': 'Star ดาว'},
  ];
  final List<String> _vocabularies = [
    'night แปลว่า กลางคืน',
    'fairies  แปลว่า นางฟ้า',
    'star แปลว่า ดาว',
  ];

  void _submitComment() {
    String thankYouMessage = _storyLanguage == 'th'
        ? 'ขอบคุณที่ตั้งใจฟัง'
        : 'Thank you for your attention';
    _showDialog(
        _storyLanguage == 'th' ? 'ขอบคุณ!' : 'Thank You!', thankYouMessage);
  }

  void _showQuiz() {
    String question = _storyLanguage == 'th'
        ? 'fairies แปลว่าอะไร?'
        : 'What does fairies mean?';
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
                String message = _selectedAnimal == 'fairies'
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
        _storyLanguage == 'th' ? 'sound/th005.mp3' : 'sound/en005.mp3';
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
        title: Text('นิทาน นางฟ้ากับดวงดาว'), // แสดงชื่อเรื่องแทนโลโก้
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
                    Image.asset('assets/photo/15.jpg'), // Image path
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'นิทาน นางฟ้ากับดวงดาว',
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
                            quiz005()), // เปลี่ยนไปยัง quiz1.dart
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
