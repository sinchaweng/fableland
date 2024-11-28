import 'package:fableland_application/quiz5.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'contact.dart'; // เพิ่มการนำเข้า ContactUs
import 'quiz05.dart';

class fable05 extends StatefulWidget {
  const fable05({Key? key}) : super(key: key);

  @override
  _FablePageState createState() => _FablePageState();
}

class _FablePageState extends State<fable05> {
  String _storyLanguage = 'th'; // 'th' for Thai, 'en' for English
  String _comment = '';
  String? _selectedAnimal; // For Radio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;

  final String _storyTh =
      'ลูกชายที่ออกไปทำนาวันหนึ่งเขาออกไปทำนาตั้งแต่เช้ามืด   รออยู่จนสายไม่เห็นแม่นำข้าวมาส่งทำให้เขารู้สึกหงุดหงิดเพราะหิวจนแสบท้อง แม่เห็นแม่ถือกล่องข้าวเดินมาแต่ไกล ก็รีบลุกตรงเข้าไปต่อว่าทันที ด้วยความหิวจึงทำให้ลืมตัวว่าคนที่ต่อว่าอยู่นั่นคือแม่ตัวเอง และไม่สนใจเหตุผลที่แม่อธิบาย และทำร้ายแม่เพราะมองเห็นว่าข้าวที่แม่นำมาให้ในกล่องนั่นน้อยนิดเดียว และรีบเปิดกล่องข้าวกินอย่างหิวโหย  เมื่อกินอิ่มแล้วจึงรู้ว่าข้าวในกล่องยังเหลืออีกตั้งมาก และมองเห็นแม่ที่นอนแน่นิ่ง ปรากฏว่าแม่ได้สิ้นใจด้วยน้ำมือลูกไปแล้ว ชายหนุ่มจึงสำนึกตัวได้ว่าตนเองทำรุนแรงกับแม่ กอดศพแม่ร้องไห้รำพัน และได้สร้างพระธาตุเจดีย์ขึ้นมากลางท้องนาเป็นรูปลักษณะคล้ายกล่องข้าว เพื่ออุทิศส่วนกุศลและใส่กระดูกของแม่ ทุกวันนี้ธาตุกล่องข้าวน้อยฆ่าแม่ได้ตั้งอยู่ที่จังหวัดยโสธรนั่นเอง'; // Thai story
  final String _storyEn =
      'Once, a son went out to work in the rice field from early morning. He waited until late morning but did not see his mother bringing food, which made him feel frustrated and hungry. When he finally spotted his mother approaching from a distance with a food container, he rushed over to scold her immediately. His hunger made him forget that he was scolding his own mother, and he ignored her explanations. In his frustration, he mistreated her, viewing the small amount of rice she brought as insufficient. He hastily opened the container and ate greedily.After satisfying his hunger, he realized there was still plenty of rice left in the container. However, he noticed that his mother lay still on the ground. It turned out that she had passed away due to his actions. The young man then came to understand the gravity of what he had done to his mother. He embraced her lifeless body and wept sorrowfully.In memory of her, he built a pagoda in the rice field resembling a food container to dedicate merit and to place his mothers bones inside. Today, the "Rice Container Relic" stands in Yasothon Province, serving as a reminder of his tragic mistake.'; // English story

  final List<Map<String, String>> _quizOptions = [
    {'value': 'son', 'label': 'Son ลูกชาย'},
    {'value': 'son', 'label': 'Son ลูกชาย'},
    {'value': 'son', 'label': 'Son ลูกชาย'},
  ];
  final List<String> _vocabularies = [
    'son แปลว่า ลูกชาย',
    'rice แปลว่า ข้าว',
    'hunger  แปลว่า ความหิว',
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
        _storyLanguage == 'th' ? 'rice แปลว่าอะไร?' : 'What does rice mean?';
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
                String message = _selectedAnimal == 'rice'
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
        _storyLanguage == 'th' ? 'sound/th5.mp3' : 'sound/en5.mp3';
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
        title: Text('นิทาน กล่องข้าวน้อยฆ่าแม่'), // แสดงชื่อเรื่องแทนโลโก้
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
                        'assets/photo/5.jpg'), // Image path ..รูปนิทานเรื่อง กล่องข้าวน้อยฆ่าแม่..
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'นิทานเรื่อง กล่องข้าวน้อยฆ่าแม่',
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
                            quiz5()), // เปลี่ยนไปยัง quiz1.dart
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
