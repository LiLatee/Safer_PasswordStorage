import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

class MyEncryption {
  final _cipher = CipherWithAppendedMac(aesCtr, Hmac(sha256));

  SecretKey generateKey({int length=256}) {
    return SecretKey.randomBytes(length);
  }

  Future<Uint8List> encrypt({String password, SecretKey secretKey}) async {
    log("elo22", name: "LOL");
    final nonce = Nonce.randomBytes(2);
    final message = utf8.encode(password);
    log("elo33", name: "LOL");
    final encrypted = await _cipher.encrypt(
      message,
      secretKey: secretKey,
      nonce: nonce
    );
    log("elo44", name: "LOL");
    log(encrypted.toString(), name: "LOL");
    return encrypted;
  }

  String decrypt(String password) {

  }


}