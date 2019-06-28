import 'package:flutter/material.dart';
import 'package:mesbro/Model/app_data.dart';
import 'package:mesbro/Model/app_methods.dart';
import 'package:mesbro/Model/app_tools.dart';
import 'package:mesbro/Model/firebase_methods.dart';
import 'package:mesbro/UI/signup.dart';


class MesbroLogin extends StatefulWidget {
  @override
  _MesbroLoginState createState() => _MesbroLoginState();
}

class _MesbroLoginState extends State<MesbroLogin> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethod = new FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            appButton(
                btnTxt: "Login",
                onBtnclicked: verifyLogin,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new SignUp()));
              },
              child: new Text(
                "Not Registered? Sign Up Here",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  verifyLogin() async {
    if (email.text == "") {
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
    String response = await appMethod.logginUser(
        email: email.text.toLowerCase(), password: password.text.toLowerCase());
    if (response == successful) {
      closeProgressDialog(context);
      Navigator.of(context).pop(true);
    } else {
      closeProgressDialog(context);
      showSnackBar(response, scaffoldKey);
    }
  }
}
