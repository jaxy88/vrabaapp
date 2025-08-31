import 'package:app/utils/constants.dart';
import '../signinOrSignUp/signin_or_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // Centra horizontal y vertical si Column no ocupa todo
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // centra en eje vertical
            crossAxisAlignment:
                CrossAxisAlignment.center, // centra en eje horizontal
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset(
                  'assets/animations/compliance.json',
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Welcome to our freedom \nmessaging app",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                "Freedom talk any person of your \nmother language.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 32),
              FittedBox(
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SigninOrSignupScreen(),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Skip",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color!,
                            ),
                      ),
                      const SizedBox(width: kDefaultPadding / 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
