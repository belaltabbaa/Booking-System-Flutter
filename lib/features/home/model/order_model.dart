// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  String sellerName;
  String buyerName;
  String plateNumber;
  OrderModel({
    required this.sellerName,
    required this.buyerName,
    required this.plateNumber,
  });

  OrderModel copyWith({
    String? sellerName,
    String? buyerName,
    String? plateNumber,
  }) {
    return OrderModel(
      sellerName: sellerName ?? this.sellerName,
      buyerName: buyerName ?? this.buyerName,
      plateNumber: plateNumber ?? this.plateNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seller_name': sellerName,
      'buyer_name': buyerName,
      'plate_number': plateNumber,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      sellerName: map['sellerName'] as String,
      buyerName: map['buyerName'] as String,
      plateNumber: map['plateNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderModel(sellerName: $sellerName, buyerName: $buyerName, plateNumber: $plateNumber)';

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.sellerName == sellerName &&
      other.buyerName == buyerName &&
      other.plateNumber == plateNumber;
  }

  @override
  int get hashCode => sellerName.hashCode ^ buyerName.hashCode ^ plateNumber.hashCode;
}
