import 'package:flutter/widgets.dart';
import '../../helpers/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Name",
                            style: TextStyle(fontSize: 30),
                          ),
                          Divider(color: COLOR_LINK),
                          Text(
                            "youremail@example.com",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60.0),
                const Row(
                  children: [
                    Text(
                      "About Me",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 320.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const SingleChildScrollView(
                    child: Text(
                      """I have noticed that, although Discord has 260 million registered accounts , my server does not have 260 million members. I'm not sure if this is being done intentionally or if these "friends" are forgetting to click 'join'. Either way, I've had enough. I have compiled a spreadsheet of individuals who have "forgotten" to join my most recent servers. After 2 consecutive strikes, your name is automatically highlighted (shown in red) and I am immediately notified. 3 consecutive strikes and you can expect an in-person "consultation". Think about your actions.""",
                      style: TextStyle(
                          fontSize: 14, letterSpacing: 1, height: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32.0,
            left: 12.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Perform delete account action
                  // You can add your logic here to handle the delete account functionality
                },
                icon: const Icon(Icons.delete),
                label: const Text("Delete Account"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
