import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaktuShalatScreen extends StatelessWidget {
  const WaktuShalatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Kembali',
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 21, 16, 59), // Ungu atas
              Color.fromARGB(255, 17, 13, 44), // Ungu bawah lebih gelap
            ],
          ),
        ),
        child: Column(
          children: [
            // Bagian atas dengan gambar background
            Stack(
              children: [
                Container(
                  height: 250, // Menentukan tinggi area background
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bgimage.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        "Jadwal Sholat",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 100),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Yang membedakan antara orang beriman dengan tidak beriman adalah meninggalkan salat.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildPrayerTimeRow(Icons.nightlight_round, "Subuh", "04:37 AM"),
                    _buildPrayerTimeRow(Icons.wb_sunny_outlined, "Terbit", "05:53 AM"),
                    _buildPrayerTimeRow(Icons.wb_sunny, "Dhuha", "06:15 AM"),
                    _buildPrayerTimeRow(Icons.wb_sunny, "Zuhur", "12:02 PM"),
                    _buildPrayerTimeRow(Icons.wb_twilight, "Asar", "15:07 PM"),
                    _buildPrayerTimeRow(Icons.nights_stay_outlined, "Maghrib", "18:08 PM"),
                    _buildPrayerTimeRow(Icons.nightlight_round, "Isya", "19:17 PM"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimeRow(IconData icon, String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}