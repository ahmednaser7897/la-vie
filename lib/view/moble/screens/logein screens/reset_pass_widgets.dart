 import 'package:flutter/material.dart';
import 'package:le_vie_app/view/moble/widgets/form.dart';
import 'package:pinput/pinput.dart';

import '../../../common_view/theme/app_text_styles.dart';

Widget enterOtp(ctx,otp) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter OTP",
          style: AppTexeStyle.heading,
        ),
        const SizedBox(
          height: 20,
        ),
        Pinput(
          controller: otp,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          length: 6,
          validator: (s) {
            return s == '' ?  'Pin is incorrect':null;
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (pin) {
            
            print(otp.text);
          },
        )
      ],
    );
  }

  Widget enterEmail(email) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter your Email",
          style: AppTexeStyle.heading,
        ),
        const SizedBox(
          height: 20,
        ),
        ...formfiled(email, "Email", false),
      ],
    );
  }

  Widget enterPass(pass,cpass) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reset Password",
          style: AppTexeStyle.heading,
        ),
        const SizedBox(
          height: 20,
        ),
        ...formfiled(pass, "password", true),
        const SizedBox(
          height: 20,
        ),
        ...formfiled(cpass, "confirm pass word", true,
         fun: (value) {
            if (value!.isEmpty) {
              return "Confirm Password must not be empty";
            }
            if (pass.text!=cpass.text) {
              return "Confirm Password is not correct";
            }
            return null;
          },
        ),
      ],
    );
  }

   final PinTheme defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color:  Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey[300]
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ),
  );

