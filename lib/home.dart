import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Facebook Signin'),
        ),
        body: isLoggedIn
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(_userObj['picture']['data']['url']),
                  Text(_userObj['name']),
                  Text(_userObj['email']),
                  TextButton(
                      onPressed: () {
                        FacebookAuth.instance.logOut().then((value) {
                          setState(() {
                            isLoggedIn = false;
                            _userObj = {};
                          });
                        });
                      },
                      child: Text('Log Out'))
                ],
              )
            : Center(
                child: ElevatedButton(
                    onPressed: () async {
                      FacebookAuth.instance
                          .login(permissions: ['public_profile', 'email']).then(
                              (value) {
                        FacebookAuth.instance.getUserData().then((userData) {
                          setState(() {
                            isLoggedIn = true;
                            _userObj = userData;
                          });
                        });
                      });
                    },
                    child: Text('Log in with facebook')),
              ));
  }
}
