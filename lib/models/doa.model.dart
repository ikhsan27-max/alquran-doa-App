class Doa {
  final int id;
  final String judul;
  final String arab;
  final String latin;
  final String terjemah;

  Doa({
    required this.id,
    required this.judul,
    required this.arab,
    required this.latin,
    required this.terjemah,
  });

  factory Doa.fromJson(Map<String, dynamic> json) {
    return Doa(
      id: json['id'] ?? 0,
      judul: json['judul'],  // <-- Cek apakah key "judul" benar
      arab: json['arab'],
      latin: json['latin'],
      terjemah: json['terjemah'],
    );
  }
}
