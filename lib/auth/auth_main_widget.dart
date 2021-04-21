import 'package:courier_prototype/api_work/api_worker.dart';
import 'package:courier_prototype/home_widget.dart';
import 'package:flutter/material.dart';

class AuthMainWidget extends StatefulWidget {
  @override
  _AuthMainWidgetState createState() => _AuthMainWidgetState();
}

class _AuthMainWidgetState extends State<AuthMainWidget> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  _login()
  {
      login(LoginDto(Login:loginController.text,Password:passwordController.text),context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 105, 0),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: 'login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: loginController,
                decoration: InputDecoration(
                  hintText: "Enter",
                  border: InputBorder.none,
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            Text(' '),
            RichText(
              text: TextSpan(
                text: 'password',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Enter",
                  border: InputBorder.none,
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            Text(' '),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: () {
                        _login();
                      },
                      child: RichText(
                          text: TextSpan(
                              text: 'sign in',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
