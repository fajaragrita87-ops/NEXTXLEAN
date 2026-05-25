import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nextclean/data/models/order_status.dart';

class LaundryOrder {
  final String id;
  final String? branchId;
  final String? customerId;
  final String? customerName;
  final int totalAmount;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? beforePhotoUrl;
  final String? afterPhotoUrl;
  final List<Map<String, dynamic>> statusHistory;

  const LaundryOrder({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.branchId,
    this.customerId,
    this.customerName,
    this.beforePhotoUrl,
    this.afterPhotoUrl,
    required this.statusHistory,
  });

  factory LaundryOrder.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    final createdAt =
        (data['createdAt'] as Timestamp?)?.toDate() ??
        DateTime.fromMillisecondsSinceEpoch(0);
    final updatedAt = (data['updatedAt'] as Timestamp?)?.toDate() ?? createdAt;
    final status =
        OrderStatus.fromString(data['status'] as String?) ??
        OrderStatus.orderMasuk;
    final statusHistoryRaw = (data['statusHistory'] as List?) ?? const [];
    final statusHistory = statusHistoryRaw.whereType<Map>().map((m) {
      return Map<String, dynamic>.from(m);
    }).toList();
    return LaundryOrder(
      id: doc.id,
      branchId: data['branchId'] as String?,
      customerId: data['customerId'] as String?,
      customerName: data['customerName'] as String?,
      totalAmount: (data['totalAmount'] as num?)?.toInt() ?? 0,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      beforePhotoUrl: data['beforePhotoUrl'] as String?,
      afterPhotoUrl: data['afterPhotoUrl'] as String?,
      statusHistory: statusHistory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branchId': branchId,
      'customerId': customerId,
      'customerName': customerName,
      'totalAmount': totalAmount,
      'status': status.key,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'beforePhotoUrl': beforePhotoUrl,
      'afterPhotoUrl': afterPhotoUrl,
      'statusHistory': statusHistory,
    };
  }
}
