import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

class SessionService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Salva o usuário e token na sessão
  Future<void> saveUser(User user) async {
    await _prefs.setString(_tokenKey, user.token);
    await _prefs.setString(_userKey, json.encode(user.toJson()));
  }

  /// Recupera o usuário da sessão
  User? getUser() {
    final userJson = _prefs.getString(_userKey);
    if (userJson == null) return null;
    try {
      return User.fromJson(json.decode(userJson));
    } catch (e) {
      return null;
    }
  }

  /// Recupera o token da sessão
  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  /// Verifica se o usuário está autenticado
  bool isAuthenticated() {
    return getToken() != null && getUser() != null;
  }

  /// Faz logout (limpa a sessão)
  Future<void> logout() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
  }
}
