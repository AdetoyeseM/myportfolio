import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';

class HeaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final name ="ADETOYESE\n MATTHEW"
                .text
                .white
                .xl5
                .lineHeight(1)
                .size(context.isMobile ? 10 : 10)
                .bold
                .make()
                .shimmer();
    return SafeArea(
      child: VxBox(
          child: VStack([
        ZStack([
          Pictures(),
          Row(

            children: [
              VStack([
                if (context.isMobile) 20.heightBox else 10.heightBox,
                CustomAppBar().shimmer(primaryColor: Colors.purple[50]),
                30.heightBox,
                name, 
                     20.heightBox,
              VxBox()
                  .color(Colors.purple)
                  .size(70, 10)
                  .make()
                  .shimmer(primaryColor: Colors.purple),
              30.heightBox,
              SocialAccounts(),
        ]).pSymmetric(h: context.percentWidth * 10, v: 32),  
          
        Expanded(
          child: VxResponsive(
            fallback: const Offstage(),
            medium: Introduction()
              .pOnly(left: 120)
            .h(context.percentHeight * 60),

            large: Introduction()
            .pOnly(left: 120)
            .h(context.percentHeight * 60),

          )
        )
      ],
      ).w(context.screenWidth)
          ]
          ),
          ]
          )
      ).size(context.screenWidth, context.percentHeight* 60)
      .color(Colors.black)
      .make(),
    
    );
  }
}

class Introduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  VStack(
            [
              [
                " - Introduction".text.white.widest.sm.make(),
                10.heightBox,
                "I'm a full stack Mobile app Developer, with a strong passion for building great product with cool UI/UX. Mobile app developer who has a track record of success creating apps that are both well-received and commercially viable."
                    .text
                    .white
                    .xl2
                    .maxLines(8)
                    .make()
                    .w(context.isMobile
                        ? context.screenWidth
                        : context.percentWidth * 40),
                20.heightBox,
              ].vStack(),
              RaisedButton(
                onPressed: () {
                  launch("https://docs.google.com/document/d/1MmSXyH9pv-JSf7UGtTJg2VpBVj50Kkp87KPMdjJ0JVM/edit?usp=sharing");
                },
                child: "Resume".text.make(),
                color: Colors.purple[50],
                shape: Vx.roundedSm,
                hoverColor: Vx.purple700,
              ).h(50)
            ],
            alignment: MainAxisAlignment.spaceEvenly,
          );
  }
}

class Pictures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationY(0),
      alignment: Alignment.center,
      child: Image.asset(
        "assets/lapp.jpg",
        fit: BoxFit.cover,
        height: context.percentHeight * 60,
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      AntDesign.codesquare,
      size: 50,
      color: Colors.white,
    );
  }
}

class SocialAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return [
      Icon(AntDesign.twitter, color: Colors.white).mdClick(() {
        launch("https://twitter.com/_Adepto");
      }).make(),
      20.widthBox,
      Icon(AntDesign.github, color: Colors.white).mdClick(() {
        launch("https:\\github.com/adetoyesematthew");
      }).make(),
      20.widthBox,
      Icon(AntDesign.linkedin_square, color: Colors.white).mdClick(() {
        launch("https://www.linkedin.com/in/adetoyesematthew/");
      }).make(),
      20.widthBox,
      Icon(AntDesign.facebook_square, color: Colors.white).mdClick(() {
        launch("https://web.facebook.com/matthew.adetoyese");
      }).make(),
      20.widthBox,
    ].hStack();
  }
}
