import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:athome/Landing/complate_account.dart';
import 'package:flutter/services.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import '../Config/property.dart';

class OtpScreen extends StatefulWidget {
   String phone_number="";

  OtpScreen( 
    {required this.phone_number}
  );
  @override
 
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  ///  Otp pin Controller
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
@override
  void initState() {
    verfyphone();
    super.initState();
  }
String code="";
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColorWhite,
        leading: IconButton(onPressed: (){
      Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: mainColorRed,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
      
          children: [
            Row(
              children: [
                Text(
                  "We have sent an   ",
                  style: TextStyle(
                    fontSize: getWidth(context, 7),
                  ),
                ),
                Text(
                  " OTP ",
                  style: TextStyle(
                    fontSize: getWidth(context, 7),
                    color:mainColorRed
                  ),
                ),
              ],
            ),
            Text(
              "to your Mobile",
              style: TextStyle(
                fontSize: getWidth(context, 7),
              ),
            ),
            SizedBox(
              height: getHeight(context, 3),
            ),
            Text(
              "Please check your mobile number",
              style: TextStyle(
                fontSize: getWidth(context, 4),
              ),
              textDirection: TextDirection.ltr,
            ),
            Text(
              " 075x xxx xxxx confirm",
              style: TextStyle(
                fontSize: getWidth(context, 4),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
      
      
            OtpPinField(
              
              key: _otpPinFieldController,
              autoFillEnable: false,
              
              textInputAction: TextInputAction.done,
              onSubmit: (text) {
             //verifySmsCode();
              },
              onChange: (text) {
                code=text;
              },
              onCodeChanged: (code) {},
      
              /// to decorate your Otp_Pin_Field
              otpPinFieldStyle: OtpPinFieldStyle(
                
                /// border color for inactive/unfocused Otp_Pin_Field
                defaultFieldBorderColor: mainColorLightGrey,
      
                /// border color for active/focused Otp_Pin_Field
                activeFieldBorderColor: mainColorLightGrey,
      
                /// Background Color for inactive/unfocused Otp_Pin_Field
                defaultFieldBackgroundColor: mainColorLightGrey,
      
                /// Background Color for active/focused Otp_Pin_Field
                //activeFieldBackgroundColor: Colors.cyanAccent,
      
                /// Background Color for filled field pin box
                //filledFieldBackgroundColor: Colors.green,
      
                /// border Color for filled field pin box
                //filledFieldBorderColor: Colors.green,
              ),
              maxLength: 6,
              showCursor: true,
              cursorColor: mainColorRed,
              showCustomKeyboard: false,
              showDefaultKeyboard: true,
              cursorWidth: 3,
      
              /// to select cursor width
              mainAxisAlignment: MainAxisAlignment.center,
              otpPinFieldDecoration:
                  OtpPinFieldDecoration.defaultPinBoxDecoration,
                  
                  
            ),
      
            const SizedBox(
              height: 30,
            ),
      
            SizedBox(
              width: getWidth(context, 75),
              height: getHeight(context, 7),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: mainColorRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
                onPressed: () {
          verifySmsCode();
                  
                },
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: getWidth(context, 6),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: getHeight(context, 2),),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't Receive ? ",
                  style: TextStyle(
                    fontSize: getWidth(context, 4),
                  ),
                ),
                Text(
                  "Click Here",
                  style: TextStyle(
                    fontSize: getWidth(context, 4),
                    color:mainColorRed
                  ),
                ),
              ],
            ),
      
            Image.asset(
                  'assets/images/004_chat_1.png',
                  width: getWidth(context, 50),
                  fit: BoxFit.cover,
                ),
      
      
          ],
        ),
      ),
    );
  }
  FirebaseAuth _auth= FirebaseAuth.instance;
  String _verificationId = '';
  Future<void> verfyphone() async {  
    await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: widget.phone_number,
  verificationCompleted: (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CompleteAccount()),
                  );
  },
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: (String verificationId, int? resendToken) {
     setState(() {
          _verificationId = verificationId;
        });
  },
  codeAutoRetrievalTimeout: (String verificationId) {},
);
  }
  Future<void> verifySmsCode() async {
    print(code);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: code,
    );
   
    try {
      await _auth.signInWithCredential(credential);
Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CompleteAccount()),
                  );
     
    } catch (e) {
      setState(() {
     print(e);
      });
    }
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
