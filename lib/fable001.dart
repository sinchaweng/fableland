import 'package:fableland_application/quiz001.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'contact.dart';
import 'quiz001.dart';

class fable0001 extends StatefulWidget {
  const fable0001({Key? key}) : super(key: key);

  @override
  _FablePageState createState() => _FablePageState();
}

class _FablePageState extends State<fable0001> {
  String _storyLanguage = 'th'; // 'th' for Thai, 'en' for English
  String _comment = '';
  String? _selectedAnimal; // For Radio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  final String _storyTh =
      'ในท้องทะเลอันไกลโพ้น ราชาไทรตันมีลูกสาว 7 คน นางเงือกน้อยคนสุดท้องเฝ้ารอคอยวันว่ายขึ้นผิวน้ำเพื่อพบกับมนุษย์ เมื่ออายุครบ 15 ปี เธอได้เห็นเรือที่เต็มไปด้วยมนุษย์และเจ้าชายรูปงาม แต่เกิดพายุทำให้เรือพลิกคว่ำ เธอจึงช่วยเจ้าชายขึ้นฝั่งและตกหลุมรักเขาเมื่อนางเงือกน้อยได้ยินเสียงพี่สาวพูดถึงมนุษย์ เธอจึงไปหาแม่มดแห่งท้องทะเลเพื่อขอมีขาแบบมนุษย์ แลกกับเสียงของเธอ นางเงือกน้อยตกลง แม้จะรู้ว่าถ้าเจ้าชายแต่งงานกับคนอื่น เธอจะต้องตายเมื่อเธอได้ขาแล้ว เจ้าชายพาเธอไปที่ปราสาท แต่เขายังคงนึกถึงเสียงที่ช่วยชีวิตเขา วันต่อมา เจ้าชายได้รับข่าวว่าจะต้องแต่งงานกับเจ้าหญิง และนางเงือกน้อยรู้ว่าจะเกิดอะไรขึ้นพี่สาวของเธอได้ตัดผมและแลกมีดกับแม่มดเพื่อให้เธอไปฆ่าเจ้าหญิง แต่เธอไม่ทำ  เจ้าชายและเจ้าหญิงจัดงานแต่งงาน ขณะที่แม่มดแปลงร่างเป็นอสุรกาย นางเงือกน้อยปกป้องเจ้าชายและเจ้าสาว จนแม่มดบาดเจ็บและจมลงสู่ทะเลเสียงของนางเงือกน้อยกลับมา เจ้าชายรู้ว่าเธอคือคนที่เขารัก ทั้งคู่แต่งงานบนเรือท่ามกลางความยินดีของทุกคน และได้ครองรักกันอย่างมีความสุขสืบไป'; // Thai story
  final String _storyEn =
      'In a distant ocean, King Triton had seven daughters. The youngest mermaid eagerly awaited the day she could swim to the surface and meet humans. When she turned 15, she saw a ship filled with people and a handsome prince. However, a storm struck, causing the ship to capsize. She saved the prince and fell in love with him.Curious about humans, the little mermaid sought out the sea witch to trade her voice for human legs. She agreed, knowing that if the prince married someone else, she would die.Once she had legs, the prince took her to his castle, but he still thought of the voice that had saved him. The next day, the prince learned he would have to marry a princess, and the little mermaid realized what that meant.Her sisters cut their hair and traded it with the sea witch for a dagger, hoping the little mermaid would kill the princess. But she couldn t bring herself to do it. As the prince and princess prepared for their wedding, the sea witch transformed into a monstrous creature. The little mermaid defended the prince and the bride, causing the witch to be injured and sink into the sea.The little mermaids voice returned, and the prince realized she was the one he truly loved. They married on the ship amid the joy of everyone and lived happily ever after'; // English story

  final List<Map<String, String>> _quizOptions = [
    {'value': 'ocean', 'label': 'มหาสมุทร'},
    {'value': 'mermaid', 'label': 'นางเงือก'},
    {'value': 'ship', 'label': 'เรือ'},
  ];

  // คำศัพท์ที่ได้จากเรื่องนี้
  final List<String> _vocabularies = [
    'ocean แปลว่า มหาสมุทร',
    'mermaid แปลว่า นางเงือก',
    'ship แปลว่า เรือ',
  ];

  void _submitComment() {
    String thankYouMessage = _storyLanguage == 'th'
        ? 'ขอบคุณที่ตั้งใจฟัง'
        : 'Thank you for your attention';
    _showDialog(
        _storyLanguage == 'th' ? 'ขอบคุณ!' : 'Thank You!', thankYouMessage);
  }

  void _showQuiz() {
    String question =
        _storyLanguage == 'th' ? 'ocean แปลว่าอะไร?' : 'What does ocean mean?';
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
                String message = _selectedAnimal == 'ocean'
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
        _storyLanguage == 'th' ? 'sound/th001.mp3' : 'sound/en001.mp3';
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
    // Implement rewind logic
  }

  Future<void> _forwardAudio() async {
    // Implement forward logic
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
        title: Text('นิทาน เงือกน้อยผจญภัย'),
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
                    Image.asset('assets/photo/11.jpg'), // Image path
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'นิทานเงือกน้อยผจญภัย',
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
                    onPressed: _isPlaying ? _pauseAudio : _playAudio,
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
                  backgroundColor: Color.fromRGBO(175, 172, 255, 1),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                    _storyLanguage == 'th' ? 'ส่งข้อคิด' : 'Submit Thoughts'),
              ),
              SizedBox(height: 10),

              // Vocabulary section with a border
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

              // Quiz button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            quiz001()), // เปลี่ยนไปยัง quiz1.dart
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
