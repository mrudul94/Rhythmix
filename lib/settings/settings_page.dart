import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:rhythmix/Settings/privacy_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double rating = 0.0;
  @override
  void initState() {
    super.initState();
    _fetchRating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          const ListTile(
            leading: Text(
              'General Settings',
              style: TextStyle(
                color: Color.fromARGB(255, 187, 183, 183),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const PrivacyPolicy()));
              },
              child: const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 63, 63),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                subtitle: Text(
                  'Please review our Privacy Policy carefully to understand how we collect, use, and safeguard your personal information.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 109, 108, 108),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )),
          const SizedBox(height: 20),
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Rate Us'),
                      content: SizedBox(
                        width: 250,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Would you like to rate our app?'),
                            const SizedBox(height: 20),
                            RatingBar.builder(
                              initialRating: rating,
                              minRating: 1,
                              itemSize: 35,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (value) {
                                setState(() {
                                  rating = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            _storeRating(rating);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const ListTile(
                title: Text(
                  'Rate Us',
                  style: TextStyle(
                    color: Color.fromARGB(255, 237, 63, 63),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Kindly take a moment to rate our service. Your feedback helps us improve and provide you with a better experience.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 109, 108, 108),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          const ListTile(
            title: Text(
              'Acceptance',
              style: TextStyle(
                color: Color.fromARGB(255, 237, 63, 63),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: ReadMoreText(
              "By downloading our app, playing music, sharing files, playing video, or otherwise accessing or using our services, you are agreeing to the terms outlined in this Agreement and consenting to contract with us electronically. We reserve the right to revise and update this Agreement at our sole discretion, and we will notify you of any changes. Your continued use of our services constitutes acceptance of the updated version of this Agreement.",
              trimLines: 3,
              style: TextStyle(
                color: Color.fromARGB(255, 109, 108, 108),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              colorClickableText: Colors.red,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          const SizedBox(height: 30),
          const ListTile(
            title: Text(
              'Our Services',
              style: TextStyle(
                color: Color.fromARGB(255, 237, 63, 63),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 10),
              child: ReadMoreText(
                "We grant you access to our services, allowing you to utilize our app for various functionalities such as playing music, sharing files, and more. Explore the diverse features we offer to enhance your experience.",
                trimLines: 3,
                style: TextStyle(
                  color: Color.fromARGB(255, 109, 108, 108),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                colorClickableText: Colors.red,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<void> _fetchRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rating = prefs.getDouble('userRating') ?? 0;
    });
  }

  Future<void> _storeRating(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('userRating', value);
  }
}
