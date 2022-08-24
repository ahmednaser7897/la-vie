import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/logein cupit/logein_states.dart';
import '../../../../bloc/logein cupit/login_cuoit.dart';

import '../../../../shared/services/size_config.dart';

import '../../../common_view/theme/app_text_styles.dart';
import '../../../common_view/widgets.dart';
import '../../../web/screens/web_main_app.dart';
import '../../widgets/form.dart';
import '../mobile_home_page.dart';
import 'forgot_pass.dart';

class Logeinscreen extends StatefulWidget {
  const Logeinscreen({Key? key}) : super(key: key);

  @override
  State<Logeinscreen> createState() => _LogeinscreenState();
}

class _LogeinscreenState extends State<Logeinscreen> {
  bool remmberMe = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();
    SizeConfig().init(context);
    var keyf = GlobalKey<FormState>();
    return BlocConsumer<LoginCupit, LoginState>(
      listener: (context, state) async {
        if (state is ScLoginState) {
          if (state.loginModel.type != null &&
              state.loginModel.type == "Success") {
                setState(() {
                  accessToken = state.loginModel.data!.accessToken!;
                  refreshToken =  state.loginModel.data!.refreshToken!;
                });
            await logein(state.loginModel.data!.accessToken!,
                state.loginModel.data!.refreshToken!);
            buildToast(context, state.loginModel.message!);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MobileHomePage()));
          } else {
            if (state.loginModel.type != null || state.loginModel.type != "") {
              buildToast(context, state.loginModel.type!);
            } else {
              buildToast(context, "Network Erorr");
            }
          }
        }
      },
      builder: (context, state) {
        email.text = "ahmednasr12345677654321@gmail.com";
        pass.text = "A@g996600";
        LoginCupit cupit = LoginCupit.get(context);
        SizeConfig().init(context);
        return SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Form(
            key: keyf,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...formfiled(email, "Email", false),
                      const SizedBox(
                        height: 20,
                      ),
                      ...formfiled(pass, "PassWord", true),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.025,
                  ),
                  if (kIsWeb)
                    Row(
                      children: [
                        Checkbox(
                            value: remmberMe,
                            onChanged: (value) {
                              setState(() {
                                remmberMe = value!;
                              });
                            }),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Remember me",
                          style:
                              AppTexeStyle.subbody.copyWith(color: Colors.grey),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const ForgotPass()));
                          },
                          child: Text(
                            "forgot password ?",
                            style: AppTexeStyle.subbody.copyWith(
                                color: Colors.green,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  if (kIsWeb)
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.025,
                    ),
                  (state is LodingLoginState)
                      ? const Center(child: CircularProgressIndicator())
                      : logeInBoutton(() {
                          if (kIsWeb) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WebMainApp()));
                          } else {
                            if (keyf.currentState!.validate()) {
                              cupit.userLogin(context,
                                  email: email.text, pass: pass.text);
                            }
                          }
                        }),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.025,
                  ),
                  loginDividerRow(context),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  if (kIsWeb)
                    webSocialBouttonsRow(() {
                      cupit.googleSignIn();
                      //cupit.facebookLogeout();
                    }, () {
                      //cupit.googleLogeout();
                      cupit.facebookSignIn();
                    }),
                  if (!kIsWeb)
                    mobleSocialBouttonsRow(() {
                      cupit.googleSignIn();
                      //cupit.facebookLogeout();
                    }, () {
                      //cupit.googleLogeout();
                      cupit.facebookSignIn();
                    }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
