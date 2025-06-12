import 'package:mobile_security/core/constants/app_strings.dart';
import 'package:mobile_security/core/utils/prefs_helper.dart';
import 'package:mobile_security/features/home/data/datasources/local/home_local_datasource.dart';

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final PrefsHelper prefsHelper;
  HomeLocalDatasourceImpl({required this.prefsHelper});

  @override
  Future<void> verifySimBinding(String mobileNumber, String deviceId) async {
    prefsHelper.saveString(AppStrings.mobileNumberKey, mobileNumber);
    prefsHelper.saveString(AppStrings.deviceIdKey, deviceId);
  }

  @override
  Future<bool> checkBindingStatus(String deviceId) async {
    String? storedDeviceId = prefsHelper.getString(AppStrings.deviceIdKey);
    if (deviceId == storedDeviceId) {
      return true;
    } else {
      return false;
    }
  }
}
