import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/user_settings_store/user_settings_store.dart';

@LazySingleton(as: UserSettingsStore)
class UserSettingsStoreImpl implements UserSettingsStore {
  final SharedPreferences _preferences;

  UserSettingsStoreImpl(this._preferences);

  @override
  Future<bool?> getOnboardingCondition() async => _preferences.getBool('onBoardIFashioneo');
  @override
  Future<void> setOnboardingConditionViewed() async =>
      _preferences.setBool('onBoardIFashioneo', true);
  @override
  Future<void> resetOnboardingConditionViewed() async => _preferences.clear();
}
