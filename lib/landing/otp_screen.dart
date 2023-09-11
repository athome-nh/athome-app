import 'package:flutter/material.dart';
import 'package:athome/Landing/complate_account.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import '../Config/property.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  ///  Otp pin Controller
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
@override
 
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
      body: Column(
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
            onSubmit: (text) {},
            onChange: (text) {},
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
        
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CompleteAccount()),
                );
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
    );
  }
}
