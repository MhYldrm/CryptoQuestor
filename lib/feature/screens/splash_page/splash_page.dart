import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../product/navigation/app_router.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.router.push(const SignInRoute());
                },
                child: const Text("Sign In"),
              ),
              TextButton(
                onPressed: () {
                  context.router.push(const SignUpRoute());
                },
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
