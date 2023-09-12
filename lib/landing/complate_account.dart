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
  final List<String> items = ['Erbil', 'Sulaymaniyah', 'Duhok', 'Halabja'];
  int selectedNumber = 18;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColorWhite,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColorRed,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is Your",
                        style: TextStyle(
                            fontSize: 30, fontFamily: mainFontMontserrat7),
                      ),
                      Text(
                        "Name ?",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: mainFontMontserrat7,
                            color: mainColorRed),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: getWidth(context, 1),
                  ),
                  Icon(
                    Icons.person_outline,
                    color: mainColorRed,
                    size: 70,
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Container(
                width: getWidth(context, 85),
                height: getHeight(context, 7),
                decoration: BoxDecoration(
                  color: mainColorLightGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your name ...',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, 4),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 4),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontFamily: mainFontMontserrat6,
                        color: mainColorBlack,
                        fontSize: 20),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Select Your ',
                      ),
                      TextSpan(
                        text: ' City ',
                        style: TextStyle(
                            fontFamily: mainFontMontserrat6,
                            color: mainColorRed,
                            fontSize: 20),
                      ),
                      const TextSpan(
                        text: ' ? ',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Container(
                decoration: BoxDecoration(
                  color: mainColorLightGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: DropdownButton<String>(
                    items: items.map(
                      (String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      },
                    ).toList(),
                    onChanged: (String? selectedItem) {},
                    hint: const Text('Erbil'), // Placeholder text
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, 4),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 7),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontFamily: mainFontMontserrat6,
                        color: mainColorBlack,
                        fontSize: 20),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Select Your ',
                      ),
                      TextSpan(
                        text: ' Geneer ',
                        style: TextStyle(
                            fontFamily: mainFontMontserrat6,
                            color: mainColorRed,
                            fontSize: 20),
                      ),
                      const TextSpan(
                        text: ' ? ',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, 3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (i == 1) {
                          i = 0;
                        } else {
                          i = 1;
                        }
                      });
                    },
                    child: Container(
                      width: getWidth(context, 35),
                      decoration: BoxDecoration(
                        color: i == 1 ? mainColorGrey : mainColorLightGrey,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: mainColorGrey,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            i == 1
                                ? 'assets/images/005_male_white.png'
                                : 'assets/images/005_male_red.png',
                            width: getWidth(context, 10),
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Male',
                            style: TextStyle(
                                color: mainColorBlack,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getWidth(context, 3),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (i == 2) {
                          i = 0;
                        } else {
                          i = 2;
                        }
                      });
                    },
                    child: Container(
                      width: getWidth(context, 35),
                      decoration: BoxDecoration(
                        color: i == 2 ? mainColorGrey : mainColorLightGrey,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: mainColorGrey,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            i == 2
                                ? 'assets/images/005_female_white.png'
                                : 'assets/images/005_female_red.png',
                            width: getWidth(context, 10),
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Female',
                            style: TextStyle(
                                color: mainColorBlack,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context, 4),
              ),

              Container(
                width: getWidth(context, 85),
                height: getHeight(context, 7),
                decoration: BoxDecoration(
                  color: mainColorLightGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Select Your Age : ',
                        style: TextStyle(fontSize: 18,fontFamily: mainFontMontserrat6),
                      ),
                    ),
                    const SizedBox(width: 10),
                    
                    Container(
                      width: getWidth(context, 25),
                      height: getHeight(context, 7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: mainColorRed,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: DropdownButton<int>(
                        value: selectedNumber,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedNumber = newValue ?? selectedNumber;
                          });
                        },

                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: mainColorWhite,
                          size: 40,
                        ), //Custom Icon
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: mainFontMontserrat6,
                            color: mainColorWhite),
                        underline: Container(), // Remove the underline
                        dropdownColor: mainColorRed,
                        isExpanded: false,
                        borderRadius: BorderRadius.circular(25),

                        items: List<DropdownMenuItem<int>>.generate(
                          43,
                          (int index) {
                            return DropdownMenuItem<int>(
                              value: index + 18,
                              child: Center(
                                child: Text(
                                  '${index + 18}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: mainFontMontserrat6,
                                      color: mainColorWhite),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context, 5),
              ),
              SizedBox(
                width: getWidth(context, 85),
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
                          builder: (context) => const NavSwitch()),
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
