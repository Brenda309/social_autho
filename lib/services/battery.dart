import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryPage extends StatefulWidget {
  @override
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  final battery = Battery();
  int batteryLevel = 100;
  BatteryState batteryState = BatteryState.full;

  Timer? timer;
  StreamSubscription<BatteryState>? subscription;
  final AudioCache audioCache = AudioCache();

  @override
  void initState() {
    super.initState();
    listenBatteryLevel();
    listenBatteryState();
  }

  void listenBatteryState() {
    subscription = battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        batteryState = state;
      });

      if (batteryState == BatteryState.charging && batteryLevel >= 90) {
        playSoundAndShowToast();
      }
    });
  }

  void listenBatteryLevel() {
    updateBatteryLevel();

    timer = Timer.periodic(
      Duration(seconds: 10),
          (_) async => updateBatteryLevel(),
    );
  }

  Future updateBatteryLevel() async {
    final level = await battery.batteryLevel;
    setState(() {
      batteryLevel = level;
    });

    if (batteryState == BatteryState.charging && batteryLevel >= 90) {
      playSoundAndShowToast();
    }
  }

  void playSoundAndShowToast() async {
    // Play the sound from the local asset
    await audioCache.play('notification-9-158194.mp3');
    Fluttertoast.showToast(
      msg: 'Battery level is above 90%',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Battery Monitor"),
      centerTitle: true,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildBatteryState(batteryState),
          const SizedBox(height: 32),
          buildBatteryLevel(batteryLevel),
        ],
      ),
    ),
  );

  Widget buildBatteryState(BatteryState state) {
    final style = TextStyle(fontSize: 32, color: Colors.white);
    final double size = 300;

    switch (state) {
      case BatteryState.full:
        final color = Colors.green;
        return Column(
          children: [
            Icon(Icons.battery_full, size: size, color: color),
            Text('Full!', style: style.copyWith(color: color)),
          ],
        );
      case BatteryState.charging:
        final color = Colors.green;
        return Column(
          children: [
            Icon(Icons.battery_charging_full, size: size, color: color),
            Text('Charging...', style: style.copyWith(color: color)),
          ],
        );
      case BatteryState.discharging:
      default:
        final color = Colors.red;
        return Column(
          children: [
            Icon(Icons.battery_alert, size: size, color: color),
            Text('Discharging...', style: style.copyWith(color: color)),
          ],
        );
    }
  }

  Widget buildBatteryLevel(int level) => Text(
    '$level%',
    style: TextStyle(
      fontSize: 46,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}
