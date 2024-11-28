import 'package:flutter/material.dart';

import 'webviewscreen.dart'; // สำหรับเปิด WebView

class home extends StatefulWidget {
  @override
  State<home> createState() => _HomePageState();
}

class _HomePageState extends State<home> {
  // Array สำหรับเก็บข้อมูลของ item
  final List<Map<String, String>> items = [
    {
      'text': 'นิทานเรื่องจระเข้สามพัน',
      'image': 'assets/photo/1.jpg',
      'route': '/fable1', // ลิงก์ไปที่ fable01()
    },
    {
      'text': 'นิทานเรื่องเศรษฐีกับยาจก',
      'image': 'assets/photo/2.jpg',
      'route': '/fable2',
    },
    {
      'text': 'นิทานเรื่องพญาคันคาก',
      'image': 'assets/photo/3.jpg',
      'route': '/fable3',
    },
    {
      'text': 'นิทานหมาจิ้งจอกตกบ่อ',
      'image': 'assets/photo/9.jpg',
      'route': '/fable04',
    },
  ];

  final List<Map<String, String>> items2 = [
    {
      'text': 'สาเหตุของการนอนไม่หลับ',
      'image': 'assets/photo/logo1.png',
      'url': 'https://www.premacare.co.th/%E0%B8%9A%E0%B8%97%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%E0%B8%AA%E0%B8%A3%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B9%81%E0%B8%9A%E0%B8%A3%E0%B8%99%E0%B8%94%E0%B9%8C%E0%B8%97%E0%B8%B3%E0%B9%81%E0%B8%9A%E0%B8%A3%E0%B8%99%E0%B8%94%E0%B9%8C/1/1019/5-%E0%B8%AA%E0%B8%B2%E0%B8%A3%E0%B8%AA%E0%B8%81%E0%B8%B1%E0%B8%94-%E0%B8%AA%E0%B8%A3%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B9%81%E0%B8%9A%E0%B8%A3%E0%B8%99%E0%B8%94%E0%B9%8C%E0%B8%AD%E0%B8%B2%E0%B8%AB%E0%B8%B2%E0%B8%A3%E0%B9%80%E0%B8%AA%E0%B8%A3%E0%B8%B4%E0%B8%A1%E0%B8%99%E0%B8%AD%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%9A',
    },
    {
      'text': 'เทคนิคการอ่านหนังสือ',
      'image': 'assets/photo/logo2.png',
      'url': 'https://plan.vru.ac.th/?p=5176',
    },
    {
      'text': 'การกินอาหารสำหรับเด็ก',
      'image': 'assets/photo/logo3.jpg',
      'url': 'https://eatwellconcept.com/2024/01/12/nutrition-for-mom-and-kids/',
    },
    {
      'text': 'การถนอมสายตา',
      'image': 'assets/photo/logo4.jpg',
      'url':
          'http://www.taradhealth.com/info/5-%E0%B8%A7%E0%B8%B4%E0%B8%98%E0%B8%B5%E0%B8%87%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%86-%E0%B8%96%E0%B8%99%E0%B8%AD%E0%B8%A1%E0%B8%AA%E0%B8%B2%E0%B8%A2%E0%B8%95%E0%B8%B2%E0%B8%88%E0%B8%B2%E0%B8%81/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFFB3E4FF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/photo/p1.jpg',
                  height: 200,
                  width: 350,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'นิทานแนะนำ',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 365, // กำหนดความสูงของ GridView
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // แสดง 2 คอลัมน์ต่อแถว
                  crossAxisSpacing: 20.0, // ระยะห่างระหว่างคอลัมน์
                  mainAxisSpacing: 10.0, // ระยะห่างระหว่างแถว
                  childAspectRatio:
                      1.3, // ปรับอัตราส่วนของ Card เพื่อให้พอดีกับข้อความ
                ),
                itemCount: items.length, // จำนวนรายการใน GridView
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      if (item.containsKey('route')) {
                        // นำทางไปยังหน้าตามที่กำหนดใน route
                        Navigator.pushNamed(context, item['route']!);
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // กำหนดมุมมนให้กับ Card
                      ),
                      color: const Color.fromARGB(
                          255, 173, 252, 248), // สีพื้นหลังของการ์ด
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(16), // มุมมนของรูปภาพ
                              child: Image.asset(
                                item['image']!, // แสดงรูปภาพจาก assets
                                fit: BoxFit.cover,
                                width: double.infinity, // ทำให้รูปพอดีกับ Card
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                                8.0), // เพิ่ม padding ให้ข้อความ
                            child: Text(
                              item['text']!,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center, // จัดให้อยู่ตรงกลาง
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, bottom: 8.0), // ปรับ padding
              child: Text(
                'คำแนะนำเพิ่มเติม',
                style: TextStyle(
                  fontSize: 24,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
            height: 450, // ปรับความสูงของ GridView ที่สองให้เท่ากับอันแรก
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // แสดง 2 คอลัมน์ต่อแถว
                  crossAxisSpacing: 10.0, // ระยะห่างระหว่างคอลัมน์
                  mainAxisSpacing: 10.0, // ระยะห่างระหว่างแถว
                  childAspectRatio: 1.1, // ปรับอัตราส่วนของ Card
                ),
                itemCount: items2.length,
                itemBuilder: (context, index) {
                  final item = items2[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              webviewscreen(url: item['url']!),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Card(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              16), // กำหนดมุมมนให้กับ Card
                        ),
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16), // กำหนดมุมมนให้กับ Card
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16), // ตัดมุมรูปภาพให้เป็นมุมมน
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .stretch, // ขยายให้เต็ม Card
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.1, // ปรับสัดส่วนรูปภาพให้พอดี
                                  child: Image.asset(
                                    item['image']!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover, // ให้ภาพขยายเต็ม Card
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
          ],
        ),
      ),
    );
  }
}
