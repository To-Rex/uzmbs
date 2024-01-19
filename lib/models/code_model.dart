class Code {
  final int codeId;
  final String codeValue;
  final String description;

  Code({
    required this.codeId,
    required this.codeValue,
    required this.description,
  });

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      codeId: json['code_id'] as int,
      codeValue: json['code_value'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code_id': codeId,
      'code_value': codeValue,
      'description': description,
    };
  }
}
