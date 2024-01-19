class UnitOfMeasure {
  final int id;
  final String unitCode;
  final String description;
  final double conversionFactor;

  UnitOfMeasure({
    required this.id,
    required this.unitCode,
    required this.description,
    required this.conversionFactor,
  });

  factory UnitOfMeasure.fromJson(Map<String, dynamic> json) {
    return UnitOfMeasure(
      id: json['id'] as int,
      unitCode: json['unit_code'] as String,
      description: json['description'] as String,
      conversionFactor: json['conversion_factor'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_code': unitCode,
      'description': description,
      'conversion_factor': conversionFactor,
    };
  }
}
