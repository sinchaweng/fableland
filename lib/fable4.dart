import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'contact.dart'; // เพิ่มการนำเข้า ContactUs
import 'quiz4.dart';

class fable04 extends StatefulWidget {
  const fable04({Key? key}) : super(key: key);

  @override
  _FablePageState createState() => _FablePageState();
}

class _FablePageState extends State<fable04> {
  String _storyLanguage = 'th'; // 'th' for Thai, 'en' for English
  String _comment = '';
  String? _selectedAnimal; // For Radio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;

  final String _storyTh =
      'ตำนานของเกาะหนู เกาะแมว สถานที่ท่องเที่ยวสำคัญของจังหวัดสงขลา ที่เล่าว่า..เมื่อนานมาแล้วยังไม่มีเกาะหนูเกาะแมวเกิดขึ้นนั้น ที่นี่เคยเป็นเมืองท่าสำคัญที่มีการค้าขายมากมาย และพ่อค้าชาวจีนก็ได้นำหมาและแมวคู่หนึ่งขึ้นเรือสำเภามาด้วย พวกมันทั้งคู่ต่างก็อยากกลับบ้าน จนได้ค้นพบความลับว่ามีลูกแก้ววิเศษที่ทำให้ไม่จมน้ำ และให้เจ้าหนูไปขโมยลูกแก้ววิเศษนั้นมา แต่ทว่าเจ้าหนูกลับนำลูกแก้ววิเศษหนีลงทะเลซะเอง การไล่ล่าของเจ้าแมวและหนูกลางทะเลจึงเริ่มต้นขึ้น ส่วนเจ้าหมาตัดสินใจที่จะว่ายไปฝั่งข้างหน้า ในที่สุดเรี่ยวแรงจากการล่าและหนีก็ทำให้พวกมันจมลงสู่ทะเล และได้เกิดความมหัศจรรย์แห่งท้องทะเลขึ้น คือได้เกิดเกาะหนูซึ่งมีลักษณะเหมือนหนู และเกาะแมวที่มีลักษณะเหมือนแมว ส่วนเจ้าหมาขาดใจตายเมื่อว่ายถึงฝังกลายเป็นกลายเป็นเป็นเขาตังกวน และลูกแก้ววิเศษแตกละเอียดและถูกคลื่นซัดกลายเป็นหาดแก้วที่สวยงามในปัจจุบัน.'; // Thai story
  final String _storyEn =
      'Here s the translation of the legend of Koh Ngu (Mouse Island) and Koh Maew (Cat Island):The legend of Koh Ngu and Koh Maew, significant tourist attractions in Songkhla Province, tells the story of a time long ago when these islands had not yet formed. This area was once an important trading port with a thriving marketplace. A Chinese merchant brought a dog and a cat on his trading ship. Both animals longed to return home and discovered a secret: there was a magical pearl that prevented drowning. The cat sent the mouse to steal the magical pearl, but the mouse ended up dropping it into the sea instead.Thus began a chase between the cat and the mouse in the ocean, while the dog decided to swim towards the shore. Eventually, the exhaustion from the chase caused all of them to sink into the sea, leading to the miraculous emergence of the islands: Koh Ngu, shaped like a mouse, and Koh Maew, shaped like a cat. The dog, having died from exhaustion upon reaching the shore, became Tanguan Hill. The magical pearl shattered and was washed ashore by the waves, transforming into the beautiful Glass Beach we see today.'; // English story

  final List<Map<String, String>> _quizOptions = [
    {'value': ' island', 'label': 'Island เกาะ'},
    {'value': ' island', 'label': 'Island เกาะ'},
    {'value': ' island', 'label': 'Island เกาะ'},
  ];
  final List<String> _vocabularies = [
    'legend แปลว่า ตำนาน',
    'island แปลว่า เกาะ',
    'beautiful   แปลว่า สวย',
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
        ? 'legend แปลว่าอะไร?'
        : 'What does legend mean?';
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
                String message = _selectedAnimal == 'legend'
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
        _storyLanguage == 'th' ? 'sound/th4.mp3' : 'sound/en4.mp3';
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
        title: Text('นิทาน เกาะหนู เกาะแมว'), // แสดงชื่อเรื่องแทนโลโก้
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
                    Image.asset(
                        'assets/photo/4.jpg'), // Image path รูปนิทานเรื่อง เกาะหนู เกาะแมว
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'นิทานเรื่อง เกาะหนู เกาะแมว',
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
                            quiz4()), // เปลี่ยนไปยัง quiz1.dart
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
