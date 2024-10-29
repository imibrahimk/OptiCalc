import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constant/colour.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  // For call developer
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  // For email developer

  // For go developer FB profile
  Future<void> _openFacebookProfile(String profileUrl) async {
    // Facebook app URL scheme
    final Uri fbProtocolUrl = Uri.parse('fb://facewebmodal/f?href=$profileUrl');

    // Browser fallback URL
    final Uri fallbackUrl = Uri.parse(profileUrl);

    // Try launching Facebook app URL
    if (await canLaunchUrl(fbProtocolUrl)) {
      await launchUrl(fbProtocolUrl);
    }
    // Fallback to browser if app is not installed
    else if (await canLaunchUrl(fallbackUrl)) {
      await launchUrl(fallbackUrl);
    } else {
      throw 'Could not launch $profileUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colour.backGround,
        title: const Text('About Developer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/staff/khalil.png'),
            ),
            const SizedBox(height: 20),

            const Text(
              'MD. IBRAHIM KHALIL',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Flutter Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.phone,
                    size: 30.0,
                  ),
                  onPressed: () => _makePhoneCall(
                      '+880 1719-875780'), // Add your call functionality
                ),
                IconButton(
                  icon: const Icon(
                    Icons.email,
                    size: 30.0,
                  ),
                  onPressed: () {},
                  // onPressed: () => sendEmail(
                  //     'imibrahimk@yahoo.com'), // Add your email functionality
                ),
                IconButton(
                  icon: const Icon(
                    Icons.facebook,
                    size: 30.0,
                  ),

                  onPressed: () => _openFacebookProfile(
                      'https://www.facebook.com/khalil2k10'), // Add your Facebook link
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Skills Section
            const Text(
              'Skills',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Icon(Icons.android, color: Colors.green, size: 40),
                    Text('Android'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/icon/flutter_icon.png',
                        width: 40), // Replace with Firebase icon
                    const Text('Flutter'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/icon/firebase_icon.png',
                        width: 40), // Replace with PHP icon
                    const Text('Firebase'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Apps Section
            const Text(
              'Apps',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Card(
              child: ListTile(
                leading: Icon(Icons.chat, size: 40),
                title: Text('ChatGPT'),
                subtitle: Text('Find Your Answer'),
              ),
            ),
            const SizedBox(height: 20),

            // Developer Speech
            const Text(
              'Developer Speech',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const Text(
              'I am a passionate Flutter developer with experience in building beautiful and performant mobile applications. I love coding and exploring new technologies.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
