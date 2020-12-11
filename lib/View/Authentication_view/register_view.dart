import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FireBaseAuthService>(context, listen: false);
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        labelText: "Email", prefixIcon: Icon(Icons.email)),
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        labelText: "Full name", prefixIcon: Icon(Icons.person)),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock_outline)),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      UserEntity userEntity = UserEntity(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        userType: client,
                      );
                      authService.register(userEntity).then((value) {
                        if (value == true) print("success");
                      });
                    },
                    child: Text("Register"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account? ",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('LoginView');
                        },
                        child: Text(
                          "Login here.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
