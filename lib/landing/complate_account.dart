import 'package:flutter/material.dart';
import 'package:athome/Home/NavSwitch.dart';

import '../Config/property.dart';


class CompleteAccount extends StatefulWidget {
  const CompleteAccount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CompleteAccountState createState() => _CompleteAccountState();
}

class _CompleteAccountState extends State<CompleteAccount> {
  String selectedAge = '18'; // Default age selection


  List<DropdownMenuItem<String>> ageItems = [
    const DropdownMenuItem(
      value: '18',
      child: Text('18'),
    ),
    const DropdownMenuItem(
      value: '19',
      child: Text('19'),
    ),
    const DropdownMenuItem(
      value: '20',
      child: Text('20'),
    ),
    const DropdownMenuItem(
      value: '21',
      child: Text('21'),
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColorWhite,
          leading: IconButton(onPressed: (){
        Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios,color: mainColorRed,),),
        ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "What is Your",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Name ?",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color:mainColorRed),
                      ),
                    ],
                  ),
                  SizedBox(width: getWidth(context, 1),),
                  Icon(Icons.person_outline, color: mainColorRed,size: 60,),
                ],
              ),
              SizedBox(
                height: getHeight(context, 5),
              ),
              Container(
                width: getWidth(context, 80),
                height: getHeight(context, 7),
                decoration: BoxDecoration(
                  color: mainColorLightGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal:30.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '   Enter your name',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, 3),
              ),
              Container(
                width: getWidth(context, 80),
                height: getHeight(context, 7),
                decoration: BoxDecoration(
                  color: mainColorLightGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Select Your Gender : ',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context, 3),
              ),
              Container(
                width: getWidth(context, 80),
                height: getHeight(context, 7),
                decoration: BoxDecoration(
                  color: mainColorLightGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Select Your Age : ',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedAge,
                      onChanged: (newValue) {
                        setState(() {
                          selectedAge = newValue!;
                        });
                      },
                      items: ageItems,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context, 5),
              ),
              SizedBox(
                width: getWidth(context, 80),
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
                      MaterialPageRoute(
                          builder: (context) =>  const NavSwitch()),
                    );
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: getWidth(context, 5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
