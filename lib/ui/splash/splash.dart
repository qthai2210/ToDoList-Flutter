import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/ui/splash/onboarding/onboarding_page_view.dart';
import 'package:todo_list_app/ui/splash/welcome/welcome_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _checkAppState(BuildContext context) async {
    // kiểm tra xem có konboardingcompleted
    final isOnboardingCompleted = await _isOnboardingCompleted();
    if (isOnboardingCompleted) {
      // nếu có thì chuyển sang trang main
      // nếu context đã bị dispose thì không chuyển trang
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const WelcomePage(
                    isFirstTimeInstallApp: false,
                  )));
    } else {
      // nếu không thì chuyển sang trang onboarding
      // nếu context đã bị dispose thì không chuyển trang
      if (!context.mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnboardingPageView()));
    }
  }

  Future<bool> _isOnboardingCompleted() async {
    // kiểm tra xem có konboardingcompleted
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool('onboardingcompleted');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAppState(context);
    return const Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: _buildBodyPage(),
      ),
    );
  }
}

class _buildBodyPage extends StatelessWidget {
  const _buildBodyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIconSplash(),
            _buildTextSplash(),
          ],
        ),
      ),
    );
  }
}

class _buildTextSplash extends StatelessWidget {
  const _buildTextSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: const Text(
        'UpTodo',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _buildIconSplash extends StatelessWidget {
  const _buildIconSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/splash_icon.png',
      width: 95,
      height: 80,
      // giữ tỷ lệ ảnh theo một chiều
      fit: BoxFit.contain,
    );
  }
}
