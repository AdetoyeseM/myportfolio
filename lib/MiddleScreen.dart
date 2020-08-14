import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MiddleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Vx.black,
      child: Flex(
        direction: context.isMobile ? Axis.vertical : Axis.horizontal,
        children: [
          "All Creative Works,\n"
              .richText
              .withTextSpanChildren(
                  ["Selected Projects.".textSpan.yellow400.make()])
              .xl4
              .white
              .make(),
          20.widthBox,
          Expanded(
              child: VxSwiper(items: [
                  ProjectWidget(title: "Pegas Diesel[Android & IOS]:\n \n Single Handedly designed and developed a Mobile diesel ordering platform for Pegas Inc. with over 500+ downloads "),
                  ProjectWidget(title: "Mobile Learning App (C++): \n\n A Virtual C++ learning App that provides users with both theortical and pratical knowlegde of C++ programming langauge"),
                  ProjectWidget(title: "Python Tutor: \n\n A Virtual Python programming learning App that provides users with both theortical and pratical knowlegde of python programming langauge"),
                  ProjectWidget(title: "Interviewer's Mind [Android]: \n\n Proposed, designed, and created an open-source mobile app to provides users, prospective job seekers all necessary tips to a successful job interview"),
                  ProjectWidget(title: "Tech News App[Android]: \n\n Proposed, designed, and created an open-source mobile app to enable users gains access to thousands of tech informations, news, updates, forums, meetups")

          ],
          height: 190,
          viewportFraction: context.isMobile ? 0.75 : 0.4 ,
          autoPlay: true,
          autoPlayAnimationDuration: 1.seconds,
          )
          )
        ],
      ).p8().h(context.isMobile ? 600 : 400),
    );
  }
}

class ProjectWidget   extends StatelessWidget {
  final String title;

  const ProjectWidget({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  title.
            text.
            bold.
            black.
            center
            .make()
            .box.
            p8.
            roundedLg.
            alignCenter
            .square(200)
            .neumorphic(
              color: Colors.purple[50],
              elevation: 5.0,
              curve: VxCurve.concave
            )
          .make()
          .p12();
  }
}