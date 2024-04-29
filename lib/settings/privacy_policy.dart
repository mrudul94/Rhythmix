import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Privacy & policy'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                "How We Collect And Use Your  Personal Data",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, // Set your desired font size
                    color: Color.fromARGB(
                        255, 240, 236, 236), // Set your desired text color
                  ),
                  children: [
                    TextSpan(
                      text: 'Non-Personal Information. ',
                    ),
                    TextSpan(
                      text:
                          'We may utilize non-personal information (such as Usage Data/Log Data, including your devices internet protocol ("IP") address, device name, operating system version, etc.) for the following purposes:',
                      style: TextStyle(
                        fontStyle:
                            FontStyle.italic, // Example of using italic style
                        color: Colors
                            .red, // Example of using a different text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, // Set your desired font size
                    color: Color.fromARGB(
                        255, 240, 236, 236), // Set your desired text color
                  ),
                  children: [
                    TextSpan(
                      text: 'Retention. ',
                    ),
                    TextSpan(
                      text:
                          'We will retain usage data for internal analysis purposes. Usage data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of our service, or when we are legally obligated to retain this data for longer time periods.',
                      style: TextStyle(
                        fontStyle:
                            FontStyle.italic, // Example of using italic style
                        color: Colors
                            .red, // Example of using a different text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, // Set your desired font size
                    color: Color.fromARGB(
                        255, 240, 236, 236), // Set your desired text color
                  ),
                  children: [
                    TextSpan(
                      text: 'Security . ',
                    ),
                    TextSpan(
                      text:
                          'We use administrative, technical, and physical security measures to safeguard your personal data. While we prioritize the security of your personal data, its important to note that no method of transmission over the internet or electronic storage is 100% secure. Despite our efforts to utilize commercially acceptable means to protect your personal data, we cannot guarantee its absolute security.',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 240, 236, 236),
                  ),
                  children: [
                    TextSpan(
                      text: 'Changes to This Privacy Policy: ',
                    ),
                    TextSpan(
                      text:
                          'We may update our Privacy Policy from time to time. Thus, we advise you to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 240, 236, 236),
                  ),
                  children: [
                    TextSpan(
                      text: 'Contact Us. ',
                    ),
                    TextSpan(
                      text:
                          'If you want further information about our privacy policy and what it means, please feel free to email us at ',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(
                      text: 'mrudulp2002@gamil.com',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
            // Padding(
            //     padding: const EdgeInsets.only(top: 30),
            //     child: Text(
            //       'Retention',
            //       style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            //     )),
            //      Padding(
            //     padding: const EdgeInsets.only(top: 30),
            //     child: Text(
            //       '',
            //       style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            //     )),
          ],
        ),
      ),
    );
  }
}
