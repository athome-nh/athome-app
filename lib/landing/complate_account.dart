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
  String selectedGender = 'Male'; // Default gender selection
  String selectedAge = '10-20'; // Default age selection

  List<DropdownMenuItem<String>> genderItems = [
    const DropdownMenuItem(
      value: 'Male',
      child: Row(
        children: <Widget>[
          Icon(Icons.person, color: Colors.blue),
          SizedBox(width: 10),
          Text('Male'),
        ],
      ),
    ),
    const DropdownMenuItem(
      value: 'Female',
      child: Row(
        children: <Widget>[
          Icon(Icons.female, color: Colors.pink),
          SizedBox(width: 10),
          Text('Female'),
        ],
      ),
    ),
  ];

  List<DropdownMenuItem<String>> ageItems = [
    const DropdownMenuItem(
      value: '10-20',
      child: Row(
        children: <Widget>[
          Icon(Icons.calendar_today, color: Colors.blue),
          SizedBox(width: 10),
          Text('10 - 20'),
        ],
      ),
    ),
    const DropdownMenuItem(
      value: '21-30',
      child: Row(
        children: <Widget>[
          Icon(Icons.calendar_today, color: Colors.green),
          SizedBox(width: 10),
          Text('21 - 30'),
        ],
      ),
    ),
    const DropdownMenuItem(
      value: '31-50',
      child: Row(
        children: <Widget>[
          Icon(Icons.calendar_today, color: Colors.orange),
          SizedBox(width: 10),
          Text('31 - 50'),
        ],
      ),
    ),
    const DropdownMenuItem(
      value: '51+',
      child: Row(
        children: <Widget>[
          Icon(Icons.calendar_today, color: Colors.red),
          SizedBox(width: 10),
          Text(' 51 + '),
        ],
      ),
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
              Image.asset(mainImageLogo1,
              width: getWidth(context, 80),
              ),
              const Text(
                "Information",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please write your name ... ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Select Your Gender : ',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        });
                      },
                      items: genderItems,
                    ),
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
