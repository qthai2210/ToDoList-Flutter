// đóng vai trò là giao diện màn hình
import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/enum/onboarding_page_position.dart';

class OnboardingChildPage extends StatelessWidget {
  const OnboardingChildPage(
      {super.key,
      required this.onboardingPagePosition,
      required this.nextOnPressed,
      required this.previousOnPressed,
      required this.skipOnPressed});

  final VoidCallback nextOnPressed;
  final VoidCallback previousOnPressed;
  final VoidCallback skipOnPressed;
  final OnboardingPagePosition onboardingPagePosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSkipButton(),
              _buildOnboardingImage(),
              _buildOnboardingPageControl(),
              _buildOnboardingTitleAndContent(),
              _buildOnboardingNextAndPreviousButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.only(top: 14),
      child: TextButton(
        onPressed: () {
          skipOnPressed.call();
        },
        child: const Text('Skip',
            style: TextStyle(
                color: Colors.white38, fontSize: 16, fontFamily: 'Lato')),
      ),
    );
  }

  Widget _buildOnboardingImage() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Image.asset(
        onboardingPagePosition.onboardingPageImage(),
        width: 296,
        height: 271,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildOnboardingPageControl() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosition.page1
                  ? Colors.white
                  : Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          Container(
            height: 4,
            width: 26,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosition.page2
                  ? Colors.white
                  : Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosition.page3
                  ? Colors.white
                  : Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingTitleAndContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(onboardingPagePosition.onboardPageTitle(),
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 32,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 42),
          Text(
            onboardingPagePosition.onboardPageContent(),
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingNextAndPreviousButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 107),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Previous',
                style: TextStyle(
                    color: Colors.white38, fontSize: 16, fontFamily: 'Lato')),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // cách 1
              nextOnPressed.call();
              // cách 2
              // nextOnPressed();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
                onboardingPagePosition == OnboardingPagePosition.page3
                    ? 'Get Started'
                    : 'Next',
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: 'Lato')),
          ),
        ],
      ),
    );
  }
}
