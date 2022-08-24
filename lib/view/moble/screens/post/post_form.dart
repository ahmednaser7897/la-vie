import 'package:flutter/material.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/theme/app_text_styles.dart';
import '../../../common_view/widgets.dart';

Widget postForm(context,keyf,tC,dC,userDocumentHelper) {
    AppCubit cubit=AppCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: keyf,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Title"),
              SizedBox(
                height: SizeConfig.screenHeight * 0.007,
              ),
              TextFormField(
                controller: tC,
                onFieldSubmitted: (value) {
                  if (keyf.currentState!.validate()) {}
                },
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title must not be empty";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Description"),
              SizedBox(
                height: SizeConfig.screenHeight * 0.007,
              ),
              TextFormField(
                maxLines: 4,
                controller: dC,
                onFieldSubmitted: (value) {
                  if (keyf.currentState!.validate()) {}
                },
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description must not be empty";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: AppColors.green)),
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  if(userDocumentHelper.base64Image==null){
                    buildToast(context, "Choose a picture");
                  }else{
                    cubit.addPost(tC.text, dC.text, userDocumentHelper.base64Image!,context);
                  }
                },
                color: AppColors.green,
                child: Text(
                  "Post",
                  style: AppTexeStyle.subtitle.copyWith(color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
