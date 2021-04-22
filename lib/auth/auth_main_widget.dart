import 'package:courier_prototype/api_work/api_worker.dart';
import 'package:flutter/material.dart';

class AuthMainWidget extends StatefulWidget {
  @override
  _AuthMainWidgetState createState() => _AuthMainWidgetState();
}

class _AuthMainWidgetState extends State<AuthMainWidget> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  _login() {
    login(
        LoginDto(
            Login: loginController.text, Password: passwordController.text),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: 'login',
                style: TextStyle(color: Color.fromARGB(255, 255, 105, 0), fontSize: 20),
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
                color: Color.fromARGB(0, 255, 105, 0),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: Color.fromARGB(255, 255, 105, 0), width: 3),
              ),
            ),
            Text(' '),
            RichText(
              text: TextSpan(
                text: 'password',
                style: TextStyle(color: Color.fromARGB(255, 255, 105, 0), fontSize: 20),
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
                color: Color.fromARGB(0, 255, 105, 0),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: Color.fromARGB(255, 255, 105, 0), width: 3),
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
                              text: 'SIGN IN',
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
