class Company {
  final int companyId;
  final String companyName;
  final String? address;
  final String? contactPerson;
  final String? contactEmail;
  final String? contactPhone;

  Company({
    required this.companyId,
    required this.companyName,
    this.address,
    this.contactPerson,
    this.contactEmail,
    this.contactPhone,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['company_id'] as int,
      companyName: json['company_name'] as String,
      address: json['address'] as String?,
      contactPerson: json['contact_person'] as String?,
      contactEmail: json['contact_email'] as String?,
      contactPhone: json['contact_phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'company_name': companyName,
      'address': address,
      'contact_person': contactPerson,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
    };
  }
}
