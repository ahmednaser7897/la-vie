import 'package:flutter/material.dart';

import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/theme/app_text_styles.dart';

Widget dataItem(String image,String name,String sighn,int number,{bool c=false}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          height: SizeConfig.screenWidth * 0.14,
          width: SizeConfig.screenWidth * 0.14,
          padding: const EdgeInsets.all(10),
          child:  Image(
              image: AssetImage(
                  image)),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  number.toString(),
                  style: AppTexeStyle.title.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                      ),
                ),
                Baseline(
                  baseline: -5,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    sighn,
                    style: AppTexeStyle.body.copyWith(color: Colors.white),
                  ),
                ),
                if(c)
                const SizedBox(width: 5,),
                if(c)
                Text(
              "C",
              style: AppTexeStyle.subtitle.copyWith(color: Colors.white),
            )
              ],
            ),
            Text(
              name,
              style: AppTexeStyle.subbody.copyWith(color: Colors.white),
            )
          ],
        )
      ],
    );
  }
