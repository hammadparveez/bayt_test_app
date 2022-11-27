import 'package:bayt_test_app/model/repository/auth_repo.dart';
import 'package:bayt_test_app/provider/auth_provider.dart';
import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/ui/base_widiget/loader_dialog.dart';
import 'package:bayt_test_app/ui/base_widiget/message_dialog.dart';
import 'package:bayt_test_app/ui/base_widiget/text_field.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  late final AuthProvider _authProvider;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _authProvider.addListener(_eventListener);
  }

  @override
  void dispose() {
    _authProvider.removeListener(_eventListener);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _eventListener() {
    final authProvider = context.read<AuthProvider>();

    switch (authProvider.authStatus) {
      case AuthStatus.loading:
        showDialog(
            context: context,
            builder: (_) => const Loader(
                  title: 'Authenticating...',
                ));
        break;
      case AuthStatus.authenticated:
        Navigator.pushNamedAndRemoveUntil(
            context, ByatRoute.home, (_) => false);

        break;
      case AuthStatus.failure:
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => MessageDialog(
                title: authProvider.errorMsg ?? 'Failed to Authenticate'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 8),
            Text('app_title'.tr(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('sign_in'.tr(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700))),
            const SizedBox(height: 20),
            ByatTextField(
                hintText: 'example@byat.com',
                controller: emailController,
                prefixIcon: const Icon(Icons.email)),
            const SizedBox(height: 20),
            ByatTextField(
                isPassword: true,
                controller: passwordController,
                prefixIcon: const Icon(Icons.lock)),
            Align(
              alignment: context.locale.languageCode == 'en'
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    if (context.locale.languageCode == 'en') {
                      context.setLocale(Locale('ar'));
                    } else {
                      context.setLocale(Locale('en'));
                    }
                  },
                  child: Text('lang'.tr())),
            ),
            const SizedBox(height: 8),
            Consumer<AuthProvider>(builder: (context, authProvider, child) {
              return FractionallySizedBox(
                widthFactor: .7,
                child: ByatElevatedButton(
                  title: 'sign_in'.tr(),
                  onTap: () {
                    authProvider.login(emailController.text,passwordController.text);
                  },
                  hasSuffixIcon: true,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
