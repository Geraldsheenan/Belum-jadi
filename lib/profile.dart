import 'package:flutter/material.dart';
import 'package:latlogin/editprofile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Profile Picture and Name
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Sheenan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'sheenan@gmail.com',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Profile Options
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            subtitle: Text('Update your personal information'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            subtitle: Text('Update your account password'),
            onTap: () {
              // Add logic for changing password
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            subtitle: Text('Manage your notification preferences'),
            onTap: () {
              // Add logic to navigate to Notifications settings
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
