import 'package:flutter/material.dart';
import 'package:athome/configuration.dart';
import 'package:athome/landing/otp_screen.dart';



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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [
    
    
            const SizedBox(height: 150,),
        
            const Text(
              "Add Your",
              style: TextStyle(fontSize: 25,),
            ),
        
            const SizedBox(height: 15,),
        
            const Text(
              "Phone Number",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
        
            const SizedBox(height: 30,),
        
            Center(
              child: Container(
                width: getWidth(context, 75),
                height: getHeight(context, 7),
                
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: getWidth(context, 15),
                      child: TextField(
                        style: const TextStyle(fontSize: 20),
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
                    const Expanded(
                        child: TextField(
                          style: TextStyle(fontSize: 20),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "7 - -  - - -  - - - -",
                      ),
                    ),),
                  ],
                ),
              ),
            ),
            const SizedBox( height: 30,),
            SizedBox(
              width: getWidth(context, 75),
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
                  child: Text("Send",style: TextStyle(fontSize: getWidth(context, 6),),),),
            ),
          ],
        ),
      ),
    );
  }
}