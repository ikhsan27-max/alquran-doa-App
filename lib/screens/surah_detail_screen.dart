import 'package:flutter/material.dart';
import 'package:alquran_doa/models/surah_model.dart';
import 'package:alquran_doa/services/api_service.dart';
import 'package:alquran_doa/widgets/ayat_item.dart';
import 'package:alquran_doa/widgets/shimmer_loading.dart';

class SurahDetailScreen extends StatefulWidget {
  const SurahDetailScreen({Key? key}) : super(key: key);

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late Future<SurahDetail> surahDetail;
  int surahId = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is int) {
      surahId = arguments;
    }
    surahDetail = ApiService.getSurahDetail(surahId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SurahDetail>(
        future: surahDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerLoading();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final surah = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1F3A5F), Color.fromARGB(255, 235, 244, 247)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            surah.namaLatin,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            surah.nama,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Amiri',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${surah.arti} • ${surah.tempatTurun} • ${surah.jumlahAyat} Ayat',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Bismillah
                if (surah.nomor != 1 && surah.nomor != 9)
                  SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Amiri',
                        ),
                      ),
                    ),
                  ),
                // Ayat list
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => AyatItem(ayat: surah.ayat[index]),
                    childCount: surah.ayat.length,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}