import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ติดต่อเรา'),
        backgroundColor: Color.fromRGBO(175, 172, 255, 1),
      ),
      body: Container(
        color: Color.fromRGBO(58, 241, 248, 1), // ตั้งค่าสีฟ้า
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView(
              children: [
                ContactItem(
                  icon: Icons.message,
                  title: 'LINE',
                  detail: '@yourlineid',
                ),
                SizedBox(height: 10),
                ContactItem(
                  icon: Icons.phone,
                  title: 'เบอร์โทร',
                  detail: '012-345-6789',
                ),
                SizedBox(height: 10),
                ContactItem(
                  icon: Icons.email,
                  title: 'อีเมล์',
                  detail: 'info@yourdomain.com',
                ),
                SizedBox(height: 10),
                ContactItem(
                  icon: Icons.location_on,
                  title: 'ที่อยู่',
                  detail: '123/4 ถนนตัวอย่าง เขตตัวอย่าง กรุงเทพมหานคร 12345',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  ContactItem({required this.icon, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        subtitle: Text(detail, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
