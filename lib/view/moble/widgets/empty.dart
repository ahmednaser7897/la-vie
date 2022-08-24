import 'package:flutter/material.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';

Widget emptyWidget(String text1,String text2,double height){
  return Center(
    child: SizedBox(
      width: double.infinity,
     
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              "assets/images/mobile/Frame.png",
              height: height,
            ),
            const SizedBox(height: 30,),
            Text(text1,style: AppTexeStyle.heading,),
             const SizedBox(height: 20,),
            Text(text2,style: AppTexeStyle.title.copyWith(color: Colors.grey),textAlign:TextAlign.center ,)
        ],
      ),
    ),
  );
}