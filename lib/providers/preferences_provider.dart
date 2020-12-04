import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getStatusNotification();
  }

  bool _isNotificationActive = false;
  bool get isNotificationActive => _isNotificationActive;

  void _getStatusNotification() async {
    _isNotificationActive = await preferencesHelper.isSwitched;
    notifyListeners();
  }

  void setNotificationStatus(bool value) {
    preferencesHelper.setNotificationStatus(value);
    _getStatusNotification();
  }
}
