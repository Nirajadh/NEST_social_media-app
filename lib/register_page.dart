import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/mybutton.dart';
import 'package:social_media/mytextfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? ontap;
  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  void registeruser() async {
  

    if (passwordcontroller.text != confirmpasswordcontroller.text) {
   

      print('error');
    } else {
      try {
        // ignore: unused_local_variable
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text, password: passwordcontroller.text);
        createuserdocument(userCredential);
        // ignore: use_build_context_synchronously
 if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
    
        print(e);
      }
      
    }
  }

  Future<void> createuserdocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.email)
          .set({
        'email': emailcontroller.text,
        'username': usernamecontroller.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inverseSurface),
              const SizedBox(
                height: 15,
              ),
              Text(
                'N E S T',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 40,
              ),
              Mytextfield(
                  hintText: 'Username',
                  controller: usernamecontroller,
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              Mytextfield(
                  hintText: 'Email',
                  controller: emailcontroller,
                  obscureText: false),
              const SizedBox(
                height: 5,
              ),
              Mytextfield(
                  hintText: 'Password',
                  controller: passwordcontroller,
                  obscureText: true),
              const SizedBox(
                height: 5,
              ),
              Mytextfield(
                  hintText: 'Confirm Password',
                  controller: confirmpasswordcontroller,
                  obscureText: true),
              const SizedBox(
                height: 5,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(
              //       'Forgot password?',
              //       style: TextStyle(
              //           fontSize: 10,
              //           color: Theme.of(context).colorScheme.secondary),
              //     )
              //   ],
              // ),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                  text: 'Register',
                  ontap: () {
                    registeruser();
                  }),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                      onTap: widget.ontap,
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
