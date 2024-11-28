import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(quiz03());
}

class quiz03 extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<quiz03> {
  List<Map<String, dynamic>> questions = [
    {
      'question': 'mother แปลว่าอะไร?',
      'options': [
        'แม่',
        'หมู',
        'หมาป่า',
      ],
      'answer': 'แม่',
    },
    {
      'question': 'pig แปลว่าอะไร?',
      'options': [
        'แม่',
        'หมู',
        'หมาป่า',
      ],
      'answer': 'หมู',
    },
    {
      'question': 'wolf แปลว่าอะไร?',
      'options': [
        'แม่',
        'หมู',
        'หมาป่า',
      ],
      'answer': 'หมาป่า',
    },
  ];

  List<int> questionIndexes = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;

  Timer? _timer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    _startQuiz();
  }

  void _startQuiz() {
    questionIndexes = List<int>.generate(questions.length, (index) => index);
    questionIndexes.shuffle();

    score = 0;
    _secondsRemaining = 60;
    quizCompleted = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _completeQuiz();
        }
      });
    });

    currentQuestionIndex = 0;
  }

  void _nextQuestion(String selectedOption) {
    if (selectedOption ==
        questions[questionIndexes[currentQuestionIndex]]['answer']) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _completeQuiz();
    }
  }

  void _completeQuiz() {
    _timer?.cancel();
    setState(() {
      quizCompleted = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (quizCompleted) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ท่านทำแบบทดสอบเสร็จสิ้นแล้ว"),
          backgroundColor: Color.fromRGBO(175, 172, 255, 1),
        ),
        body: Container(
          color: const Color.fromARGB(255, 173, 252, 248),
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('คะแนนทั้งหมดที่ทำได้: $score/${questions.length}',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('เวลาที่ใช้ไป: ${60 - _secondsRemaining} วินาที',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _startQuiz();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromRGBO(175, 172, 255, 1), // เปลี่ยนสีที่นี่
                  ),
                  child: Text('เริ่มทำแบบทดสอบใหม่'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    var currentQuestion = questions[questionIndexes[currentQuestionIndex]];

    return Scaffold(
      appBar: AppBar(
        title: Text("แบบทดสอบ"),
        backgroundColor: Color.fromRGBO(175, 172, 255, 1),
      ),
      body: Container(
        color: const Color.fromARGB(255, 173, 252, 248),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                'จำนวนข้อคำถาม ${currentQuestionIndex + 1}/${questions.length}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(currentQuestion['question'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ...currentQuestion['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => _nextQuestion(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(175, 172, 255, 1),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
            Spacer(),
            Text('เวลาคงเหลือ: $_secondsRemaining วินาที',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
