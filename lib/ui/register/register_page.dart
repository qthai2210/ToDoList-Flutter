import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/login/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
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
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageTitle(),
              _buildFormRegister(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38).copyWith(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Register".tr(),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 32,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFormRegister(BuildContext context) {
    return Form(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildUserNameField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            _buildConfirmPasswordField(),
            _buildLoginButton(),
            _buildOrSplitDivider(),
            _buildSocialRegister(),
            _buildHaveAccount(context),
          ],
        ),
      ),
    );
  }

  Column _buildUserNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "User_name_label".tr(),
          style: TextStyle(
              color: Colors.white.withOpacity(0.87),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: "User_name_hint".tr(),
            hintStyle: const TextStyle(
              color: Color(0xff535353),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            fillColor: const Color(
              0xff1d1d1d,
            ),
            filled: true,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Column _buildPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "password_label".tr(),
          style: TextStyle(
              color: Colors.white.withOpacity(0.87),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: "password_label_hint".tr(),
            hintStyle: const TextStyle(
              color: Color(0xff535353),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            fillColor: const Color(
              0xff1d1d1d,
            ),
            filled: true,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
          obscureText: true,
        ),
      ],
    );
  }

  Column _buildConfirmPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "confirm_password_label".tr(),
          style: TextStyle(
              color: Colors.white.withOpacity(0.87),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: "confirm_password_hint".tr(),
            hintStyle: const TextStyle(
              color: Color(0xff535353),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            fillColor: const Color(
              0xff1d1d1d,
            ),
            filled: true,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(top: 70),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8875FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            disabledBackgroundColor: const Color(0xff8687E7).withOpacity(0.5)),
        child: const Text(
          'Login',
          style:
              TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Lato'),
        ),
      ),
    );
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 45, bottom: 40),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: const Color(0xff979797),
            ),
          ),
          Text(
            "or".tr(),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: const Color(0xff979797),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialRegister() {
    return Column(
      children: [
        _buildAppleButtonLogin(),
        _buildGoogleButtonLogin(),
      ],
    );
  }

  Widget _buildAppleButtonLogin() {
    return Container(
      height: 48,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(color: Color(0xFF8875FF), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/apple.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              'Register with Apple',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Lato'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleButtonLogin() {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              'Register with Google',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Lato'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHaveAccount(BuildContext context) {
    // use richText
    return RichText(
      text: TextSpan(
        text: "Already have an account? ".tr(),
        style: const TextStyle(
            color: Color(0xff979797),
            fontSize: 14,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Login".tr(),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 14,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // navigate to register page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
          ),
        ],
      ),
    );
  }
  //   return Container(
  //     margin: const EdgeInsets.only(top: 20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           "Don't have an account?".tr(),
  //           style: TextStyle(
  //               color: Colors.white.withOpacity(0.87),
  //               fontSize: 16,
  //               fontFamily: 'Lato',
  //               fontWeight: FontWeight.bold),
  //         ),
  //         TextButton(
  //           onPressed: () {},
  //           child: Text(
  //             "Register".tr(),
  //             style: const TextStyle(
  //                 color: Color(0xFF8875FF),
  //                 fontSize: 16,
  //                 fontFamily: 'Lato',
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
