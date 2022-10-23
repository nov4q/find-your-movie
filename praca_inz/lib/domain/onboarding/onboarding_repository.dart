abstract class OnboardingRepository {
  Future<bool?> getOnboardingCond();
  Future<void> setOnboardingCondViewed();
  Future<void> resetOnboardingCond();
}
