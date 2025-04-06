import 'package:encrypt/encrypt.dart' as encrypt;

const String _key = 'wmlSHUeGeeaanxEant3iLesAvk3pkovV';

class EncryptionHelper {
  final encrypt.Key key;
  final encrypt.IV iv;
  final encrypt.Encrypter encrypter;

  EncryptionHelper()
      : key = encrypt.Key.fromUtf8(_key),
        iv = encrypt.IV.fromLength(16),
        encrypter = encrypt.Encrypter(
          encrypt.AES(encrypt.Key.fromUtf8(_key),
              mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
        );

  String encryptValue(String password) {
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  String decryptValue(String encryptedPassword) {
    final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
    return decrypted;
  }
}
