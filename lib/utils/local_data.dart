import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static final LocalData _localData = LocalData._internal();

  factory LocalData() => _localData;

  SharedPreferences? _preferences;

  final _userName = "UserNameKey";

  Future<SharedPreferences?> get _getSharedPref async {
    if (_preferences != null) {
      return _preferences;
    } else {
      _preferences = await SharedPreferences.getInstance();

      return _preferences;
    }
  }

  editUserName(String newUserName) async {
    await _getSharedPref;
    await _preferences!.setString(_userName, newUserName);
  }

  Future<String?> getCurrentUserName() async {
    await _getSharedPref;
    return _preferences!.getString(_userName);
  }

  static final LocalData pref = LocalData._internal();

  LocalData._internal();
}
