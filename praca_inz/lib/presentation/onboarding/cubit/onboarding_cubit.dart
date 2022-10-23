import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../use_case/onboarding/onboarding_use_case.dart';
import '../../style/app_dimens.dart';

part 'onboarding_state.dart';
part 'onboarding_cubit.freezed.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._onboardingUseCase)
      : super(const OnboardingState.initial());
  final OnboardingUseCase _onboardingUseCase;

  Future<void> displayOnboarding() async {
    emit(const _Loading());
    // _onboardingUseCase.resetOnboardingCond();
    await Future.delayed(AppDimens.duration800ms);
    try {
      if (await _onboardingUseCase.getOnboardingCond()) {
        emit(const _Skip());
      } else {
        _onboardingUseCase.setOnboardingCondition();
        emit(const _Display());
      }
    } catch (_) {
      emit(const _Error());
    }
  }
}
