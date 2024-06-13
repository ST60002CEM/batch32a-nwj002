import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/features/onboarding/domain/entity/onboarding_entity.dart';
import 'package:liquor_ordering_system/features/onboarding/domain/usecases/onboarding_use_case.dart';

class OnboardingPresenter extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPageIndex = 0;
  late Timer _timer;

  final List<OnboardingEntity> onboardingPages;

  OnboardingPresenter() : onboardingPages = OnboardingUseCase().call() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPageIndex < onboardingPages.length - 1) {
        currentPageIndex++;
      } else {
        _timer.cancel();
      }
      pageController.animateToPage(
        currentPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void skipToLastPage() {
    pageController.jumpToPage(onboardingPages.length - 1);
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
    notifyListeners();
  }
}
