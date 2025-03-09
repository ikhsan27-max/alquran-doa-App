import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alquran_doa/models/surah_model.dart';
import 'package:alquran_doa/models/doa.model.dart'; // Pastikan nama file dan model sudah benar

class ApiService {
  // Base URLs
  static const String quranBaseUrl = 'https://quran-api.santrikoding.com/api';
  static const String doaBaseUrl = 'https://open-api.my.id/api/doa';

  // Get all surahs
  static Future<List<Surah>> getAllSurahs() async {
    try {
      final response = await http.get(Uri.parse('$quranBaseUrl/surah'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Surah.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load surahs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching surahs: $e');
    }
  }

  // Get random 5 surahs
  static Future<List<Surah>> getRandomSurahs(int count) async {
    try {
      List<Surah> allSurahs = await getAllSurahs();
      allSurahs.shuffle();
      return allSurahs.take(count).toList();
    } catch (e) {
      throw Exception('Error fetching random surahs: $e');
    }
  }

  // Get surah detail
  static Future<SurahDetail> getSurahDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$quranBaseUrl/surah/$id'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return SurahDetail.fromJson(data);
      } else {
        throw Exception('Failed to load surah detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching surah detail: $e');
    }
  }

  // Get all doas
static Future<List<Doa>> getAllDoas() async {
  try {
    final response = await http.get(Uri.parse(doaBaseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Doa.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load doas: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching doas: $e');
  }
}

  // Get doa detail by ID
  static Future<Doa> getDoaDetail(int doaId) async {
    try {
      final response = await http.get(Uri.parse(doaBaseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body); // API mengembalikan List
        var doa = data.firstWhere(
          (item) => item['id'] == doaId,
          orElse: () => null,
        );

        if (doa != null) {
          return Doa.fromJson(doa);
        } else {
          throw Exception('Doa dengan ID $doaId tidak ditemukan.');
        }
      } else {
        throw Exception('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching doa detail: $e');
      throw Exception('Error: $e');
    }
  }
}