import 'package:mobile_security/core/constants/app_strings.dart';
import 'package:mobile_security/core/utils/custom_logger.dart';
import 'package:mobile_security/core/utils/prefs_helper.dart';
import 'package:mobile_security/features/auth/data/datasources/local/auth_local_datasource.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final PrefsHelper prefsHelper;
  AuthLocalDatasourceImpl(this.prefsHelper);

  @override
  Future<bool> login(String username, String password) async {
    String name = prefsHelper.getString(AppStrings.userNameKey) ?? '';
    String pass = prefsHelper.getString(AppStrings.passwordKey) ?? '';
    if (name == username && pass == password) {
      prefsHelper.saveBool(AppStrings.isLoggedInKey, true);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    prefsHelper.saveBool(AppStrings.isLoggedInKey, false);
  }

  @override
  Future<void> register(String username, String password, String mpin) async {
    prefsHelper.saveString(AppStrings.userNameKey, username);
    prefsHelper.saveString(AppStrings.passwordKey, password);
    prefsHelper.saveString(AppStrings.mpinKey, mpin);
    prefsHelper.saveBool(AppStrings.isLoggedInKey, true);
  }

  @override
  Future<bool> checkLogin() async {
    bool isLoggedIn = prefsHelper.getBool(AppStrings.isLoggedInKey) ?? false;
    return isLoggedIn;
  }

  @override
  Future<bool> loginWithMPIN(String mpin) async {
    String savedMpin = prefsHelper.getString(AppStrings.mpinKey) ?? '';
    CustomLogger.log(
      'Saved MPIN: $savedMpin, Provided MPIN: $mpin',
    );
    
    if (savedMpin == mpin) {
      prefsHelper.saveBool(AppStrings.isLoggedInKey, true);
      return true;
    } else {
      return false;
    }
  }
}
