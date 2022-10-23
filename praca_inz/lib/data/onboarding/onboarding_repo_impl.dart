import 'package:injectable/injectable.dart';


import '../../domain/onboarding/onboarding_repository.dart';
import '../../domain/user_settings_store/user_settings_store.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepoImpl implements OnboardingRepository {
  final UserSettingsStore _userSettingsStore;

  OnboardingRepoImpl(this._userSettingsStore);

  @override
  Future<bool?> getOnboardingCond() =>
      _userSettingsStore.getOnboardingCondition();

  @override
  Future<void> setOnboardingCondViewed() =>
      _userSettingsStore.setOnboardingConditionViewed();

  @override
  Future<void> resetOnboardingCond() =>
      _userSettingsStore.resetOnboardingConditionViewed();
}
