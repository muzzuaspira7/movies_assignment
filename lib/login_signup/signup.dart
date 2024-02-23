import 'package:flutter/material.dart';
import 'package:movies_assignment/login_signup/login.dart';
import 'package:movies_assignment/reusableWidget/reusableTextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // late String selectedProfession;

  void _signUp(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // Dummy sign-up validation
    if (name.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        email.endsWith('@gmail.com')) {
      // Save sign-up data for the new user using email as the key
      await prefs.setString(email, password);

      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incomplete Form'),
            content: const Text('Please fill all the fields.'),
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
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Sign Up',
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
                leadingIcon: Icons.person,
                keyboardType: TextInputType.name,
                textController: nameController,
                labelText: 'Name',
                hintText: 'Enter Your name',
                isPassword: false,
              ),
              const SizedBox(
                height: 8,
              ),

              ReusableTextField(
                leadingIcon: Icons.phone,
                keyboardType: TextInputType.number,
                textController: phoneNumberController,
                labelText: 'Number',
                hintText: 'Enter Your Number',
                isPassword: false,
              ),
              const SizedBox(
                height: 8,
              ),

              ReusableTextField(
                leadingIcon: Icons.email,
                textController: emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                hintText: 'Enter Your email',
                isPassword: false,
              ),
              const SizedBox(
                height: 8,
              ),

              ReusableTextField(
                leadingIcon: Icons.password,
                textController: passwordController,
                labelText: 'Password',
                hintText: 'Enter Your password',
                keyboardType: TextInputType.name,
                isPassword: true,
              ),
              const SizedBox(
                height: 8,
              ),
              // DropdownButtonFormField(
              //   value: selectedProfession,
              //   onChanged: (newValue) {
              //     selectedProfession = newValue!;
              //   },
              //   items: professions.map((profession) {
              //     return DropdownMenuItem(
              //       value: profession,
              //       child: Text(profession),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(
              //     labelText: 'Profession',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              const SizedBox(height: 20.0),
              // Text('Go back to Login Screen'),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blue[200])),
                  onPressed: () => _signUp(context),
                  child: const Text('SignUp'),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Text(
                    'Go back to Login Screen',
                    style: TextStyle(color: Colors.blue[50]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
