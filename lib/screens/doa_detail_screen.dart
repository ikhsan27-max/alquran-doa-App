import 'package:flutter/material.dart';
import 'package:alquran_doa/models/doa.model.dart';
import 'package:alquran_doa/services/api_service.dart';
import 'package:alquran_doa/widgets/shimmer_loading.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoaDetailScreen extends StatefulWidget {
  final int doaId;

  const DoaDetailScreen({Key? key, required this.doaId}) : super(key: key);

  @override
  State<DoaDetailScreen> createState() => _DoaDetailScreenState();
}

class _DoaDetailScreenState extends State<DoaDetailScreen> {
  Future<Doa>? doaDetail;
  final Color primaryColor = const Color(0xFF1E4C6A);
  final Color accentColor = const Color(0xFF85A547);
  final Color backgroundColor = const Color(0xFFF5F5F5);
  final Color textColor = const Color(0xFF333333);

  @override
  void initState() {
    super.initState();
    doaDetail = _fetchDoaDetail();
  }

  Future<Doa> _fetchDoaDetail() async {
    try {
      return await ApiService.getDoaDetail(widget.doaId);
    } catch (e) {
      print('Error fetching doa detail: $e');
      throw Exception('Gagal memuat do\'a.');
    }
  }

  void _shareDoa(Doa doa) {
    final String shareText = '''
${doa.judul}

${doa.arab}

${doa.latin}

Artinya: ${doa.terjemah}

Dibagikan dari aplikasi Al-Qur'an & Do'a
''';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Detail Do\'a',
          style: TextStyle(
            fontFamily: 'Scheherazade',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          if (doaDetail != null)
            FutureBuilder<Doa>(
              future: doaDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                    icon: Icon(Icons.share, color: Colors.white),
                    onPressed: () => _shareDoa(snapshot.data!),
                    tooltip: 'Bagikan',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
      body: FutureBuilder<Doa>(
        future: doaDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerLoading();
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Doa tidak ditemukan'));
          } else {
            final doa = snapshot.data!;
            return _buildDoaContent(doa);
          }
        },
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red[700], size: 60),
            const SizedBox(height: 16),
            Text(
              'Terjadi kesalahan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  doaDetail = _fetchDoaDetail();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoaContent(Doa doa) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title card with decorative Islamic pattern
          _buildTitleCard(doa.judul),
          const SizedBox(height: 20),
          
          // Arabic Text
          _buildArabicCard(doa.arab),
          const SizedBox(height: 16),
          
          // Latin Transliteration
          _buildCard(
            title: 'Latin',
            content: doa.latin,
            fontSize: 16,
            fontStyle: FontStyle.italic,
            iconColor: accentColor,
          ),
          
          const SizedBox(height: 16),
          
          // Translation
          _buildCard(
            title: 'Arti',
            content: doa.terjemah,
            fontSize: 16,
            iconColor: accentColor,
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTitleCard(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Decorative icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.menu_book_rounded, 
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Scheherazade',
              color: Colors.white,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildArabicCard(String arabicText) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: accentColor.withOpacity(0.3), width: 1),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.text_fields, color: accentColor, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Arab',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontFamily: 'Scheherazade',
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                arabicText,
                style: const TextStyle(
                  fontSize: 28, 
                  fontFamily: 'Amiri',
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            // Decorative line
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      accentColor,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    String? titleIcon,
    required String content,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection = TextDirection.ltr,
    double fontSize = 16,
    String? fontFamily,
    FontStyle fontStyle = FontStyle.normal,
    Color iconColor = Colors.teal,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: primaryColor.withOpacity(0.1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                titleIcon != null
                    ? SvgPicture.asset(titleIcon, color: iconColor, width: 20, height: 20)
                    : Icon(Icons.text_format, color: iconColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold, 
                    color: primaryColor,
                    fontFamily: 'Scheherazade',
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: fontSize, 
                fontFamily: fontFamily, 
                fontStyle: fontStyle, 
                height: 1.6,
                color: textColor,
              ),
              textAlign: textAlign,
              textDirection: textDirection,
            ),
          ],
        ),
      ),
    );
  }

  
}