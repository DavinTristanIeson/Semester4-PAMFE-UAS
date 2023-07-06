import 'package:flutter/material.dart';

void main() {
  runApp(AboutUsApp());
}

class AboutUsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEMOIR'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Set crossAxisAlignment to center
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Memoir adalah aplikasi flashcard yang diperuntukan untuk memudahkan penghafalan materi secara efektif, Memoir dibangun oleh kelompok kami yang berisi 3 orang yaitu Davin Tristan Ieson, Jansen Loman, Vincent Tandera. Tujuan dari pembuatan aplikasi ini adalah memudahkan para user untuk menghapal tanpa perlu lagi mencari materi hapalan dari sumber sumber yang terlalu banyak untuk di cari ataupun dibaca dan bisa menghapal dimanapun dan kapanpun dan juga kami ingin memiliki nilai Ujian Akhir Semester yang baik',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
