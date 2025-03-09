import 'package:flutter/material.dart';
import 'package:alquran_doa/models/doa.model.dart';
import 'package:alquran_doa/screens/doa_detail_screen.dart'; // Pastikan impor halaman detail doa

class DoaCard extends StatelessWidget {
  final Doa doa;
  final VoidCallback? onTap;

  const DoaCard({
    Key? key,
    required this.doa,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: InkWell(
        onTap: onTap ?? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoaDetailScreen(doaId: doa.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doa.judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                doa.arab,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Arabic',
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              Text(
                doa.latin,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}