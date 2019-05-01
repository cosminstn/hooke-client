import 'package:flutter/material.dart';
import 'package:hooke/common_widgets/HookeLogo.dart';
import 'package:hooke/utils/Utils.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState(); 
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

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
      child: HookeLogo(),
    );

    final usernameField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: usernameController,
        style: TextStyle(fontSize: 18),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please choose a username!';
          }
          else if (value.length < 8) 
            return 'Your username is too short! Min length is 8 chars.';
          else if (_isUsernameAlreadyTaken(value.trim()))
            return 'This username is already taken!';
        },
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
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a password of min 8 characters!';
          }
          else if (value.length < 8) {
            return 'Your password is too short(min length 8 chars)!';
          }
        },
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
        validator: (value) {
          if (value.isEmpty) {
            return 'Please confirm you password';
          }
          else if (value != passwordController.text) {
            return 'Invalid password confirmation!';
          }
        },
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
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value.isEmpty || value.trim().length == 0) {
            return 'Please enter your first name!';
          }
        },
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
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value.isEmpty || value.trim().length == 0) {
            return 'Please enter your last name!';
          }
        },
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
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your email!';
          }
          else if (!Utils.isEmailValid(value.trim()))
            return 'Invalid email!';
        },
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
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your phone number!';
          }
        },
        decoration: InputDecoration(
            labelText: 'Enter your phone number',
            hintText: '+40 712 345 678',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final registerBtn = Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.red,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Register',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              // If the form is valid, we want to show a Snackbar
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(content: Text("Valid form!"));
                  });
            }
            else {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text("Invalid data!"));
                }
              );
            }
          },
        )
      );

    return Scaffold(
      appBar: AppBar(title: Text('Create a hooke account')),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Form(
          key: _formKey,
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
              phoneField,
              registerBtn
            ],
          )
        )
      )
    );
  }

  bool _isUsernameAlreadyTaken(String username) {
    return false;
  }
}