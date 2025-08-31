import 'package:app/modules/chat/components/primary_button.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../chats/chats_screen.dart';

class SigninOrSignupScreen extends StatelessWidget {
  const SigninOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset(
                  'assets/animations/Message.json',
                ),
              ),
              /*Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? "assets/images/Logo_light.png"
                    : "assets/images/Logo_dark.png",
                height: 146,
              ),*/
              const Spacer(),
              PrimaryButton(
                text: "Iniciar",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatsScreen(),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                color: Colors.grey,
                //color: Theme.of(context).colorScheme.secondary,
                text: "Registro",
                press: () {},
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
