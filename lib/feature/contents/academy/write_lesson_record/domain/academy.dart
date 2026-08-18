class Academy {
  final String id;
  final String name;

  const Academy({
    required this.id,
    required this.name,
  });

  factory Academy.fromJson(Map<String, dynamic> json) {
    return Academy(
      id: json['id'].toString(),
      name: json['name'].toString(),
    );
  }
}