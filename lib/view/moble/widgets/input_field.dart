// ignore_for_file: avoid_print

import 'package:flutter/material.dart';


class AppTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool password;

  final TextInputType keyboardType;
  final Function? validator;
  const AppTextFormField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.password,
      required this.validator,
      required this.keyboardType})
      : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        //style: const TextStyle(color: AppColor.formFieldBackText, fontSize: 13),
        obscureText: widget.password
            ? showPass
                ? false
                : true
            : false,
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          return null;
        },
        
        decoration:const InputDecoration(
           hoverColor: Colors.green,
            border:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            filled: true,
            
            fillColor: Colors.white
            ),
      ),
    );
  }
}
