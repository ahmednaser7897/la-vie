import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';

import '../../../bloc/main_bloc/app_cubit.dart';
import '../../../bloc/main_bloc/app_states.dart';
import '../../../shared/services/size_config.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        SizeConfig().init(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: cubit.indix == 1
                ? cubit.screens[2]
                : cubit.screens[cubit.indix],
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: AppColors.white,
              buttonBackgroundColor: Colors.green,
              index: cubit.indix,
              items: <Widget>[
                Image(
                  image: const AssetImage(
                      "assets/images/mobile/bottombar/leave 1 (Traced).png"),
                  color: cubit.indix == 0 ? Colors.white : Colors.black,
                ),
                Image(
                  image: const AssetImage(
                      "assets/images/mobile/bottombar/qr-code-scan 1 (Traced).png"),
                  color: cubit.indix == 1 ? Colors.white : Colors.black,
                ),
                Image(
                  image: const AssetImage(
                    "assets/images/mobile/bottombar/Home.png",
                  ),
                  color: cubit.indix == 2 ? Colors.white : Colors.black,
                ),
                Image(
                  image: const AssetImage(
                      "assets/images/mobile/Group1.png"),
                      width: 20,
                  color: cubit.indix == 3 ? Colors.white : Colors.black,
                ),
                Image(
                  image: const AssetImage(
                      "assets/images/mobile/bottombar/Group.png"),
                  color: cubit.indix == 4 ? Colors.white : Colors.black,
                ),
              ],
              onTap: (index) {
                cubit.changBottomBarIndix(index,context);
              },
            ),
          ),
        );
      },
    );
  }
}
