import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/waktu_shalat_screen.dart';

class WaktuShalatButton extends StatefulWidget {
  @override
  _WaktuShalatButtonState createState() => _WaktuShalatButtonState();
}

class _WaktuShalatButtonState extends State<WaktuShalatButton> {
  int _index = 0;
  late Timer _timer;

  // List waktu shalat yang akan ditampilkan
  final List<Map<String, String>> _waktuShalat = [
    {"nama": "Subuh", "waktu": "04:37 AM"},
    {"nama": "Terbit", "waktu": "05:53 AM"},
    {"nama": "Dhuha", "waktu": "06:15 AM"},
    {"nama": "Zuhur", "waktu": "12:02 PM"},
    {"nama": "asar", "waktu": "15:07 PM"},
    {"nama": "maghrib", "waktu": "18:08 PM"},
    {"nama": "isya", "waktu": "19:17 PM"},
  ];

  @override
  void initState() {
    super.initState();

    // Timer untuk mengganti teks setiap 3 detik
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _index = (_index + 1) % _waktuShalat.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hentikan timer saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WaktuShalatScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "${_waktuShalat[_index]["nama"]}  ${_waktuShalat[_index]["waktu"]}",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
