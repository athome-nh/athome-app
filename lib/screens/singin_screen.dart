import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../configuration.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(mainImagePattern,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign up',
                  style: TextStyle(
                      fontSize: getWidth(context, 5), color: mainColorGrey),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.phone,
                    color: mainColorWhite,
                    size: 16,
                  ),
                  label: Text(
                    '  Sign up with phone number',
                    style: TextStyle(
                      color: mainColorWhite,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColorRed,
                    fixedSize:
                        Size(getWidth(context, 85), getHeight(context, 7)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 3),
                ),
                Text(
                  "or Login with",
                  style: TextStyle(color: mainColorGrey),
                ),
                SizedBox(
                  height: getHeight(context, 3),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    color: mainColorWhite,
                    size: 16,
                  ),
                  label: Text(
                    '  Sign up with Faecbook',
                    style: TextStyle(
                      color: mainColorWhite,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainFacebookColor,
                    fixedSize:
                        Size(getWidth(context, 85), getHeight(context, 7)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 3),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.googlePlusG,
                    color: mainColorWhite,
                    size: 16,
                  ),
                  label: Text(
                    '  Sign up with Google',
                    style: TextStyle(
                      color: mainColorWhite,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGoogleColor,
                    fixedSize:
                        Size(getWidth(context, 85), getHeight(context, 7)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 3),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.apple,
                    color: mainColorWhite,
                    size: 16,
                  ),
                  label: Text(
                    '  Sign up with Aplle',
                    style: TextStyle(
                      color: mainColorWhite,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColorBlack,
                    fixedSize:
                        Size(getWidth(context, 85), getHeight(context, 7)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account? ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: mainColorRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
