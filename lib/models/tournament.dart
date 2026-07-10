class Tournament {
  final int? id;
  final String name;
  final String location;
  final String startDate;
  final String endDate;

  const Tournament({
    this.id,
    required this.name,
    required this.location,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory Tournament.fromMap(Map<String, dynamic> map) {
    return Tournament(
      id: map['id'] as int?,
      name: map['name'] as String,
      location: map['location'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
    );
  }

  Tournament copyWith({
    int? id,
    String? name,
    String? location,
    String? startDate,
    String? endDate,
  }) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
