class Character {
  final String name;
  final String? job;
  final String? size;
  final String? birthday;
  final String? age;
  final String? bounty;
  final String? status;

  Character({
    required this.name,
     this.job,
     this.size,
     this.birthday,
     this.age,
     this.bounty,
     this.status,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      job: json['job'] ?? "No job",
      size: json['size'] ?? "No size",
      birthday: json['birthday'] ?? "No birthday",
      age: json['age'] ?? "No age",
      bounty: json['bounty'] ?? "No bounty",
      status: json['status'] ?? "Unknown",
    );
  }
}