import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/view/web/screens/web_main_app.dart';

import '../../../../bloc/logein cupit/logein_states.dart';
import '../../../../bloc/logein cupit/login_cuoit.dart';
import '../../../../model/logedin_model.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/theme/app_text_styles.dart';
import '../../../common_view/widgets.dart';
import '../../widgets/form.dart';
import '../mobile_home_page.dart';
import 'forgot_pass.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool remmberMe = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();
    TextEditingController fname = TextEditingController();
    TextEditingController lname = TextEditingController();
    TextEditingController cpass = TextEditingController();
    var keyf = GlobalKey<FormState>();
    return BlocConsumer<LoginCupit, LoginState>(
      listener: (context, state) async {
        if (state is ScRegisteState) {
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
            if (state.loginModel.type != null ||
                state.loginModel.type != "") {
              buildToast(context, state.loginModel.type!);
            } else {
              buildToast(context, "Network Erorr");
            }
          }
        }
      },
      builder: (context, stste) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...formfiled(fname, "First Name", false),
                  sizedBox,
                  ...formfiled(lname, "Last Name", false),
                  sizedBox,
                  ...formfiled(email, "Email", false),
                  sizedBox,
                  ...formfiled(pass, "Password", true),
                  sizedBox,
                  ...formfiled(
                    cpass,
                    "Confirm Password",
                    true,
                    fun: (value) {
                      if (value!.isEmpty) {
                        return "Confirm Password must not be empty";
                      }
                      if (pass.text != cpass.text) {
                        return "Confirm Password is not correct";
                      }
                      return null;
                    },
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
                          style: AppTexeStyle.subbody
                              .copyWith(color: Colors.grey),
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
                  (stste is LodingRegisteState)
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: MaterialButton(
                            onPressed: () {
                              if (kIsWeb) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WebMainApp()));
                              } else {
                                if (keyf.currentState!.validate()) {
                                  UserLogIn user = UserLogIn(
                                      firstName: fname.text,
                                      lastName: lname.text,
                                      email: email.text);
                                  cupit.registerLogin(user, pass.text,context);
                                }
                              }
                            },
                            color: AppColors.green,
                            child: Text(
                              "Sign Up",
                              style: AppTexeStyle.subtitle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
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
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.025,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final SizedBox sizedBox = const SizedBox(
    height: 20,
  );
}
