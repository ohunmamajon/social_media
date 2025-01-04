import 'package:flutter/material.dart';
import 'package:social_media/features/auth/presentation/components/my_button.dart';
import 'package:social_media/features/auth/presentation/components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPWController = TextEditingController(); 
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
                  "Let's create an account for you",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),

                // user name
                MyTextField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false),
                const SizedBox(height: 10),

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

                    const SizedBox(height: 10),

                // confirm pw textfield
                MyTextField(
                    controller: confirmPWController,
                    hintText: "Confirm password",
                    obscureText: true),

                const SizedBox(height: 25),

                // Register button
                MyButton(onTap: () {}, 
                text: "Register",
                ),
             const SizedBox(height: 50),

                // already a member? login now
                Text("Already a member? Login now", 
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
