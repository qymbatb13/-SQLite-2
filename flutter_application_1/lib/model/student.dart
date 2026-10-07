class Student {
  int? id;
  String name;

  Student(this.id, this.name);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      map['id'] as int?,
      map['name'] as String,
    );
  }
}