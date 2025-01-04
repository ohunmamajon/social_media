import 'package:flutter/material.dart';
import 'package:social_media/features/auth/presentation/components/my_button.dart';
import 'package:social_media/features/auth/presentation/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 50),
                // welcome back message

                Text(
                  "Welcome back, you have been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),
                // email textfield
                MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                const SizedBox(height: 10),

                // pw textfield
                MyTextField(
                    controller: pwController,
                    hintText: "Password",
                    obscureText: true),

                const SizedBox(height: 25),

                // login button
                MyButton(onTap: () {}, 
                text: "Login",
                ),
             const SizedBox(height: 50),

                // not a member? register now
                Text("Not a member? Register now", 
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
