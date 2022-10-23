import 'package:injectable/injectable.dart';
import '../../domain/onboarding/onboarding_repository.dart';

@injectable
class OnboardingUseCase {
  final OnboardingRepository _repository;

  OnboardingUseCase(this._repository);

  void setOnboardingCondition() => _repository.setOnboardingCondViewed();
  Future<bool> getOnboardingCond() async {
    return await _repository.getOnboardingCond() ?? false;
  }

  void resetOnboardingCond() => _repository.resetOnboardingCond();
}
