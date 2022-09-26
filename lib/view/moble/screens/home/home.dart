import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';
import 'package:le_vie_app/view/moble/screens/home/notification.dart';

import 'package:le_vie_app/view/moble/screens/home/search.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../widgets/home_widgets.dart';
import 'exam.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indx = 0;
  DateTime dateTime=DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return cubit.products == null || cubit.products!.data == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      //if(dateTime.weekday==3)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ExamScreen()));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.question_mark,
                                  size: 25,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/common/logo.png",
                        width: SizeConfig.screenWidth * 0.2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () async { 
                              await cubit.getUser(ctx: context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScrean()));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  size: 25,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  searchrow(context, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Search()));
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  categoryRow(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  Expanded(child: plantCardsList(context,indx))
                ],
              );
      },
    );
  }

  Widget categoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        categoryItem("All", 0),
        categoryItem("Plants", 1),
        categoryItem("Seeds", 2),
        categoryItem("Tools", 3),
      ],
    );
  }

  Widget categoryItem(String name, int i) {
    return InkWell(
      onTap: () {
        setState(() {
          indx = i;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.filedBackGround,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color:
                    indx == i ? AppColors.green : AppColors.filedBackGround)),
        child: Text(
          name,
          style: AppTexeStyle.subtitle
              .copyWith(color: indx == i ? AppColors.green : AppColors.black),
        ),
      ),
    );
  }

  }
