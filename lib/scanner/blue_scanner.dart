import 'package:blue_print_pos/models/blue_device.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as flutter_blue;

/// This class with static method to handler scanning in Android and iOS
class BlueScanner {
  const BlueScanner._();

  /// Provide list of bluetooth device, return as list of [BlueDevice]
  static Future<List<BlueDevice>> scan() async {
    List<BlueDevice> devices = <BlueDevice>[];

    final flutter_blue.FlutterBluePlus bluetoothIOS =
        flutter_blue.FlutterBluePlus.instance;
    final List<flutter_blue.BluetoothDevice> resultDevices =
        <flutter_blue.BluetoothDevice>[];

    await bluetoothIOS.startScan(
      timeout: const Duration(seconds: 5),
    );
    bluetoothIOS.scanResults
        .listen((List<flutter_blue.ScanResult> scanResults) {
      for (final flutter_blue.ScanResult scanResult in scanResults) {
        resultDevices.add(scanResult.device);
      }
    });

    await bluetoothIOS.stopScan();
    devices = resultDevices
        .toSet()
        .toList()
        .map(
          (flutter_blue.BluetoothDevice bluetoothDevice) =>
              BlueDevice.fromBluetoothDevice(bluetoothDevice),
        )
        .toList();
    return devices;
  }
}
