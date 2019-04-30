import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  static String tag = 'register';

  RegisterPage({Key key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final logo = Padding(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Text(
        "hooke",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'ComicSans', fontSize: 100, color: Colors.red),
      ),
    );

    final usernameField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: usernameController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your username',
            hintText: 'john.doe',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final passwordField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your password',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final confirmPasswordField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: confirmPasswordController,
        obscureText: true,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Confirm your password',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final firstNameField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: firstNameController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your first name',
            hintText: 'John',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final lastNameField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: lastNameController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your last name',
            hintText: 'Doe',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final emailField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: emailController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your email',
            hintText: 'john.doe@email.com',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final phoneField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        autofocus: false,
        controller: phoneController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your phone number',
            hintText: '+40 712 345 678',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            logo,
            usernameField,
            passwordField,
            confirmPasswordField,
            firstNameField,
            lastNameField,
            emailField,
            phoneField
          ],

        )
      )
    );
  }
}