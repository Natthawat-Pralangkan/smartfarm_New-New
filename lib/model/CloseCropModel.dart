// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CloseCropModel1 {
  final String crop_id;
  final String close_date;
  final String amount;
  final String cost;
  final String farm_id;
  CloseCropModel1({
    required this.crop_id,
    required this.close_date,
    required this.amount,
    required this.cost,
    required this.farm_id,
  });

  CloseCropModel1 copyWith({
    String? crop_id,
    String? close_date,
    String? amount,
    String? cost,
    String? farm_id,
  }) {
    return CloseCropModel1(
      crop_id: crop_id ?? this.crop_id,
      close_date: close_date ?? this.close_date,
      amount: amount ?? this.amount,
      cost: cost ?? this.cost,
      farm_id: farm_id ?? this.farm_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'crop_id': crop_id,
      'close_date': close_date,
      'amount': amount,
      'cost': cost,
      'farm_id': farm_id,
    };
  }

  factory CloseCropModel1.fromMap(Map<String, dynamic> map) {
    return CloseCropModel1(
      crop_id: map['crop_id'] ?? '',
      close_date: map['close_date'] ?? '',
      amount: map['amount'] ?? '',
      cost: map['cost'] ?? '',
      farm_id: map['farm_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CloseCropModel1.fromJson(String source) => CloseCropModel1.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CloseCropModel1(crop_id: $crop_id, close_date: $close_date, amount: $amount, cost: $cost, farm_id: $farm_id)';
  }

  @override
  bool operator ==(covariant CloseCropModel1 other) {
    if (identical(this, other)) return true;
  
    return 
      other.crop_id == crop_id &&
      other.close_date == close_date &&
      other.amount == amount &&
      other.cost == cost &&
      other.farm_id == farm_id;
  }

  @override
  int get hashCode {
    return crop_id.hashCode ^
      close_date.hashCode ^
      amount.hashCode ^
      cost.hashCode ^
      farm_id.hashCode;
  }
}
