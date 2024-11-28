import 'package:flutter/material.dart';
import 'webviewscreen.dart';

//Method หลักทีRun
void main() {
  runApp(MyApp());
}

//Class state less สงั่ แสดงผลหนา้จอ
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '...',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(239, 245, 188, 2)),
        useMaterial3: true,
      ),
      home: fable4(),
    );
  }
}

//Class stateful เรียกใช้การท างานแบบโต้ตอบ (เรียกใช้ State)
class fable4 extends StatefulWidget {
  @override
  State<fable4> createState() => _MyHomePageState();
}

//class state เขียน Code ภาษา dart เพอื่รับค่าจากหนา้จอมาคา นวณและส่งคา่่กลบัไปแสดงผล
class _MyHomePageState extends State<fable4> {
  void _intialstate() {
    setState(() {});
  }

  final List<Map<String, String>> items = [
    //เปลี่ยนรูปนิทานพื้นบ้าน
    {
      'text': 'นิทาน จระเข้สามพัน',
      'image': 'assets/photo/1.jpg',
      'route': '/fable1', // ลิงก์ไปที่ fable01()
    },
    {
      'text': 'นิทาน เศรษฐีกับยาจก',
      'image': 'assets/photo/2.jpg',
      'route': '/fable2',
    },
    {
      'text': 'นิทาน พญาคันคาก',
      'image': 'assets/photo/3.jpg',
      'route': '/fable3',
    },
    {
      'text': 'นิทาน เกาะหนู เกาะแมว',
      'image': 'assets/photo/4.jpg',
      'route': '/fable4',
    },
    {
      'text': 'นิทาน กล่องข้าวน้อยฆ่าแม่',
      'image': 'assets/photo/5.jpg',
      'route': '/fable5',
    },
  ];
  final List<Map<String, String>> items1 = [
    //เปลี่ยนรูปนิทานคติสอนใจ
    {
      'text': 'นิทานอีสป กระต่ายกับเต่า',
      'image': 'assets/photo/6.jpg',
      'route': '/fable01', // ลิงก์ไปที่ fable01()
    },
    {
      'text': 'นิทานอีสป ราชสีห์กับหนู',
      'image': 'assets/photo/7.jpg',
      'route': '/fable02',
    },
    {
      'text': 'นิทานอีสป ลูกหมูสามตัว',
      'image': 'assets/photo/8.jpg',
      'route': '/fable03',
    },
    {
      'text': 'นิทานอีสป หมาจิ้งจอกตกบ่อ',
      'image': 'assets/photo/9.jpg',
      'route': '/fable04',
    },
    {
      'text': 'นิทานอีสป หมากับเงา',
      'image': 'assets/photo/10.jpg',
      'route': '/fable05',
    },
  ];
  final List<Map<String, String>> items2 = [
    //เปลี่ยนรูปนิทานก่อนนอน
    {
      'text': 'นิทาน เงือกน้อยผจญภัย',
      'image': 'assets/photo/11.jpg',
      'route': '/fable001', // ลิงก์ไปที่ fable01()
    },
    {
      'text': 'นิทาน เจ้าหญิงนิทรา',
      'image': 'assets/photo/12.jpg',
      'route': '/fable002',
    },
    {
      'text': 'นิทาน โฉมงามกับเจ้าชายอสูร',
      'image': 'assets/photo/13.jpg',
      'route': '/fable003',
    },
    {
      'text': 'นิทาน สโนว์ไวท์กับคนแคระทั้งเจ็ด',
      'image': 'assets/photo/14.jpg',
      'route': '/fable004',
    },
    {
      'text': 'นิทาน นางฟ้ากับดวงดาว',
      'image': 'assets/photo/15.jpg',
      'route': '/fable005',
    },
  ];
  final List<Map<String, String>> items3 = [
    //เปลี่ยนรูปลิงก์คำแนะนำเพิ่มเติม
    {
      'text': 'เทคนิคการจำ',
      'image': 'assets/photo/logo5.jpg',
      'url': 'https://www.ignitethailand.org/content/5026/ignite',
    },
    {
      'text': 'เทคนิคการฝึกสมอง',
      'image': 'assets/photo/logo6.jpg',
      'url': 'https://swimmingkidsthailand.com/articles-tips/7-tips-to-boost-your-baby-brain-development/',
    },
    {
      'text': 'การดูแลสุขภาพ',
      'image': 'assets/photo/logo7.jpg',
      'url':
          'https://www.saithongherb.com/content/5670/%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%94%E0%B8%B9%E0%B9%81%E0%B8%A5%E0%B8%AA%E0%B8%B8%E0%B8%82%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B9%81%E0%B8%9A%E0%B8%9A%E0%B8%AD%E0%B8%87%E0%B8%84%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1',
    },
    {
      'text': 'การสมาธิ',
      'image': 'assets/photo/logo8.jpg',
      'url': 'https://wealthmeup.com/22-06-09-millimove/',
    },
  ];
  @override
//ส่วนออกแบบหนา้จอ
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Color(0xFFB3E4FF),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft, // จัดข้อความชิดซ้าย
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // ปรับระยะห่างขอบซ้าย-ขวา
              child: Text(
                'นิทานพื้นบ้าน',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150, // กำหนดความสูงของ GridView
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.5,
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
                  child: SizedBox(
                    // ใช้ SizedBox เพื่อกำหนดขนาดของ Card
                    width: 50, // กำหนดความกว้างของ Card (ปรับตามที่ต้องการ)
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // กำหนดมุมมนให้กับ Card
                      ),
                      color: const Color.fromARGB(
                          255, 94, 255, 201), // สีพื้นหลังของการ์ด
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            16), // ตัดมุมรูปภาพให้เป็นมุมมน
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              item['image']!, // แสดงรูปภาพจาก assets
                              height: 142,
                              width: 92,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft, // จัดข้อความชิดซ้าย
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // ปรับระยะห่างขอบซ้าย-ขวา
              child: Text(
                'นิทานคติสอนใจ',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150, // กำหนดความสูงของ GridView
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.5,
              ),
              itemCount: items1.length, // จำนวนรายการใน GridView
              itemBuilder: (context, index) {
                final item = items1[index];
                return GestureDetector(
                  onTap: () {
                    if (item.containsKey('route')) {
                      // นำทางไปยังหน้าตามที่กำหนดใน route
                      Navigator.pushNamed(context, item['route']!);
                    }
                  },
                  child: SizedBox(
                    // ใช้ SizedBox เพื่อกำหนดขนาดของ Card
                    width: 50, // กำหนดความกว้างของ Card (ปรับตามที่ต้องการ)
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // กำหนดมุมมนให้กับ Card
                      ),
                      color: const Color.fromARGB(
                          255, 94, 255, 201), // สีพื้นหลังของการ์ด
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            16), // ตัดมุมรูปภาพให้เป็นมุมมน
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              item['image']!, // แสดงรูปภาพจาก assets
                              height: 142,
                              width: 92,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft, // จัดข้อความชิดซ้าย
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // ปรับระยะห่างขอบซ้าย-ขวา
              child: Text(
                'นิทานก่อนนอน',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150, // กำหนดความสูงของ GridView
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.5,
              ),
              itemCount: items2.length, // จำนวนรายการใน GridView
              itemBuilder: (context, index) {
                final item = items2[index];
                return GestureDetector(
                  onTap: () {
                    if (item.containsKey('route')) {
                      // นำทางไปยังหน้าตามที่กำหนดใน route
                      Navigator.pushNamed(context, item['route']!);
                    }
                  },
                  child: SizedBox(
                    // ใช้ SizedBox เพื่อกำหนดขนาดของ Card
                    width: 50, // กำหนดความกว้างของ Card (ปรับตามที่ต้องการ)
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // กำหนดมุมมนให้กับ Card
                      ),
                      color: const Color.fromARGB(
                          255, 94, 255, 201), // สีพื้นหลังของการ์ด
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            16), // ตัดมุมรูปภาพให้เป็นมุมมน
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              item['image']!, // แสดงรูปภาพจาก assets
                              height: 142,
                              width: 92,
                              fit: BoxFit.cover,
                            ),
                            //SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft, // จัดข้อความชิดซ้าย
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // ปรับระยะห่างขอบซ้าย-ขวา
              child: Text(
                'คำแนะนำเพิ่มเติม',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 450, // ปรับความสูงของ GridView ที่สองให้เท่ากับอันแรก
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // แสดง 2 คอลัมน์ต่อแถว
                  crossAxisSpacing: 10.0, // ระยะห่างระหว่างคอลัมน์
                  mainAxisSpacing: 10.0, // ระยะห่างระหว่างแถว
                  childAspectRatio: 1.1, // ปรับอัตราส่วนของ Card
                ),
                itemCount: items3.length,
                itemBuilder: (context, index) {
                  final item = items3[index];
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
        ]),
      ),
    );
  }
}
