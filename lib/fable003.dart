import 'package:fableland_application/quiz003.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'contact.dart'; // เพิ่มการนำเข้า ContactUs
import 'quiz003.dart';

class fable0003 extends StatefulWidget {
  const fable0003({Key? key}) : super(key: key);

  @override
  _FablePageState createState() => _FablePageState();
}

class _FablePageState extends State<fable0003> {
  String _storyLanguage = 'th'; // 'th' for Thai, 'en' for English
  String _comment = '';
  String? _selectedAnimal; // For Radio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;

  final String _storyTh =
      'ครั้งหนึ่งมีพ่อค้าร่ำรวยที่มีลูกสาวสามคน วันหนึ่งเขาสูญเสียทรัพย์สินทั้งหมดและต้องย้ายไปอยู่ชนบท จนกระทั่งได้รับข่าวดีว่าเรือสินค้าที่เขาส่งออกกลับเข้าท่า เขาจึงเดินทางไปเมืองและถามลูกๆ ว่าต้องการของขวัญอะไร ลูกสาวคนโตขอชุดสวย คนที่สองขอสร้อยไข่มุก แต่เบลล์ ลูกสาวคนเล็กขอกุหลาบระหว่างทางกลับบ้าน พ่อค้าถูกพายุพัดไปจนต้องพักที่ปราสาทร้าง เขาพบอาหารและนอนหลับไป เมื่อตื่นขึ้น พบว่าเขาขโมยกุหลาบจากสวนของอสูร อสูรจึงขู่ว่าจะฆ่าเขา แต่สุดท้ายให้อภัยโดยขอให้พ่อค้านำเบลล์มาแทนเบลล์อาสากลับไปยังปราสาทเพื่อช่วยชีวิตพ่อ เธอเริ่มรู้จักอสูรและพบว่าเขาอ่อนโยน ทั้งสองใช้ชีวิตร่วมกันอย่างมีความสุข จนวันหนึ่ง อสูรถามเธอว่าจะอยู่เป็นภรรยาของเขาไหม แต่เบลล์ลังเลเมื่อเบลล์เห็นพ่อป่วย เธอขออนุญาตกลับบ้านและสัญญาว่าจะกลับภายใน 7 วัน แต่วันเวลาผ่านไปเร็ว เบลล์ตัดสินใจกลับไปยังปราสาท เมื่อถึงที่นั่น เธอพบอสูรนอนหมดสติ เธอประกาศรักเขาและขอแต่งงาน ซึ่งทำให้คำสาปถูกทำลาย อสูรกลับคืนเป็นเจ้าชายและทั้งคู่มีความสุขตลอดไป'; // Thai story
  final String _storyEn =
      'Once upon a time, there was a wealthy merchant with three daughters. One day, he lost all his fortune and had to move to the countryside. Then he received good news that a trading ship he had sent out was returning to port. He traveled to the city and asked his daughters what gifts they wanted. The eldest daughter asked for a beautiful dress, the second one wanted a pearl necklace, but Belle, the youngest daughter, requested a rose.On his way home, the merchant was caught in a storm and had to seek shelter in an abandoned castle. He found food and fell asleep. When he woke up he realized he had taken a rose from the Beast s garden The Beast threatened to kill him but ultimately forgave him on the condition that he bring Belle in exchange for his life Belle volunteered to return to the castle to save her father. She began to get to know the Beast and discovered that he was gentle. They lived together happily until one day the Beast asked her if she would be his wife but Belle hesitated.When Belle saw her father was ill she asked permission to return home and promised to come back within seven days. However, time passed quickly, and Belle decided to return to the castle. When she arrived, she found the Beast unconscious. She professed her love for him and asked to marry him which broke the curse. The Beast turned back into a prince and they lived happly ever after.'; // English story

  final List<Map<String, String>> _quizOptions = [
    {'value': 'rose', 'label': 'Rose กุหลาบ'},
    {'value': 'rose', 'label': 'Rose กุหลาบ'},
    {'value': 'rose', 'label': 'Rose กุหลาบ'},
  ];
  final List<String> _vocabularies = [
    'daughters แปลว่า ลูกสาว',
    'storm  แปลว่า พายุ',
    'city  แปลว่า เมือง',
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
        ? 'quickly แปลว่าอะไร?'
        : 'What does quickly mean?';
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
                String message = _selectedAnimal == 'quickly'
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
        _storyLanguage == 'th' ? 'sound/th003.mp3' : 'sound/en003.mp3';
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
        title: Text('นิทาน โฉมงามกับเจ้าชายอสูร'), // แสดงชื่อเรื่องแทนโลโก้
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
                    Image.asset('assets/photo/13.jpg'), // Image path
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'นิทานโฉมงามกับเจ้าชายอสูร',
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
                            quiz003()), // เปลี่ยนไปยัง quiz1.dart
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
