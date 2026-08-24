class Academy {
  final int id;
  final String name;

  const Academy({
    required this.id,
    required this.name,
  });

  factory Academy.fromJson(Map<String, dynamic> json) {
    return Academy(
      id: json['id'].toInt(),
      name: json['name'].toString(),
    );
  }
}