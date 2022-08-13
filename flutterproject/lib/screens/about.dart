import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class about extends StatefulWidget {
  about({Key key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  _launchPhone() async {
    String url = "tel:97817985";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchUrl() async {
    String url = "mailto:SGAroundU@gmail.com";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage("images/Logo.jpg"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 330,
                    child: Column(
                      children: [
                        Text(
                          "We Strive to give you a leisureless experience finding places to travel around in singapore",
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Contact Us at ",
                                style: TextStyle(fontSize: 18)),
                            GestureDetector(
                              onTap: _launchPhone,
                              child: Text(
                                '97817985',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Email Us At ",
                                style: TextStyle(fontSize: 18)),
                            GestureDetector(
                              onTap: _launchUrl,
                              child: Text(
                                'SGAroundU@gmail.com',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
