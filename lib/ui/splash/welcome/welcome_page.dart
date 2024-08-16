import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.isFirstTimeInstallApp});
  final bool isFirstTimeInstallApp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: isFirstTimeInstallApp
            ? IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.white,
                ),
              )
            : null,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          _buildTitleAndDescription(),
          const Spacer(),
          _buildButtonChangeLanguage(context),
          _buildButtonLogin(),
          _buildButtonRegister(),
        ],
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38).copyWith(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("welcome_title".tr(),
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 26),
          Text(
            "welcome_description".tr(),
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

  Widget _buildButtonLogin() {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8875FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'Lato'),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonChangeLanguage(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () {
            // lấy ra locale hiện tại
            final currentLocale = context.locale;
            if (currentLocale == const Locale('en')) {
              context.setLocale(const Locale('vi'));
            } else {
              context.setLocale(const Locale('en'));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8875FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: const Text(
            'Change Language',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'Lato'),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRegister() {
    return Container(
      height: 48,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: ElevatedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(color: Color(0xFF8875FF), width: 1),
        ),
        child: const Text(
          'Register',
          style:
              TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Lato'),
        ),
      ),
    );
  }
}
