abstract class AuthLocalDatasource {
  Future<void> register(String username, String password, String mpin);
  Future<bool> login(String username, String password);
  Future<bool> checkLogin();
  Future<void> logout();
  Future<bool> loginWithMPIN(String mpin);
}
