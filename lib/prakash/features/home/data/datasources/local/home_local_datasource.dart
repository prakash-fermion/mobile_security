abstract class HomeLocalDatasource {
  Future<void> verifySimBinding(String mobileNumber, String deviceId);
  Future<bool> checkBindingStatus(String deviceId);
}
