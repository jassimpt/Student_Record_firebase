import 'package:flutter/material.dart';
import 'package:student_record/views/signupscreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'Password'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.7,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(30)),
            child: const Center(
                child: Text(
              "Login Now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No Account? "),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ));
                },
                child: const Text(
                  'Create Now',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
