import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_typechannel/pigeon_typechannel.dart';

void main() {
  const MethodChannel channel = MethodChannel('pigeon_typechannel');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PigeonTypechannel.platformVersion, '42');
  });
}
