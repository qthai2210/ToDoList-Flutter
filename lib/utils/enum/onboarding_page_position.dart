enum OnboardingPagePosition { page1, page2, page3 }

extension OnboardingPagePositionExtension on OnboardingPagePosition {
  // trả về image cho 3 page
  String onboardingPageImage() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return 'assets/images/onboarding_1.png';
      case OnboardingPagePosition.page2:
        return 'assets/images/onboarding_2.png';
      case OnboardingPagePosition.page3:
        return 'assets/images/onboarding_3.png';
    }
  }

  String onboardPageTitle() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return 'Manage your tasks';
      case OnboardingPagePosition.page2:
        return 'Create daily routine';
      case OnboardingPagePosition.page3:
        return 'Organize your tasks';
    }
  }

  String onboardPageContent() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return 'Manage your tasks with UpTodo. You can create, edit, and delete your tasks easily.';
      case OnboardingPagePosition.page2:
        return 'In Uptodo  you can create your personalized routine to stay productive.';
      case OnboardingPagePosition.page3:
        return 'You can organize your daily tasks by adding your tasks into separate categories';
    }
  }

  int get index {
    switch (this) {
      case OnboardingPagePosition.page1:
        return 0;
      case OnboardingPagePosition.page2:
        return 1;
      case OnboardingPagePosition.page3:
        return 2;
    }
  }
}
