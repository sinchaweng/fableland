import 'package:fableland_application/fable1.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'fablemenu1.dart';
import 'fablemenu2.dart';
import 'fablemenu3.dart';
import 'fablemenu4.dart';
import 'contact.dart'; // ตรวจสอบว่ามีการนำเข้า ContactUs

// Method หลักที่ Run
void main() {
  runApp(MyApp());
}

// Class state less สั่งแสดงผลหน้าจอ
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fableland Application',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(239, 245, 188, 2)),
        useMaterial3: true,
      ),
      home: menu(),
    );
  }
}

// Class stateful เรียกใช้การทำงานแบบโต้ตอบ (เรียกใช้ State)
class menu extends StatefulWidget {
  @override
  State<menu> createState() => _MyHomePageState();
}

// Class state เขียน Code ภาษา Dart เพื่อติดต่อหน้าจอ
class _MyHomePageState extends State<menu> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    home(),
    fable1(),
    fable2(),
    fable3(),
    fable4(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // กำหนดค่า index ที่เลือก
    });
  }

  void _showContactUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactUs()), // แสดงหน้าติดต่อเรา
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAFAFFF),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.asset('assets/photo/logo.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.contact_mail),
            onPressed: _showContactUs, // ไปที่หน้าติดต่อเรา
          ),
        ],
      ),
      body: _screens[_currentIndex], // แสดงหน้าจอที่ถูกเลือกตามค่าในอาร์เรย์
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // ลำดับของแท็บที่ถูกเลือก
        onTap: _onTabTapped, // ฟังก์ชันที่เรียกเมื่อกดแต่ละแท็บ
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'นิทานพื้นบ้าน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'นิทานคติสอนใจ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bed),
            label: 'นิทานก่อนอน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'รวมนิทาน',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(175, 172, 255, 100),
        selectedItemColor: const Color.fromARGB(255, 63, 63, 63),
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
