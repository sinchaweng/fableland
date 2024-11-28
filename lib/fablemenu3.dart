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
      home: fable3(),
    );
  }
}

//Class stateful เรียกใช้การท างานแบบโต้ตอบ (เรียกใช้ State)
class fable3 extends StatefulWidget {
  @override
  State<fable3> createState() => _MyHomePageState();
}

//class state เขียน Code ภาษา dart เพอื่รับค่าจากหนา้จอมาคา นวณและส่งคา่่กลบัไปแสดงผล
class _MyHomePageState extends State<fable3> {
  void _intialstate() {
    setState(() {});
  }
TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredPlaces = [];
  List<Map<String, dynamic>> places = [
    {
      'name': 'นิทาน เงือกน้อยผจญภัย',
      'sound': 'เสียงพากษ์ไทย/อังกฤษ',
      'imagelist': 'assets/photo/11.jpg',
      'route': '/fable001',
    },
    {
      'name': 'นิทาน เจ้าหญิงนิทรา',
      'sound': 'เสียงพากษ์ไทย/อังกฤษ',
      'imagelist': 'assets/photo/12.jpg',
      'route': '/fable002',
    },
    {
      'name': 'นิทาน โฉมงามกับเจ้าชายอสูร',
      'imagelist': 'assets/photo/13.jpg',
      'route': '/fable003',
    },
    {
      'name': 'นิทาน สโนว์ไวท์กับคนแคระทั้งเจ็ด',
      'sound': 'เสียงพากษ์ไทย/อังกฤษ',
      'imagelist': 'assets/photo/14.jpg',
      'route': '/fable004',
    },
    {
      'name': 'นิทาน นางฟ้ากับดวงดาว',
      'sound': 'เสียงพากษ์ไทย/อังกฤษ',
      'imagelist': 'assets/photo/15.jpg',
      'route': '/fable005',
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
                    'assets/photo/p4.jpg',
                    height: 200,
                    width: 350,
                    fit: BoxFit.fill,
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
                    'นิทานก่อนนอน',
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
                    'นิทานก่อนนอน โดยเล่านิทานให้เด็กฟังก่อนนอนเพื่อเตรียมเด็กให้พร้อมสำหรับการนอนหลับ',
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
                height: 300, // กำหนดความสูงให้กับ ListView เพื่อไม่ให้บีบตัว
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
            ]),
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
