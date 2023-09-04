import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Config/property.dart';
import '../Landing/phone_screen.dart';
import 'singin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                Image.asset(mainImageLogo1),
                SizedBox(
                  height: getHeight(context, 10),
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: mainFontMontserrat6,
                    fontSize: getWidth(context, 5), 
                    color: mainColorGrey),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneScreen()),
                    );
                  },
                  icon: Icon(
                    FontAwesomeIcons.phone,
                    color: mainColorWhite,
                    size: 16,
                  ),
                  label: Text(
                    'Login with phone number',
                    style: TextStyle(
                      fontFamily: mainFontMontserrat4,
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
                  "or Sign up with",
                  style: TextStyle(
                    fontFamily: mainFontMontserrat4,
                    color: mainColorGrey,
                    ),
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
                    'Login with Faecbook',
                    style: TextStyle(
                      fontFamily: mainFontMontserrat4,
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
                    'Login with Google',
                    style: TextStyle(
                      fontFamily: mainFontMontserrat4,
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
                    'Login with Aplle',
                    style: TextStyle(
                      fontFamily: mainFontMontserrat4,
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
                      "Don't have an Account? ",
                      style: TextStyle(
                        fontFamily: mainFontMontserrat4,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: mainFontMontserrat6,
                          color: mainColorRed,
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
