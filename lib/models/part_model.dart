class Part {
  final int partId;
  final String partNumber;
  final String description;
  final int codeId;

  Part({
    required this.partId,
    required this.partNumber,
    required this.description,
    required this.codeId,
  });

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      partId: json['part_id'] as int,
      partNumber: json['part_number'] as String,
      description: json['description'] as String,
      codeId: json['code_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'part_id': partId,
      'part_number': partNumber,
      'description': description,
      'code_id': codeId,
    };
  }
}
