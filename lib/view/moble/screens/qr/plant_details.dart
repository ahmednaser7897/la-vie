// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:le_vie_app/model/blogs.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';

import 'qr_dataitem_widget.dart';


class PlantDetails extends StatelessWidget {
  const PlantDetails({
    Key? key,
    required this.plant,
  }) : super(key: key);
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state)  {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/mobile/Meet the Maker_ Nathalie Gibbins _ Rose & Grey 1.png"),
                    fit: BoxFit.cover)),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.1),
                    height: SizeConfig.screenHeight * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dataItem("assets/images/mobile/temperatures/sun (3) 2.png",
                        "Sun light",
                        "%",
                        plant.sunLight!
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        dataItem("assets/images/mobile/temperatures/image 81 (Traced).png",
                        "Water Capacity",
                        "%",
                        plant.waterCapacity!
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                       dataItem("assets/images/mobile/temperatures/thermometer (1) 2.png",
                        "Temperature",
                        "◌",
                        plant.temperature!,
                        c: true
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: SizeConfig.screenHeight * 0.6,
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, bottom: 20),
                                  child: Text(
                                    plant.name!,
                                    style: AppTexeStyle.subheading
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                    "Native to southern Africa, snake plants are well adapted to conditions similar to those in southern regions of the United States. Because of this, they may be grown outdoors for part of all of the year in USDA zones 8 and warmer",
                                    style: AppTexeStyle.body.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: HexColor("#979797"),
                                        height: 1.5)),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 20),
                                  child: Text(
                                    plant.description!,
                                    style: AppTexeStyle.title
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                    "A widespread problem with snake plants is root rot. This results from over-watering the soil of the plant and is most common in the colder months of the year. When room rot occurs, the plant roots can die due to a lack of oxygen and an overgrowth of fungus within the soil. If the snake plant's soil is soggy, certain microorganisms such as Rhizoctonia and Pythium can begin to populate and multiply",
                                    style: AppTexeStyle.body.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: HexColor("#979797"),
                                        height: 1.5)),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: AppColors.green)),
                            minWidth: double.infinity,
                            height: 40,
                            onPressed: ()  {
                              Navigator.pop(context);
                              
                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MobileHomePage()))   ;
                            },
                            color: AppColors.green,
                            child: Text(
                              "Back To Blog",
                              style: AppTexeStyle.subtitle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
