import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../reusableWidget/reusableTextfield.dart';
import 'signup.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    // Retrieve user data for the entered email
    String savedPassword = prefs.getString(enteredEmail) ?? '';

    // Check if the entered password matches the saved password
    if (enteredPassword == savedPassword) {
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Wrong Credentials'),
            content: const Text('Please enter valid email and password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color.fromARGB(255, 67, 188, 245), Colors.black],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ReusableTextField(
                leadingIcon: Icons.email,
                textController: emailController,
                labelText: 'Enter Mail',
                hintText: 'Email Id',
                keyboardType: TextInputType.emailAddress,
                isPassword: false,
              ),
              const SizedBox(
                height: 10,
              ),
              ReusableTextField(
                leadingIcon: Icons.password,
                textController: passwordController,
                labelText: 'Password',
                hintText: 'Enter Password',
                keyboardType: TextInputType.name,
                isPassword: true,
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue[200]),
                  ),
                  onPressed: () => _login(context),
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text(
                  'Are you a new user? Sign up here.',
                  style: TextStyle(color: Colors.blue[100]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
