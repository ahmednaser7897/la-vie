import 'dart:math';

import 'package:flutter/material.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../common_view/widgets.dart';
import '../../widgets/form.dart';

Widget checkOut(int price,context,keyf,visa,visaPass) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                "Total",
                style: AppTexeStyle.title.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text("$price EGP",
                  style: AppTexeStyle.title
                      .copyWith(fontSize: 14, color: Colors.green,fontWeight: FontWeight.bold)),
            ],
          )
          ,const SizedBox(height: 20,),
            MaterialButton(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ,
                side: BorderSide(color: AppColors.green)
                ),
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context){
                      return pay(context,keyf,visa,visaPass);
                    }
                  );
                },
                color: AppColors.green,
                child: Text(
                 "Check Out",
                  style: AppTexeStyle.subtitle.copyWith(color: Colors.white),
                ),
              ),
             
        ],
      ),
    );
  }

   Widget pay(ctx,keyf,visa,visaPass){
    AppCubit cubit = AppCubit.get(ctx);
    return AlertDialog(
      insetPadding:const EdgeInsets.all(10),
      contentPadding:const EdgeInsets.all(15),
      elevation: 5,
      scrollable: true,
          title:const Text("Check Out"),
          content: Form(
            key: keyf,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...formfiled(visa, "Visa number", false,number: true),
                const SizedBox(height: 20,),
                ...formfiled(visaPass, "Visa pass", true),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: ()  {
                  String text="";
                  Random r=Random();
                  int i=r.nextInt(3);
                  if(i==0||i==1){
                    text="Shipped successfully and 10 deducted from your visa. Wait for the products to arrive at your home within days";
                    cubit.removeALLMyCard();
                  }else{
                    text="Your balance is not enough, please recharge and try again";
                  }
                 if(keyf.currentState!.validate()){
                  Navigator.pop(ctx);
                  buildToast(ctx,  text,seconds: 6);
                 } 
                },
                child: const Text("Pay")),
          ],
        );
  }
