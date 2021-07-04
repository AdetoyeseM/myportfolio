import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:myportfolio/header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class FooterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Divider();
    return VStack(
      [
        VxDevice(
          
            mobile: GestureDetector(
              onTap: (){
                launch('adetoyesematthew97@gmail.com');
              },
                          child: VStack(
                [
                  "Got a Project?\n Let's Talk.".text.color(Colors.white).center.xl2.make(),
                  10.heightBox,
                  "adetoyesematthew97@gmail.com"
                      .text
                      .color(Colors.white)
                      .semiBold
                      .make()
                      .box
                      .border(color: Colors.white)
                      .p16
                      .rounded 
                      .make()
                      .shimmer(),
                      
                ],
                crossAlignment: CrossAxisAlignment.center,
              ),
            ),
            web: GestureDetector(
              onTap: ()
              {
                launch('adetoyesematthew97@gmail.com');
              },
                          child: HStack(
                [
                  "Got a Project?\n Let's Talk.".text.color(Colors.white).center.xl2.make(),
                  10.widthBox,
                  "adetoyesematthew97@gmail.com"
                      .text
                      .color(Colors.white)
                      .semiBold
                      .make()
                      .box
                      .border(color: Colors.white)
                      .p16
                      .rounded
                      .make().shimmer(),
                      SizedBox(height:10),
                       "+234 706 757 1842"
                      .text
                      .color(Colors.white)
                      .semiBold
                      .make()
                      .box
                      .border(color: Colors.white)
                      .p16
                      .rounded
                      .make().shimmer()
                ],
                alignment: MainAxisAlignment.spaceAround,
              ).w(context.safePercentWidth * 70).scale150().p16(),
            )),
        50.heightBox,
        CustomAppBar(),
        10.heightBox,
        "Thanks For scrolling,".richText.semiBold.white.withTextSpanChildren(
            [" that's all Folks...".textSpan.gray500.make()]).make().shimmer().shimmer(),
        10.heightBox,
        [
          "Adept.ng".text.white.make().shimmer(),
        10.widthBox,
        Icon (
          AntDesign.heart,
          color:Vx.yellow400,
          size: 14,
          
        )
        ].hStack(crossAlignment: CrossAxisAlignment.center)
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).wFull(context).p16();
  }
}
