class ProductInWarehouse {
  final int id;
  final String code;
  final String name;
  final int unitOfMeasureId;
  final String part;
  final int currencyId;
  final int quantity;
  final double price;
  final double? additionalPayment;
  final int? additionalPaymentCurrencyId;

  ProductInWarehouse({
    required this.id,
    required this.code,
    required this.name,
    required this.unitOfMeasureId,
    required this.part,
    required this.currencyId,
    required this.quantity,
    required this.price,
    this.additionalPayment,
    this.additionalPaymentCurrencyId,
  });

  factory ProductInWarehouse.fromJson(Map<String, dynamic> json) {
    return ProductInWarehouse(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      unitOfMeasureId: json['unit_of_measure_id'] as int,
      part: json['part'] as String,
      currencyId: json['currency_id'] as int,
      quantity: json['quantity'] as int,
      price: json['price'] as double,
      additionalPayment: json['additional_payment'] as double?,
      additionalPaymentCurrencyId: json['additional_payment_currency_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'unit_of_measure_id': unitOfMeasureId,
      'part': part,
      'currency_id': currencyId,
      'quantity': quantity,
      'price': price,
      'additional_payment': additionalPayment,
      'additional_payment_currency_id': additionalPaymentCurrencyId,
    };
  }
}
