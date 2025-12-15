import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String uid); // Save User ID
  Future<void> clearCache();           // Delete User ID (Logout)
  Future<bool> isUserLoggedIn();       // Check if saved
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  static const String CACHED_UID = 'CACHED_USER_UID';

  @override
  Future<void> cacheToken(String uid) async {
    // We await this to ensure it saves, but we don't return the boolean result
    await sharedPreferences.setString(CACHED_UID, uid);
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(CACHED_UID);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    // Check if the key exists in storage
    return sharedPreferences.containsKey(CACHED_UID);
  }
}