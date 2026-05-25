import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nextclean/data/models/order_status.dart';
import 'package:nextclean/data/models/order.dart';

class OrderRepository {
  final FirebaseFirestore firestore;

  OrderRepository({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _orders =>
      firestore.collection('orders');

  DocumentReference<Map<String, dynamic>> orderRef(String orderId) => _orders.doc(orderId);

  Stream<LaundryOrder?> watchOrderById(String orderId) {
    return orderRef(orderId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return LaundryOrder.fromDoc(doc);
    });
  }

  Future<String> createOrder({
    required String createdByUserId,
    required DateTime now,
    required int totalAmount,
    String? branchId,
    String? customerId,
    String? customerName,
  }) async {
    final doc = _orders.doc();
    await doc.set({
      'branchId': branchId,
      'customerId': customerId,
      'customerName': customerName,
      'totalAmount': totalAmount,
      'status': OrderStatus.orderMasuk.key,
      'beforePhotoUrl': null,
      'afterPhotoUrl': null,
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
      'statusHistory': [
        {
          'status': OrderStatus.orderMasuk.key,
          'at': Timestamp.fromDate(now),
          'by': createdByUserId,
        },
      ],
    });
    return doc.id;
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
    required String updatedByUserId,
    required DateTime now,
  }) async {
    await orderRef(orderId).update({
      'status': status.key,
      'updatedAt': Timestamp.fromDate(now),
      'statusHistory': FieldValue.arrayUnion([
        {
          'status': status.key,
          'at': Timestamp.fromDate(now),
          'by': updatedByUserId,
        },
      ]),
    });
  }

  Future<void> updateOrderPhotoUrl({
    required String orderId,
    required String type,
    required String photoUrl,
    required String updatedByUserId,
    required DateTime now,
  }) async {
    final field = type == 'after' ? 'afterPhotoUrl' : 'beforePhotoUrl';
    await orderRef(orderId).update({
      field: photoUrl,
      'updatedAt': Timestamp.fromDate(now),
      'statusHistory': FieldValue.arrayUnion([
        {
          'status': 'photo_$type',
          'at': Timestamp.fromDate(now),
          'by': updatedByUserId,
          'url': photoUrl,
        },
      ]),
    });
  }

  Stream<List<LaundryOrder>> watchRecentOrders({
    String? branchId,
    String? customerId,
    int limit = 50,
  }) {
    Query<Map<String, dynamic>> query = _orders
        .orderBy('createdAt', descending: true)
        .limit(limit);
    if (branchId != null && branchId.isNotEmpty) {
      query = query.where('branchId', isEqualTo: branchId);
    }
    if (customerId != null && customerId.isNotEmpty) {
      query = query.where('customerId', isEqualTo: customerId);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map(LaundryOrder.fromDoc).toList();
    });
  }
}
