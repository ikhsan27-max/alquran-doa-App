  import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alquran_doa/models/surah_model.dart';
import 'package:share_plus/share_plus.dart';

class AyatItem extends StatelessWidget {
  final Ayat ayat;

  const AyatItem({Key? key, required this.ayat}) : super(key: key);

  void _copyAyat(BuildContext context) {
    Clipboard.setData(ClipboardData(text: ayat.arab));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ayat copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _shareAyat() {
    final String shareText = '''
${ayat.arab}

${ayat.latin}

${ayat.indonesia}

(QS. ${ayat.nomor})
''';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1F3A5F).withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 115, 11, 189),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      '${ayat.nomor}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () => _copyAyat(context),
                  tooltip: 'Copy',
                ),
                IconButton(
                  icon: const Icon(Icons.share, size: 20),
                  onPressed: _shareAyat,
                  tooltip: 'Share',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ayat.arab,
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.8,
                    fontFamily: 'Amiri',
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 16),
                Text(
                  ayat.latin,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  ayat.indonesia,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}