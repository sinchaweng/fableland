import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'contact.dart'; // เพิ่มการนำเข้า ContactUs
import 'quiz01.dart';

class fable001 extends StatefulWidget {
  const fable001({Key? key}) : super(key: key);

  @override
  _FablePageState createState() => _FablePageState();
}

class _FablePageState extends State<fable001> {
  String _storyLanguage = 'th'; // 'th' for Thai, 'en' for English
  String _comment = '';
  String? _selectedAnimal; // For Radio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  final String _storyTh =
      'กระต่ายหลงตัวเอง ชอบโอ้อวดว่าวิ่งเร็วกว่าใครๆ เมื่อเห็นเต่าเดินต้วมเตี้ยมมาก็หัวเราะเยาะ พร้อมกับพูดจาถากถางว่าต่อให้เต่าวิ่งนำหน้าไปก่อน กระต่ายก็สามารถก็แซงหน้าได้อยู่ดี ทำให้เต่าเกิดความไม่พอใจ จึงท้ากระต่ายวิ่งแข่งกัน กระต่ายเริ่มวิ่งนำหน้าเต่าไปไกล แต่เมื่อไปถึงครึ่งทาง ก็เกิดความชะล่าใจ หยุดพักเอนกายนอนใต้ต้นไม้ใหญ่จนเผลอหลับไป ในขณะที่เต่ายังคงเดินต่อไปเรื่อยๆ อย่างไม่ลดละ เมื่อกระต่ายตื่นนอนขึ้นมาก็ตกใจ รีบลนลานวิ่งไปยังเส้นชัย ทว่าเต่าไปถึงเส้นชัยก่อนแล้ว'; // Thai story
  final String _storyEn =
      'The self-confident rabbit loved to boast that he could run faster than anyone else. When he saw the tortoise moving slowly, he laughed mockingly and said that even if the tortoise started ahead, he could easily overtake him. This made the tortoise feel dissatisfied, so he challenged the rabbit to a race.The rabbit started off strong, quickly pulling far ahead of the tortoise. However, halfway through the race, he became overconfident and decided to take a nap under a big tree. Meanwhile, the tortoise continued to walk steadily without stopping.When the rabbit woke up, he was shocked to realize how much time had passed. He rushed to the finish line, but the tortoise had already crossed it first.'; // English story // English story

  final List<Map<String, String>> _quizOptions = [
    {'value': 'rabbit', 'label': 'กระต่าย'},
    {'value': 'tortoise', 'label': 'เต่า'},
    {'value': 'walk', 'label': 'เดิน'},
  ];

  final List<String> _vocabularies = [
    'rabbit แปลว่า กระต่าย',
    'tortoise  แปลว่า เต่า',
    'walk  แปลว่า เดิน',
  ];

  void _submitComment() {
    String thankYouMessage = _storyLanguage == 'th'
        ? 'คติสอนใจ : ความประมาทเป็นต้นเหตุของความพ่ายแพ้ แม้คู่ต่อสู้จะอ่อนด้อยกว่าก็ตาม'
        : 'Carelessness is the root of defeat, even if the opponent is weaker.';
    _showDialog(
        _storyLanguage == 'th' ? 'ขอบคุณ!' : 'Thank You!', thankYouMessage);
  }

  void _showQuiz() {
    String question = _storyLanguage == 'th'
        ? 'rabbit แปลว่าอะไร?'
        : 'What does rabbit mean?';
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
                String message = _selectedAnimal == 'rabbit'
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
        _storyLanguage == 'th' ? 'sound/th01.mp3' : 'sound/en01.mp3';
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
        title: Text('นิทานอีสป กระต่ายกับเต่า'),
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
                    Image.asset('assets/photo/6.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'นิทานอีสป กระต่ายกับเต่า',
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
                  backgroundColor: Color.fromRGBO(175, 172, 255, 1),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                    _storyLanguage == 'th' ? 'ส่งข้อคิด' : 'Submit Thoughts'),
              ),
              SizedBox(height: 10),

              // Vocabulary section without gray border
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _vocabularies.map((word) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white, // White background only
                          ),
                          child: Text(
                            word,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            quiz01()), // เปลี่ยนไปยัง quiz1.dart
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
