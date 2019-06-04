import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooke/common_widgets/HookeLogoText.dart';
import 'package:hooke/common_widgets/HookeLogo.dart';
import 'package:hooke/pages/AdminHomePage.dart';
import 'package:hooke/pages/RegisterPage.dart';
import 'package:hooke/pages/RestaurantHomePage.dart';
import 'package:hooke/pages/RestaurantsListPage.dart';
import 'package:hooke/utils/Constants.dart';
import 'package:hooke/utils/Globals.dart';
import 'package:hooke/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _inProgress = false;

  String username = "";
  String password = "";

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final Logger logger = Logger('LoginPage');

  Widget _buildForm(BuildContext context) {
  
    final logo = Padding(
      padding: EdgeInsets.fromLTRB(100, 32, 100, 0),
      child: HookeLogo()
    );

    final logoText = Padding(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: HookeLogoText(),
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
            hintText: 'Username',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final passwordField = Padding( 
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        controller: passwordController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your password',
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final loginBtn = Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.red,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Log in',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
          onPressed: () {
            username = usernameController.text;
            password = passwordController.text;
            login(context, username, password);
            // Navigator.pushNamed(context, RestaurantDetailsPage.tag);
          },
        ));

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
            Navigator.pushNamed(context, RegisterPage.tag);
          },
        ));
    usernameController.text="anamaria";
    passwordController.text="parolaapp";

    // usernameController.text = 'cosmin97';
    // passwordController.text = 'abcd1234';

    usernameController.text = 'stefan.esanu';
    passwordController.text = 'abcd1234';

    return Center(
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            logo,
            logoText,
            usernameField,
            passwordField,
            loginBtn,
            registerBtn,
          ],
          padding: EdgeInsets.all(10),
        )
    )
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: ModalProgressHUD(child: _buildForm(context), inAsyncCall: _inProgress, dismissible: false,)
      );
  }

  Future<void> login(BuildContext context, String username, String password) async {
    print('please wait while you are being authenticated...');
    setState(() {
      _inProgress = true; 
    });
    var profile;
    if (Constants.LOCAL_DEV_MODE == false)
      profile = await _authUser(username, password);
    else
      profile = _localAuth(username, password);
    setState(() {
      _inProgress = false;
    });
    if (profile == null)
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text('Invalid account'));
        }
      );
    String firstName = profile['firstName'];
    logger.fine('First name: ' + firstName);
    logger.fine('SUCCESSFUL LOGIN!');
    //store the auth token to be used in secured requests later 
    Globals.authToken = Utils.createAuthToken(username, password);
    int roleId = profile['roleId'];
    if (roleId == 5)
      Navigator.pushNamed(context, AdminHomePage.tag, arguments: profile);
    else
     Navigator.pushNamed(context, RestaurantHomePage.tag, arguments:profile);
     //Navigator.pushNamed(context, RestaurantsListPage.tag);
  }

  Future<Map> _authUser(String username, String password) async {
    try {
      http.Client client = new http.Client();
      final response = await client.get(Constants.API_BASE_URL + '/pub/auth/',
                                      headers: {
                                        'APP_TOKEN' : Constants.APP_TOKEN,
                                        'Authorization' : Utils.createAuthToken(username, password)
                                      }).timeout(const Duration(seconds: 3));
      print(response.body);
      if (response.body == null || response.statusCode != 200)
        return null;
      else 
        return json.decode(response.body);
      
        // return compute(parseUser, response.body);
        // compute calls a cast method and doesn't for map
    } catch (ex) {
      logger.severe(ex);
      return null;
    }
  }

  Map<String, dynamic> _localAuth(String username, String password) {
    String localConsumer = '{    "email": "stefanesanu1@gmail.com",    "firstName": "Stefan",    "lastName": "Esanu",    "phoneNumber": "0799999999","roleId": 4}';
    String localManager = '{"email": "contact@citygrill.ro","firstName": "Ioan", "lastName": "Barbu", "phoneNumber": "+40730943111", "roleId": 5}';
    if (username.contains('manager'))
      return json.decode(localManager);
    return json.decode(localConsumer);
  }
}