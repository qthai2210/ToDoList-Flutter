// class cha: quản lý các page con. Di chuyển qua lại giữa các con

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/ui/splash/onboarding/onboarding_child_page.dart';
import 'package:todo_list_app/ui/splash/welcome/welcome_page.dart';
import 'package:todo_list_app/utils/enum/onboarding_page_position.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          // Truyền vào các widget con mà muốn page view quản lý
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page1,
            nextOnPressed: () {
              _pageController.jumpToPage(1);
            },
            previousOnPressed: () {
              _gotoWelComePage();
            },
            skipOnPressed: () {
              _markOnboardingCompleted();
              _gotoWelComePage();
            },
          ),
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page2,
            nextOnPressed: () {
              _pageController.jumpToPage(2);
            },
            previousOnPressed: () {
              _pageController.jumpToPage(0);
            },
            skipOnPressed: () {
              _markOnboardingCompleted();
              _gotoWelComePage();
            },
          ),

          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page3,
            nextOnPressed: () {
              _markOnboardingCompleted();
              _gotoWelComePage();
            },
            previousOnPressed: () {
              _pageController.jumpToPage(1);
            },
            skipOnPressed: () {
              _markOnboardingCompleted();
              _gotoWelComePage();
            },
          ),
        ],
      ),
    );
  }

  void _gotoWelComePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const WelcomePage(
                  isFirstTimeInstallApp: true,
                )));
  }

  Future<void> _markOnboardingCompleted() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboardingcompleted', true);
    } catch (e) {
      print(e);
    }
  }
}
