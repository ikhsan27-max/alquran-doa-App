import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  // Fungsi untuk membuka URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Pengembang",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto Profil
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.jpeg'), // Ganti dengan foto pengembang
              ),
              const SizedBox(height: 12),

              // Nama
              Text(
                "Nama Pengembang",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              // Deskripsi Singkat
              Text(
                "Flutter Developer | Mobile Enthusiast",
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),

              // Info Kontak
              _buildContactButton(
                icon: Icons.email,
                label: "Email",
                url: "mailto:developer@email.com",
              ),
              _buildContactButton(
                icon: Icons.link,
                label: "LinkedIn",
                url: "https://linkedin.com/in/developer",
              ),
              _buildContactButton(
                icon: Icons.code,
                label: "GitHub",
                url: "https://github.com/developer",
              ),

              const SizedBox(height: 20),

              // Tombol Kembali
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  "Kembali",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk tombol kontak
  Widget _buildContactButton({required IconData icon, required String label, required String url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton.icon(
        onPressed: () => _launchURL(url),
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
