class WithdrawalMethod {
  final int id;
  final String name;
  final String slug;
  final List<WithdrawalField> fields;

  WithdrawalMethod({
    required this.id,
    required this.name,
    required this.slug,
    required this.fields,
  });

  factory WithdrawalMethod.fromJson(Map<String, dynamic> json) {
    return WithdrawalMethod(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      fields: (json['fields'] as List)
          .map((e) => WithdrawalField.fromJson(e))
          .toList(),
    );
  }
}

class WithdrawalField {
  final String key;
  final String label;
  final String type;
  final bool required;

  WithdrawalField({
    required this.key,
    required this.label,
    required this.type,
    required this.required,
  });

  factory WithdrawalField.fromJson(Map<String, dynamic> json) {
    return WithdrawalField(
      key: json['key'],
      label: json['label'],
      type: json['type'],
      required: json['required'],
    );
  }
}
