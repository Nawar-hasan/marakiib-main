class WalletHistory {
  final int id;
  final String amount;
  final String type;
  final String status;
  final String description;
  final RelatedWithdrawal related;

  WalletHistory({
    required this.id,
    required this.amount,
    required this.type,
    required this.status,
    required this.description,
    required this.related,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) {
    return WalletHistory(
      id: json['id'],
      amount: json['amount'],
      type: json['type'],
      status: json['status'],
      description: json['description'],
      related: RelatedWithdrawal.fromJson(json['related']),
    );
  }
}

class RelatedWithdrawal {
  final int id;
  final int withdrawalMethodId;
  final String amount;
  final Map<String, dynamic> details;
  final String status;
  final String? adminNotes; // ✅ هنا ضيفنا

  RelatedWithdrawal({
    required this.id,
    required this.withdrawalMethodId,
    required this.amount,
    required this.details,
    required this.status,
    this.adminNotes, // ✅ هنا برضو
  });

  factory RelatedWithdrawal.fromJson(Map<String, dynamic> json) {
    return RelatedWithdrawal(
      id: json['id'],
      withdrawalMethodId: json['withdrawal_method_id'],
      amount: json['amount'],
      details: Map<String, dynamic>.from(json['details'] ?? {}),
      status: json['status'],
      adminNotes: json['admin_notes']?.toString(), // ✅ هنا ناخدها
    );
  }
}
