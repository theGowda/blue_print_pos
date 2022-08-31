// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BlueDevice {
  BlueDevice({
    required this.name,
    required this.address,
    this.connected = false,
    this.type = 0,
  });

  factory BlueDevice.fromBluetoothDevice(BluetoothDevice bluetoothDevice) {
    return BlueDevice(
      address: bluetoothDevice.id.id,
      name: bluetoothDevice.name,
      type: bluetoothDevice.type.index,
    );
  }

  /// Name of bluetooth device, Android and iOS have same field name
  final String name;

  /// [address] value in Android get from model with same field name
  /// But in iOS get from id.id
  final String address;

  int? type;
  bool? connected;

  BlueDevice copyWith({
    String? name,
    String? address,
    int? type,
    bool? connected,
  }) {
    return BlueDevice(
      name: name ?? this.name,
      address: address ?? this.address,
      type: type ?? this.type,
      connected: connected ?? this.connected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'type': type,
      'connected': connected,
    };
  }

  factory BlueDevice.fromMap(Map<String, dynamic> map) {
    return BlueDevice(
        name: map['name'] as String,
        address: map['address'] as String,
        type: map['type'] as int,
        connected: map['connected'] as bool);
  }

  String toJson() => json.encode(toMap());

  factory BlueDevice.fromJson(String source) =>
      BlueDevice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BlueDevice(name: $name, address: $address, type: $type, connected: $connected)';
  }

  @override
  bool operator ==(covariant BlueDevice other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.address == address &&
        other.type == type &&
        other.connected == connected;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        type.hashCode ^
        connected.hashCode;
  }
}
