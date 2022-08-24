import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/view/moble/screens/logein%20screens/reset_pass_widgets.dart';

import '../../../../bloc/logein cupit/logein_states.dart';
import '../../../../bloc/logein cupit/login_cuoit.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/theme/app_text_styles.dart';
import '../../../common_view/widgets.dart';

var keyf = GlobalKey<FormState>();

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  PageController controller = PageController(keepPage: true, initialPage: 0);
  int page = 0;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCupit, LoginState>(
      listener: (context, state) {
        if(state is ScResetPass){
          buildToast(context, "The password has been changed successfully, you can now register with ${pass.text}");
        }
      },
      builder: (context, stste) {
        SizeConfig().init(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Reset Password",
                style: AppTexeStyle.subheading,
              ),
              leading: IconButton(
                icon: const Icon(Icons.keyboard_backspace),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.1),
              child: Form(
                key: keyf,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (i) {
                          setState(() {
                            page = i;
                          });
                        },
                        children: [
                          enterEmail(email),
                          enterOtp(context, otp),
                          enterPass(pass, cpass),
                        ],
                      ),
                    ),
                    buttonsRow(context, stste),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buttonsRow(ctx, stste) {
    LoginCupit cupit = LoginCupit.get(context);
    return Row(
      mainAxisAlignment:
          page != 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
      children: [
        if (page != 0)
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: AppColors.green)),
            minWidth: SizeConfig.screenWidth * 0.35,
            onPressed: () {
              if (page != 0) {
                controller.jumpToPage(page - 1);
              }
            },
            child: Text(
              "Back",
              style: AppTexeStyle.subtitle.copyWith(color: Colors.green),
            ),
          ),
        MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: AppColors.green)),
          minWidth: SizeConfig.screenWidth * 0.35,
          onPressed: () {
            if (page == 0) {
              if (keyf.currentState!.validate()) {
                cupit.forgetPass(context, email: email.text).then((value) {
                  controller.jumpToPage(page + 1);
                });
              }
            }
            if (page == 1) {
              if (keyf.currentState!.validate()) {
                cupit
                    .getOtp(context, email: email.text, otp: otp.text)
                    .then((value) {
                  controller.jumpToPage(page + 1);
                });
              }
            }
            if (page == 2) {
              if (keyf.currentState!.validate()) {
                cupit
                    .resetPass(context,
                        email: email.text, otp: otp.text, pass: pass.text)
                    .then((value) {
                  if (stste is ScForgetPass) {
                    Navigator.pop(ctx);
                  }
                });
              }
            }
          },
          color: AppColors.green,
          child: Text(
            page == 2 ? "Finish" : "Next",
            style: AppTexeStyle.subtitle.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
