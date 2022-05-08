import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:why_appen/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:why_appen/widgets/palatte.dart';
import 'package:why_appen/widgets/backround.dart';
import '../auth_service.dart';

class CreateUser extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[600]?.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    hintStyle: kBodytext,
                                  ),
                                  style: kBodytext,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: emailController,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[600]?.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    border: InputBorder.none,
                                    hintText: 'lösenord',
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    hintStyle: kBodytext,
                                  ),
                                  style: kBodytext,
                                  textInputAction: TextInputAction.next,
                                  controller: passwordController,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[600]?.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    border: InputBorder.none,
                                    hintText: 'Validera lösenord',
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    hintStyle: kBodytext,
                                  ),
                                  style: kBodytext,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  controller: passwordController1,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if(passwordController.text.trim() == passwordController1.text.trim()){
                                    context.read<AuthenticationService>().signUp(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    Fluttertoast.showToast(msg: "Konto tillagt");

                                  } else {
                                      Fluttertoast.showToast(msg: "Löesnorden matchar inte");
                                  }

                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'Skapa konto',
                                    style: kBodytext,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
