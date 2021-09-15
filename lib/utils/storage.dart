import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux_persist/redux_persist.dart';

class SecureStorage implements StorageEngine {
  FlutterSecureStorage flutterSecureStorage;

  SecureStorage(this.flutterSecureStorage);

  @override
  Future<Uint8List> load() async {
    String? data = await flutterSecureStorage.read(key: "data");
    log('SecureStorage is Reading: $data ');
    return stringToUint8List(data)!;
  }

  @override
  Future<void> save(Uint8List? data) async {
    var str = uint8ListToString(
      data,
    );
    log('SecureStorage is Saving: $str ');
    await flutterSecureStorage.write(
      key: "data",
      value: str,
    );
  }
}
