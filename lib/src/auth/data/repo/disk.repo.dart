import 'package:shared_preferences/shared_preferences.dart';

class DiskRepo {
  final SharedPreferences sharedPreferences;

  DiskRepo({required this.sharedPreferences});

  String? get token => sharedPreferences.getString('token');

  void deleteToken() {
    sharedPreferences.remove('token');
  }

  Future<void> saveToken({required String token}) async {
    await sharedPreferences.setString('token', token);
  }
}
