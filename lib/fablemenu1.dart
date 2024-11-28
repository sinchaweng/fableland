import 'package:flutter/material.dart';

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
      home: fable1(),
    );
  }
}

//Class stateful เรียกใช้การท างานแบบโต้ตอบ (เรียกใช้ State)
class fable1 extends StatefulWidget {
  @override
  State<fable1> createState() => _MyHomePageState();
}

//class state เขียน Code ภาษา dart เพอื่รับค่าจากหนา้จอมาคา นวณและส่งคา่่กลบัไปแสดงผล
class _MyHomePageState extends State<fable1> {
  void _intialstate() {
    setState(() {});
  }
TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredPlaces = [];
  List<Map<String, dynamic>> places = [
    {
      'name': 'นิทาน จระเข้สามพัน',
      'sound': 'เสียงพากษ์ไทย/อังกฤษ',
      'imagelist': 'assets/photo/1.jpg',
      'route': '/fable1',
    },
    {
      'name': 'นิทาน เศรษฐีกับยาจก',
      'sound': 'เสียงพากษ์ไทย/อังกฤษ',
      'imagelist': 'assets/photo/2.jpg',
      'route': '/fable2',
    },
    {
      'name': 'นิทาน พญาคันคาก',
      'imagelist': 'assets/photo/3.jpg',
      'route': '/fable3',
    },
    {
      'name': 'นิทาน เกาะหนู เกาะแมว',
      'sound': 'เสียงพากษ์ไทย/อังกฤษ',
      'imagelist': 'assets/photo/4.jpg',
      'route': '/fable4',
    },
    {
      'name': 'นิทาน กล่องข้าวน้อยฆ่าแม่',
      'sound': 'เสียงพากษ์ไทย/อังกฤษ',
      'imagelist': 'assets/photo/5.jpg',
      'route': '/fable5',
    },
  ];
void filterPlaces() {
    setState(() {
      _filteredPlaces = places
          .where((place) => place['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void initState() {
    super.initState();
    _filteredPlaces = places;
    _searchController.addListener(() {
      filterPlaces();
    });
  }
  @override
//ส่วนออกแบบหนา้จอ
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false, // This will remove the back arrow
         backgroundColor: Color(0xFFAFAFFF), // Original app bar color
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style:
                  TextStyle(color: const Color.fromARGB(255, 0, 0, 0)), // เปลี่ยนสีตัวหนังสือที่พิมพ์
              decoration: InputDecoration(
                hintText: 'พิมพ์เพื่อค้นหา...',
                hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)), // เปลี่ยนสี hintText
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
        ),
      ),
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
                  'assets/photo/p2.jpg',
                  height: 200,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft, // จัดข้อความชิดซ้าย
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0), // ปรับระยะห่างขอบซ้าย-ขวา
                child: Text(
                  'นิทานพื้นบ้าน คือ เรื่องที่เล่ากันต่อๆ มาจากคนรุ่นหนึ่งสู่คนอีกรุ่นหนึ่งโดยที่ไม่ทราบว่า ใครเป็นผู้แต่ง บางครั้งก็แพร่กระจายจากท้องถิ่นหนึ่งไปสู่อีกท้องถิ่นหนึ่ง ',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // ใส่ ListView.builder ตรงนี้
            SizedBox(
              height: 200, // กำหนดความสูงให้กับ ListView เพื่อไม่ให้บีบตัว
              child: ListView.builder(
                itemCount: _filteredPlaces.length,
                itemBuilder: (context, index) {
                  final place = _filteredPlaces[index];
                  return Card(
                    color: const Color.fromARGB(
                        255, 173, 252, 248), // สีพื้นหลังของ Card
                    elevation: 2.0, // ความนูน
                    shape: RoundedRectangleBorder(
                      // ความโค้งของมุม
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      height: 100, // เพิ่มความสูงของแต่ละ item
                      child: ListTile(
                        title: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 80,
                              child: Image.asset(
                                place['imagelist'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                                width:
                                    15), // เพิ่มระยะห่างระหว่างรูปภาพและข้อความ
                            Text(place['name']),
                          ],
                        ),
                        onTap: () {
                          if (place.containsKey('route')) {
                            // นำทางไปยังหน้าตามที่กำหนดใน route
                            Navigator.pushNamed(context, place['route']!);
                          }
                          //เมื่อกดที่ listview แล้วให้ขึ้นรายละเอียดต่างหรือไปหน้าอื่น ๆ
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CustomSearchDelegate extends SearchDelegate {
  final TextEditingController searchController;
  CustomSearchDelegate(this.searchController);
  @override
  List<Widget> buildActions(BuildContext context) {
// ปุ่ มสําหรับล้างข้อความการค้นหา
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // ล้างการค้นหา
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
// ปุ่ มย้อนกลับ
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // ปิ ดการค้นหา
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
// ผลลัพธ์การค้นหา (สามารถปรับปรุงได้ตามที่ต้องการ)
    return ListTile(
      title: Text('ผลลัพธ์การค้นหา: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
// ข้อเสนอแนะในการค้นหา (สามารถปรับปรุงได้ตามที่ต้องการ)
    return ListView(
      children: [
        ListTile(
          title: Text('ค้นหา: $query'),
        ),
      ],
    );
  }
}