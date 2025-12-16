import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  // -- Auth Logic --
  Future<void> cacheToken(String uid); // Save User ID
  Future<void> clearCache();           // Delete User ID (Logout)
  Future<bool> isUserLoggedIn();       // Check if saved
  
  // -- Onboarding Logic (NEW) --
  Future<void> setOnboardingSeen();    // Save flag that user finished onboarding
  Future<bool> isOnboardingSeen();     // Check if user has seen onboarding
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  // Keys
  static const String CACHED_UID = 'CACHED_USER_UID';
  static const String ONBOARDING_SEEN = 'ONBOARDING_SEEN'; // New Key

  // ---------------------------------------------------------------------------
  // AUTH METHODS
  // ---------------------------------------------------------------------------
  @override
  Future<void> cacheToken(String uid) async {
    await sharedPreferences.setString(CACHED_UID, uid);
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(CACHED_UID);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return sharedPreferences.containsKey(CACHED_UID);
  }

  // ---------------------------------------------------------------------------
  // ONBOARDING METHODS
  // ---------------------------------------------------------------------------
  @override
  Future<void> setOnboardingSeen() async {
    // Save 'true' to indicate onboarding is done
    await sharedPreferences.setBool(ONBOARDING_SEEN, true);
  }

  @override
  Future<bool> isOnboardingSeen() async {
    // Return true if exists, otherwise return false
    return sharedPreferences.getBool(ONBOARDING_SEEN) ?? false;
  }
}