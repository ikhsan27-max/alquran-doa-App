  import 'package:alquran_doa/screens/profile_screen.dart';
import 'package:flutter/material.dart';
  import 'package:alquran_doa/models/surah_model.dart';
  import 'package:alquran_doa/models/doa.model.dart';
  import 'package:alquran_doa/services/api_service.dart';
  import 'package:alquran_doa/widgets/surah_card.dart';
  import 'package:alquran_doa/widgets/doa_card.dart'; // Tambahkan import untuk DoaCard
  import 'package:alquran_doa/widgets/shimmer_loading.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:intl/intl.dart';
  import '../widgets/waktu_shalat__button.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Surah>> surahs;
  late Future<List<Doa>> doas;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentTime = '';
  bool _showSurat = true; 
  bool _showDoa = false;

  @override
  void initState() {
    super.initState();
    surahs = ApiService.getRandomSurahs(5);
    doas = ApiService.getAllDoas();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('HH:mm').format(DateTime.now());
    });
    Future.delayed(const Duration(minutes: 1), _updateTime);
  }

  void _onSuratPressed() {
    setState(() {
      _showSurat = true;
      _showDoa = false;
    });
  }

  void _onDoaPressed() {
    setState(() {
      _showSurat = false;
      _showDoa = true;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    key: _scaffoldKey,
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(Icons.person, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
        ),
      ],
    ),
    body: RefreshIndicator(
      color: const Color(0xFF1E3A8A),
      onRefresh: () async {
        setState(() {
          surahs = ApiService.getAllSurahs();
          doas = ApiService.getAllDoas();
        });
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quran & Doa",
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Text(
                            "Kumpulan Al-Quran & Doa Harian",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _currentTime,
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Ramadan 23, 1444 AH",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          WaktuShalatButton(),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/image.png',
                      width: 235,
                      height: 280,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),

                const SizedBox(height: 40), //untuk jarak nya
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kategori",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildCategoryCard(
                          title: "SURAT",
                          isActive: _showSurat,
                          onTap: _onSuratPressed,
                        ),
                        SizedBox(width: 10,),
                        _buildCategoryCard(
                          title: "Doa",
                          isActive: _showDoa,
                          onTap: _onDoaPressed,
                        ),
                      ],
                    ),
                    ],
                  ),
                ),

                
                const SizedBox(height: 20),
                if (_showSurat) _buildSuratList(),
                if (_showDoa) _buildDoaList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

            Widget _buildCategoryCard({
        required String title,
        required bool isActive,
        required VoidCallback onTap,
      }) {
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2, // Lebar tombol 30% dari layar
            padding: const EdgeInsets.symmetric(vertical: 12), // Sesuaikan padding
            decoration: BoxDecoration(
              color: isActive ? Colors.purple : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: isActive 
                  ? null 
                  : Border.all(color: Colors.black, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      }

    Widget _buildSuratList() {
      return FutureBuilder<List<Surah>>(
        future: surahs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerLoading();
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Terjadi kesalahan saat memuat data',
                    style: GoogleFonts.poppins(color: Colors.red.shade800),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        surahs = ApiService.getAllSurahs();
                      });
                    },
                    child: const Text("Coba Lagi"),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue, size: 48),
                  const SizedBox(height: 16),
                  Text('Tidak ada data tersedia', style: GoogleFonts.poppins()),
                ],
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(color: Colors.grey.shade200, height: 1),
                itemBuilder: (context, index) {
                  final surah = snapshot.data![index];
                  return SurahCard(surah: surah);
                },
              ),
            );
          }
        },
      );
    }

    Widget _buildDoaList() {
      return FutureBuilder<List<Doa>>(
        future: doas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerLoading();
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Terjadi kesalahan saat memuat data Doa',
                    style: GoogleFonts.poppins(color: Colors.red.shade800),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        doas = ApiService.getAllDoas();
                      });
                    },
                    child: const Text("Coba Lagi"),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Tidak ada data Doa tersedia',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey.shade200, height: 1),
                itemBuilder: (context, index) {
                  final doa = snapshot.data![index];
                  return DoaCard(doa: doa); // Menggunakan DoaCard untuk masing-masing doa
                },
              ),
            );
          }
        },
      );
    }
  }