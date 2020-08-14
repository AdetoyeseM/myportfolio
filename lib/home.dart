import 'package:flutter/material.dart';
import 'package:myportfolio/header.dart';
import 'package:velocity_x/velocity_x.dart';

import 'MiddleScreen.dart';
import 'footerscreen.dart'; 

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(

      color: Colors.black,
      child: VStack([
        HeaderScreen(),
        if (context.isMobile) Introduction().p12(),
        MiddleScreen(),
        FooterScreen()
      ]).scrollVertical(),
      
    );
  }
}