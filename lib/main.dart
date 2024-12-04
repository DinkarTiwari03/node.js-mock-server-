import 'package:flutter/material.dart';
import 'server_service.dart';
import 'bluetooth_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ServerService serverService = ServerService();
  final BluetoothService bluetoothService = BluetoothService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Local Server & Bluetooth')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await bluetoothService.scanForDevices();
                },
                child: const Text('Scan for Bluetooth Devices'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Example device for testing
                  BluetoothDevice dummyDevice = BluetoothDevice(
                    remoteId: const DeviceIdentifier('00:11:22:33:44:55'),
                    localName: 'Test Device',
                    type: BluetoothDeviceType.unknown,
                  );
                  await bluetoothService.connectToDevice(dummyDevice);
                },
                child: const Text('Connect to Device'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await serverService.addData('Sample Data');
                },
                child: const Text('Send Data to Server'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final data = await serverService.fetchData();
                  print(data);
                },
                child: const Text('Fetch Data from Server'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
