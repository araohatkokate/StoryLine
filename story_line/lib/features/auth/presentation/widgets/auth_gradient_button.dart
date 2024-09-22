import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {}, 
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(395, 55),
        ),  
      child: const Text('Sign Up'),
      );
  }
}