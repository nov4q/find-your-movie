abstract class UserSettingsStore {
  Future<bool?> getOnboardingCondition();
  Future<void> setOnboardingConditionViewed();
  Future<void> resetOnboardingConditionViewed();
}
