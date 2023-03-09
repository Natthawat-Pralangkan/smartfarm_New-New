// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Environment {
  final String farm_id;
  final String docno;
  final String device_id;
  final String datekey;
  final String timekey;
  final String temp;
  final String humid;
  final String light;
  final String soild_1;
  final String soild_2;
  final String fer_n;
  final String fer_p;
  final String fer_k;
  final String water_temp;
  Environment({
    required this.farm_id,
    required this.docno,
    required this.device_id,
    required this.datekey,
    required this.timekey,
    required this.temp,
    required this.humid,
    required this.light,
    required this.soild_1,
    required this.soild_2,
    required this.fer_n,
    required this.fer_p,
    required this.fer_k,
    required this.water_temp,
  });

  Environment copyWith({
    String? crop_id,
    String? close_date,
    String? amount,
    String? cost,
    String? farm_id,
  }) {
    return Environment(
      farm_id: crop_id ?? this.farm_id,
      docno: close_date ?? this.docno,
      device_id: amount ?? this.device_id,
      datekey: cost ?? this.datekey,
      timekey: farm_id ?? this.timekey,
      temp: farm_id ?? this.temp,
      humid: farm_id ?? this.humid,
      light: farm_id ?? this.light,
      soild_1: farm_id ?? this.soild_1,
      soild_2: farm_id ?? this.soild_2,
      fer_n: farm_id ?? this.fer_n,
      fer_p: farm_id ?? this.fer_p,
      fer_k: farm_id ?? this.fer_k,
      water_temp: farm_id ?? this.water_temp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'farm_id': farm_id,
      'docno': docno,
      'device_id': device_id,
      'datekey': datekey,
      'timekey': timekey,
      'temp': temp,
      'humid': humid,
      'light': light,
      'soild_1': soild_1,
      'soild_2': soild_2,
      'fer_n': fer_n,
      'fer_p': fer_p,
      'fer_k': fer_k,
      'water_temp': water_temp,
    };
  }

  factory Environment.fromMap(Map<String, dynamic> map) {
    return Environment(
      farm_id: map['farm_id'] ?? '',
      docno: map['docno'] ?? '',
      device_id: map['device_id'] ?? '',
      datekey: map['datekey'] ?? '',
      timekey: map['timekey'] ?? '',
      temp: map['temp'] ?? '',
      humid: map['humid'] ?? '',
      light: map['light'] ?? '',
      soild_1: map['soild_1'] ?? '',
      soild_2: map['soild_2'] ?? '',
      fer_n: map['fer_n'] ?? '',
      fer_p: map['fer_p'] ?? '',
      fer_k: map['fer_k'] ?? '',
      water_temp: map['water_temp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Environment.fromJson(String source) =>
      Environment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Environment(farm_id: $farm_id, docno: $docno, device_id: $device_id, datekey: $datekey, timekey: $timekey,temp: $temp, humid: $humid, light: $light, soild_1: $soild_1, soild_2: $soild_2,fer_n: $fer_n, fer_p: $fer_p, fer_k: $fer_k, water_temp: $water_temp)';
  }

  @override
  bool operator ==(covariant Environment other) {
    if (identical(this, other)) return true;

    return other.farm_id == farm_id &&
        other.docno == docno &&
        other.device_id == device_id &&
        other.datekey == datekey &&
        other.timekey == timekey &&
        other.temp == temp &&
        other.humid == humid &&
        other.light == light &&
        other.soild_1 == soild_1 &&
        other.soild_2 == soild_2 &&
        other.fer_n == fer_n &&
        other.fer_p == fer_p &&
        other.fer_k == fer_k &&
        other.water_temp == water_temp;
  }

  @override
  int get hashCode {
    return docno.hashCode ^
        device_id.hashCode ^
        datekey.hashCode ^
        timekey.hashCode ^
        temp.hashCode ^
        humid.hashCode ^
        light.hashCode ^
        soild_1.hashCode ^
        soild_2.hashCode ^
        fer_n.hashCode ^
        fer_p.hashCode ^
        fer_k.hashCode ^
        water_temp.hashCode ^
        farm_id.hashCode;
  }
}
