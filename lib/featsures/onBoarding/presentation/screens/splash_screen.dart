import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    DioHelper.init();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 3000), () async {

        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*.5,
              width: MediaQuery.of(context).size.width*.5,
              child: SvgPicture.asset(ImageAssets.splashLogo),
            ),
      SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 40.0,
                fontFamily: 'Horizon',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 800),
                animatedTexts: [
                  RotateAnimatedText('AWESOME'),
                  RotateAnimatedText('OPTIMISTIC'),
                  RotateAnimatedText('DIFFERENT'),
                ],
              ),
            ),
          ],
        ),
      ),
          ],
        ),
      ),
    );
  }
}
