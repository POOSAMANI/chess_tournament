class Player {
  final int? id;
  final String name;
  final int age;
  final int rating;

  const Player({
    this.id,
    required this.name,
    required this.age,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age, 'rating': rating};
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] as int?,
      name: map['name'] as String,
      age: map['age'] as int,
      rating: map['rating'] as int? ?? 0,
    );
  }

  Player copyWith({int? id, String? name, int? age, int? rating}) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      rating: rating ?? this.rating,
    );
  }
}
