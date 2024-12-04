import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();

  Future<void> scanForDevices() async {
    // Listen for scan results
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        print(
            'Device found: ${result.device.localName} | RSSI: ${result.rssi} | Remote ID: ${result.device.remoteId}');
      }
    });

    // Start scanning using the new method
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
      oneByOne: true,
    );

    // Wait for the scan to complete
    while (await FlutterBluePlus.isScanning.first) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    print("Scanning completed.");
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    print("Connected to device: ${device.localName}");

    // Listen to connection state
    device.connectionState.listen((state) {
      print("Connection State: $state");
    });
  }

  Future<void> sendData(BluetoothDevice device, String data) async {
    List<BluetoothService> services = (await device.discoverServices()).cast<BluetoothService>();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          // Write data using the updated write method
          await characteristic.write(data.codeUnits, withoutResponse: true);
          print("Data sent: $data");
        }
      }
    }
  }
}
