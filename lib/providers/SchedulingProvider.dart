import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  SchedulingProvider({@required this.preferencesHelper}) {
    _getStatusNotification();
  }

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void _getStatusNotification() async {
    _isScheduled = await preferencesHelper.isSwitched;
    notifyListeners();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    preferencesHelper.setNotificationStatus(value);
    _getStatusNotification();

    if (_isScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
