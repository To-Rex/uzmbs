class CurrencyModel {
  final int id;
  final String code;
  final String name;
  final double exchangeRate;

  CurrencyModel({
    required this.id,
    required this.code,
    required this.name,
    required this.exchangeRate,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      exchangeRate: json['exchange_rate'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'exchange_rate': exchangeRate,
    };
  }
}