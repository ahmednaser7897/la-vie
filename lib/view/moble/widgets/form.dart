
import 'package:flutter/cupertino.dart';

import '../../../shared/services/size_config.dart';
import 'input_field.dart';

List<Widget> formfiled(TextEditingController controller,String title,bool pass,{Function ?fun, bool number=false}){
  return [
     Text(title),
          SizedBox(
          height:SizeConfig.screenHeight*0.007,
    ),
      AppTextFormField(
          controller: controller,
          title: title,
          password: pass,
          keyboardType:number?TextInputType.number:TextInputType.text,
          validator:fun?? (value) {
            if (value!.isEmpty) {
              return "$title must not be empty";
            }
            return null;
          },
        ),
  ];
}