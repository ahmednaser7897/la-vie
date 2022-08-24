import 'package:flutter/material.dart';
import 'package:le_vie_app/view/moble/screens/my_cart/my_cart.dart';
import 'package:le_vie_app/view/moble/widgets/plant_card.dart';

import '../../../bloc/main_bloc/app_cubit.dart';
import '../../../shared/services/size_config.dart';
import '../../common_view/theme/app_colors.dart';
import '../../common_view/theme/app_text_styles.dart';

Widget searchrow(context, Function fun, {bool shop = true}) {
  AppCubit cubit = AppCubit.get(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.filedBackGround,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                cubit.removeSearch();
                cubit.removeSearchFourms();
                fun();
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.search),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Search",
                    style: AppTexeStyle.subtitle,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        if (shop)
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyCart()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.asset(
                "assets/images/mobile/Cart.png",
                height: 40,
              ),
            ),
          )
      ],
    ),
  );
}

Widget plantCardsList(contaxt, indx) {
  AppCubit cubit = AppCubit.get(contaxt);
  late List<Widget> l;
  if (indx == 0) {
    l = List.generate(
        cubit.products!.data!.length,
        (index) => PlantCard(
              product: cubit.products!.data![index],
            ));
  } else if (indx == 1) {
    l = List.generate(
        cubit.plants.length,
        (index) => PlantCard(
              product: cubit.plants[index],
            ));
  } else if (indx == 2) {
    l = List.generate(
        cubit.seeds.length,
        (index) => PlantCard(
              product: cubit.seeds[index],
            ));
  } else {
    l = List.generate(
        cubit.tools.length,
        (index) => PlantCard(
              product: cubit.tools[index],
            ));
  }
  return GridView.count(
    physics:const BouncingScrollPhysics(),
    mainAxisSpacing: 1,
    crossAxisSpacing: 1,
    childAspectRatio: //1/1.6,
        SizeConfig.screenHeight * 0.75 / SizeConfig.screenWidth * 0.4,
    crossAxisCount: 2,
    children: l,
  );
}
