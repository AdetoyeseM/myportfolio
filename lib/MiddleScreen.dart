import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class MiddleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Vx.black,
      child: Flex(
        direction: context.isMobile ? Axis.vertical : Axis.horizontal,
        children: [
          "Some of My Creative Works,\n"
              .richText
              .withTextSpanChildren(
                  ["Selected Projects.".textSpan.yellow400.make()])
              .xl4
              .white
              .make(),
          20.widthBox,
          Expanded(
              child: VxSwiper(
            items: [
              GestureDetector(
                  onTap: () => launch(
                      'https://play.google.com/store/apps/details?id=com.esusu_africa.fieldcollectors'),
                  child: ProjectWidget(
                      title:
                          "Esusu Field collectors \n \n A platform to digitize thrift savings and collections seamlessly; an app that promotes a secured online and mobile digital banking experience")),
              //

              GestureDetector(
                  onTap: () => launch(
                      'https://play.google.com/store/apps/details?id=com.esusupay.savebeta'),
                  child: ProjectWidget(
                      title:
                          "Savebeta: \n\n A Fintech A Payment platform designed to make all financial transactons like Bills Payment, Funds Transfer, Withdrawal Seamless ")),

              GestureDetector(
                  onTap: () => launch(
                      'https://play.google.com/store/apps/details?id=com.schoolkia.gracecourt'),
                  child: ProjectWidget(
                      title:
                          "SchoolKia[ Learning Management System]\n \n I designed and implemented a Mobile based Learning Management System for schools with user-base of over 100")),
              GestureDetector(
                  onTap: () => launch(
                      'https://play.google.com/store/apps/details?id=com.app.pegas'),
                  child: ProjectWidget(
                      title:
                          "Pegas Diesel[Android & IOS]:\n \n Single Handedly designed and developed a Mobile diesel ordering platform for Pegas Inc. with over 500+ downloads ")),
              GestureDetector(
                  onTap: () =>
                      launch('https://adetoyesematthew.github.io/EssyGold/'),
                  child: ProjectWidget(
                      title:
                          "EssyGold School[Essy Gold School Website]\n \n  A website designed to get all Latest information in and out of Essy Gold Schools")),
              GestureDetector(
                  onTap: () => launch(
                      'https://github.com/AdetoyeseMatthew/interviewers_mind'),
                  child: ProjectWidget(
                      title:
                          "Interviewer's Mind [Android]: \n\n Proposed, designed, and created an open-source mobile app to provides users, prospective job seekers all necessary tips to a successful job interview")),
              ProjectWidget(
                  title:
                      "Mobile Learning App (C++): \n\n A Virtual C++ learning App that provides users with both theortical and pratical knowlegde of C++ programming langauge"),
              ProjectWidget(
                  title:
                      "Python Tutor: \n\n A Virtual Python programming learning App that provides users with both theortical and pratical knowlegde of python programming langauge"),
              GestureDetector(
                  onTap: () =>
                      launch('https://github.com/AdetoyeseMatthew/WallPaper'),
                  child: ProjectWidget(
                      title:
                          "WallPaper Place[Android & IOS]:\n \n Single Handedly designed and developed a Mobile diesel ordering platform for Pegas Inc. with over 500+ downloads ")),
            ],
            height: 200,
            viewportFraction: context.isMobile ? 0.75 : 0.4,
            autoPlay: true,
            autoPlayAnimationDuration: 3.seconds,
          ))
        ],
      ).p8().h(context.isMobile ? 600 : 400),
    );
  }
}

class ProjectWidget extends StatelessWidget {
  final String title;

  const ProjectWidget({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return title.text.bold.black.center
        .make()
        .box
        .p8
        .roundedLg
        .alignCenter
        .square(300)
        .neumorphic(color: Colors.white, elevation: 0, curve: VxCurve.emboss)
        .make()
        .p12();
  }
}
