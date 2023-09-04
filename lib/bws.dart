import 'package:flutter/material.dart';
import 'Config/property.dart';
import 'main.dart';

class ReadyWidgetBWSS extends StatefulWidget {
  const ReadyWidgetBWSS({super.key});

  @override
  State<ReadyWidgetBWSS> createState() => _ReadyWidgetBWSSState();
}

class _ReadyWidgetBWSSState extends State<ReadyWidgetBWSS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              ////Text
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat1,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),

              ////Image
              Image.asset(
                'assets/images/002_logo_red.png',
                width: getWidth(context, 70),
                fit: BoxFit.cover,
              ),

              ////get in to other page
              GestureDetector(
                onTap: () {
                   Navigator.push(context,MaterialPageRoute( 
                    builder: (context) =>const AtHomeApp(),
                    ),
                    );
                },
                child: Container(),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
