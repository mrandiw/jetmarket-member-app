class MandatorySavingModel {
  final int id;
  final String refId;
  final int amount;
  final String periode;
  final String note;
  final DateTime createdAt;

  MandatorySavingModel({
    required this.id,
    required this.refId,
    required this.amount,
    required this.periode,
    required this.note,
    required this.createdAt,
  });

  factory MandatorySavingModel.fromJson(Map<String, dynamic> json) {
    return MandatorySavingModel(
      id: json['id'] ?? 0,
      refId: json['ref_id'] ?? '',
      amount: json['amount'] ?? 0,
      periode: json['periode'] ?? '',
      note: json['note'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ref_id': refId,
      'amount': amount,
      'periode': periode,
      'note': note,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Format periode from MMYYYY to readable string (e.g., "Des 2024")
  String get formattedPeriode {
    if (periode.length != 6) return periode;
    final month = int.tryParse(periode.substring(0, 2)) ?? 1;
    final year = periode.substring(2);
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return '${months[month - 1]} $year';
  }
}

class MandatorySavingHistoryResponse {
  final int page;
  final int size;
  final int totalRecords;
  final int totalAmount;
  final List<MandatorySavingModel> items;

  MandatorySavingHistoryResponse({
    required this.page,
    required this.size,
    required this.totalRecords,
    required this.totalAmount,
    required this.items,
  });

  factory MandatorySavingHistoryResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsJson = json['items'] ?? [];
    return MandatorySavingHistoryResponse(
      page: json['page'] ?? 1,
      size: json['size'] ?? 0,
      totalRecords: json['total_records'] ?? 0,
      totalAmount: json['total_amount'] ?? 0,
      items: itemsJson.map((e) => MandatorySavingModel.fromJson(e)).toList(),
    );
  }
}
