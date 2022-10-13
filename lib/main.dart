import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(const FacebookApp());
}

class FacebookApp extends StatefulWidget {
  const FacebookApp({super.key});

  @override
  State<FacebookApp> createState() => _FacebookAppState();
}

class _FacebookAppState extends State<FacebookApp> {
  Map? _userData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Facebook (Logged ${_userData == null ? 'out' : 'in'})'),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final result = await FacebookAuth.instance
                      .login(permissions: ["public_profile", "email"]);

                  if (result.status == LoginStatus.success) {
                    final userData = await FacebookAuth.instance.getUserData(
                      fields: "email,name",
                    );

                    setState(() {
                      _userData = userData;
                    });
                  }
                },
                child: const Text('Log In')),
            ElevatedButton(
                onPressed: () async {
                  await FacebookAuth.instance.logOut();

                  setState(() {
                    _userData = null;
                  });
                },
                child: const Text('Log Out')),
          ],
        )),
      ),
    );
  }
}
