import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailControler = TextEditingController();
  final _userNameControler = TextEditingController();
  final _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please fill in email address';
                }
                return null;
              },
              controller: _emailControler,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please fill in userName';
                }
                return null;
              },
              controller: _userNameControler,
              decoration: const InputDecoration(
                label: Text('User Name'),
              ),
              obscureText: true,
            ),
            TextFormField(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please fill in password';
                }
                return null;
              },
              controller: _passwordControler,
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                final isValid = _formKey.currentState?.validate();
                if (isValid != true) {
                  return;
                }
                final email = _emailControler.text;
                final password = _passwordControler.text;
                final userName = _userNameControler.text;
                final res = await Supabase.instance.client.auth
                    .signUp(email, password, userMetadata: {
                  "username": userName,
                });
                final error = res.error;
                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(error.message),
                        backgroundColor: Colors.red),
                  );
                  return;
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailControler.dispose();
    super.dispose();
  }
}
