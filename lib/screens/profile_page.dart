import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../GetX_controller/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() => controller.userData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(controller.user?.photoURL ??
                          'https://via.placeholder.com/150'), // Placeholder image
                    ),
                    SizedBox(height: 16),
                    Text(
                      controller.userData['name'] ?? 'N/A',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      controller.userData['email'] ?? 'N/A',
                      style: TextStyle(fontSize: 18, color: Colors.white54),
                    ),
                    SizedBox(height: 24),
                    Divider(thickness: 1, color: Colors.white54),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.white),
                      title: Text('Full Name',
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(controller.userData['name'] ?? 'N/A',
                          style: TextStyle(color: Colors.white70)),
                    ),
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.white),
                      title:
                          Text('Email', style: TextStyle(color: Colors.white)),
                      subtitle: Text(controller.userData['email'] ?? 'N/A',
                          style: TextStyle(color: Colors.white70)),
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFa343c9),
                            const Color(0xFFc25457),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.signOut();
                        },
                        child: Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}
