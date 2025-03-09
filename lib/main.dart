import 'package:alquran_doa/screens/home_screen.dart';
import 'package:alquran_doa/screens/waktu_shalat_screen.dart';
import 'package:flutter/material.dart';
import 'package:alquran_doa/screens/doa_detail_screen.dart'; // Pastikan impor sudah benar
import 'package:alquran_doa/screens/surah_detail_screen.dart'; // Jika ada screen lain

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Quran & Doa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(), // Ganti dengan home screen Anda
        '/surah-detail': (context) => const SurahDetailScreen(),
        '/waktu_shalat': (context) => const WaktuShalatScreen(),
        '/doa-detail': (context) {
          // Ambil doaId dari arguments
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments != null && arguments is int) {
            return DoaDetailScreen(doaId: arguments);
          } else {
            // Handle error jika arguments tidak valid
            return Scaffold(
              body: Center(child: Text('ID Doa tidak valid')),
            );
          }
        },
      },
    );
  }
}