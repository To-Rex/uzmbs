class Import {
  final int importId;
  final int productId;
  final DateTime importDate;
  final int quantity;
  final String source;
  final String? receivingCompany;
  final String? trackingNumber;
  final double? additionalPayment;
  final int? additionalPaymentCurrencyId;
  final int? companyId;

  Import({
    required this.importId,
    required this.productId,
    required this.importDate,
    required this.quantity,
    required this.source,
    this.receivingCompany,
    this.trackingNumber,
    this.additionalPayment,
    this.additionalPaymentCurrencyId,
    this.companyId,
  });

  factory Import.fromJson(Map<String, dynamic> json) {
    return Import(
      importId: json['import_id'] as int,
      productId: json['product_id'] as int,
      importDate: DateTime.parse(json['import_date'] as String),
      quantity: json['quantity'] as int,
      source: json['source'] as String,
      receivingCompany: json['receiving_company'] as String?,
      trackingNumber: json['tracking_number'] as String?,
      additionalPayment: json['additional_payment'] as double?,
      additionalPaymentCurrencyId: json['additional_payment_currency_id'] as int?,
      companyId: json['company_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'import_id': importId,
      'product_id': productId,
      'import_date': importDate.toIso8601String(),
      'quantity': quantity,
      'source': source,
      'receiving_company': receivingCompany,
      'tracking_number': trackingNumber,
      'additional_payment': additionalPayment,
      'additional_payment_currency_id': additionalPaymentCurrencyId,
      'company_id': companyId,
    };
  }
}
