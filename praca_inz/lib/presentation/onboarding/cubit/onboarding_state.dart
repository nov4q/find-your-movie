part of 'onboarding_cubit.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial() = _Initial;
  @Implements<BuildState>()
  const factory OnboardingState.display() = _Display;
  const factory OnboardingState.skip() = _Skip;
  const factory OnboardingState.loading() = _Loading;
  const factory OnboardingState.error() = _Error;
  }
