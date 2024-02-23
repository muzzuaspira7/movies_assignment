import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_signup/login.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(),
              child: const UserAccountsDrawerHeader(
                  accountName: Text(
                    'Geeksynergy Technologies Pvt Ltd',
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Column(
                    children: [
                      Text('Sanjayanagar, Bangalore-56'),
                      Text('XXXXXXXXX09'),
                      // Text('XXXXXX@gmail.com')
                    ],
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 1,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/workplace-office-with-laptop-coffee-dark-room-night_169016-47422.jpg?w=740&t=st=1708627034~exp=1708627634~hmac=fb8c02a449694a4109969e9b89705ba1833e42b29ab111b3ad96c724ed3db704',
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/workplace-office-with-laptop-coffee-dark-room-night_169016-47422.jpg?w=740&t=st=1708627034~exp=1708627634~hmac=fb8c02a449694a4109969e9b89705ba1833e42b29ab111b3ad96c724ed3db704',
                    ),
                    fit: BoxFit.cover,
                  ))),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
