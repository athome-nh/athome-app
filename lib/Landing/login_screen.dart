import 'package:flutter/material.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Landing/otp_screen.dart';



class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    countryController.text = "+964";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColorWhite,
          leading: IconButton(onPressed: (){
        Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios,color: mainColorRed,)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [


             Image.asset(mainImageLogo1),
    
    
            SizedBox(height: getHeight(context, 10),),
        
            Text(
              "Dwaye si3araki jwan danosin lera",
              style: TextStyle(fontSize: 20,fontFamily: mainFontMontserrat6),
            ),
        
            SizedBox(height: getHeight(context, 1),),
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Enter your phone number & we'll get started!",
                style: TextStyle(fontSize: 10,fontFamily: mainFontMontserrat4),
              ),
            ),

            Center(
              child: Container(
                width: getWidth(context, 85),
                height: getHeight(context, 7),
                
                decoration: BoxDecoration(
                    //border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                    color: mainColorLightGrey,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: getWidth(context, 15),
                      child: TextField(
                        enabled: false,
                        style: TextStyle(fontSize: 20,fontFamily: mainFontMontserrat4,color: mainColorGrey),
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(

                         style: TextStyle(fontSize: 20,fontFamily: mainFontMontserrat4,color: mainColorGrey),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        //suffixIcon: Icon(Icons.phone_android_outlined),
                        border: InputBorder.none,
                        hintText: "07xx xxx xxxx",
                      ),
                      
                    ),),
                  ],
                ),
              ),
            ),
            SizedBox( height: getHeight(context, 3),),
            SizedBox(
              width: getWidth(context, 85),
              height: getHeight(context, 7),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainColorRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  const OtpScreen()),
                    );
                  },
                  child: Text("Send",style: TextStyle(fontSize: getWidth(context, 6),fontFamily: mainFontMontserrat6),),),
            ),

            SizedBox(
                  height: getHeight(context, 2),
                ),


                // Text(
                //   "or Get Started with",
                //   style: TextStyle(
                //     fontFamily: mainFontMontserrat4,
                //     color: mainColorGrey,
                //     ),
                // ),
               
                SizedBox(
                  height: getHeight(context, 2),
                ),
                // ElevatedButton.icon(
                //   onPressed: () {},
                //   icon: Icon(
                //     FontAwesomeIcons.googlePlusG,
                //     color: mainColorWhite,
                //     size: 16,
                //   ),
                //   label: Text(
                //     'Login with Google',
                //     style: TextStyle(
                //       fontFamily: mainFontMontserrat4,
                //       color: mainColorWhite,
                //       fontSize: 16,
                //     ),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: mainGoogleColor,
                //     fixedSize:
                //         Size(getWidth(context, 85), getHeight(context, 7)),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: getHeight(context, 3),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () {},
                //   icon: Icon(
                //     FontAwesomeIcons.apple,
                //     color: mainColorWhite,
                //     size: 16,
                //   ),
                //   label: Text(
                //     'Login with Aplle',
                //     style: TextStyle(
                //       fontFamily: mainFontMontserrat4,
                //       color: mainColorWhite,
                //       fontSize: 16,
                //     ),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: mainColorBlack,
                //     fixedSize:
                //         Size(getWidth(context, 85), getHeight(context, 7)),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
          ],
        ),
      ),
    );
  }
}