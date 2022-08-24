import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/shared/services/size_config.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';
import 'package:le_vie_app/view/moble/screens/logein%20screens/logein_screen.dart';
import 'package:le_vie_app/view/moble/screens/logein%20screens/register_screen.dart';

import '../../../../bloc/logein cupit/logein_states.dart';
import '../../../../bloc/logein cupit/login_cuoit.dart';
import '../../../common_view/theme/app_text_styles.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCupit>(
      create: (context) => LoginCupit(),
      child: BlocConsumer<LoginCupit, LoginState>(
        listener: (context, state) {},
        builder: (context, stste) {
          SizeConfig().init(context);
          return SafeArea(
            child: Scaffold(
              body: DefaultTabController(
                length: 2,
                initialIndex: 1,
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                     ...moblePositionedImages(),
                      Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.16,
                          ),
                          Image.asset(
                            "assets/images/common/logo.png",
                            width: SizeConfig.screenWidth * 0.2,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.05,
                          ),
                          SizedBox(
                            height: 50,
                            child: AppBar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              elevation: 0,
                              bottom: TabBar(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  indicatorColor: AppColors.green,
                                  labelColor: Colors.black,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelStyle: AppTexeStyle.title
                                      .copyWith(color: Colors.black),
                                  unselectedLabelStyle: AppTexeStyle.subtitle
                                      .copyWith(color: AppColors.green),
                                  tabs: const [
                                    Tab(
                                      text: 'Sign in',
                                    ),
                                    Tab(
                                      text: 'Loge In',
                                    )
                                  ]),
                            ),
                          ),
                          if (kIsWeb)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth * 0.1),
                              child: const Divider(),
                            ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.05,
                          ),
                          const Expanded(
                            child: TabBarView(
                              children: [
                                RegisterScreen(),
                                Logeinscreen(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> moblePositionedImages() => const [
        PositionedDirectional(
          top: -12,
          end: -12,
          child: Image(image: AssetImage("assets/images/mobile/tree.png")),
        ),
        PositionedDirectional(
          bottom: -5,
          start: -5,
          child: Image(
            image: AssetImage("assets/images/mobile/tree2.png"),
          ),
        ),
      ];

  List<Widget> wepPositionedImages() => [
        PositionedDirectional(
          top: SizeConfig.screenHeight * 0.21,
          start: 0,
          child: Image(
            image: const AssetImage("assets/images/web/Group 1000003315.png"),
            width: SizeConfig.screenWidth * 0.12,
          ),
        ),
        PositionedDirectional(
          bottom: 10,
          end: 0,
          child: Image(
            image: const AssetImage("assets/images/web/Group 1000003316.png"),
            width: SizeConfig.screenWidth * 0.15,
          ),
        ),
      ];
}
