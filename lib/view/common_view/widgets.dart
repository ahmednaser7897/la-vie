
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';
import 'package:le_vie_app/view/moble/screens/logein%20screens/forgot_pass.dart';

import '../../shared/services/shared_preferences.dart';
import '../../shared/services/size_config.dart';

String accessToken = "";
String refreshToken = "";
Future<void> logein(String accessToken, String refreshToken) async {
  accessToken = accessToken;
  refreshToken = refreshToken;
  await CachHelper.setData(key: 'accessToken', value: accessToken);
  await CachHelper.setData(key: 'refreshToken', value: refreshToken);
}

Future<void> logeOut() async {
  await CachHelper.removeData(key: 'accessToken');
  await CachHelper.removeData(key: 'refreshToken');
  accessToken = "";
  refreshToken = "";
}

void buildToast(BuildContext ctx, String text,
    {bool center = false, int seconds = 4}) {
  showToast(
    text,
    // textStyle: GoogleAppTexeStyle.subtitle.copyWith(color: Colors.white),
    context: ctx,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: center ? StyledToastPosition.center : StyledToastPosition.bottom,
    animDuration: const Duration(seconds: 1),
    duration: Duration(seconds: seconds),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}

Widget logeInBoutton(Function fun) {
  return SizedBox(
    width: double.infinity,
    height: 45,
    child: MaterialButton(
      onPressed: () {
        fun();
      },
      color: AppColors.green,
      child: Text(
        "Login",
        style: AppTexeStyle.subtitle.copyWith(color: Colors.white),
      ),
    ),
  );
}

Widget loginDividerRow(ctx) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
          child: Divider(
        thickness: 1,
        color: AppColors.border,
      )),
      const SizedBox(
        width: 8,
      ),
      if(!kIsWeb)
      InkWell(
        onTap: () {
          Navigator.push(
              ctx, MaterialPageRoute(builder: (ctx) => const ForgotPass()));
        },
        child: Text(
          "forgot password ?",
          style: AppTexeStyle.subbody.copyWith(
              color: Colors.green, decoration: TextDecoration.underline),
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        "or continuo with",
        style: AppTexeStyle.subbody,
      ),
      const SizedBox(
        width: 8,
      ),
      Expanded(
          child: Divider(
        height: 1,
        color: AppColors.border,
      )),
    ],
  );
}

Widget mobleSocialBouttonsRow(Function google, Function facebook) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: () {
          google();
        },
        child: Image.asset("assets/images/common/Google.png"),
      ),
      const SizedBox(
        width: 30,
      ),
      InkWell(
        onTap: () {
          facebook();
        },
        child: Image.asset("assets/images/common/Facebook.png"),
      ),
    ],
  );
}

Widget webSocialBouttonsRow(Function google, Function facebook) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      socialBoutton(
        (){
          google();
        },
        "Continue with Google",
         "assets/images/common/Google.png",
      ),
      const SizedBox(
        width:50,
      ),
      socialBoutton(
        (){
          facebook();
        },
        "Continue with Facebook",
         "assets/images/common/Facebook.png",
      ),
          
    ],
  );
}

socialBoutton(Function fun,String text,String image){
  return InkWell(
        onTap: () {
          fun();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          height: SizeConfig.screenHeight * 0.09,
          width: SizeConfig.screenWidth * 0.3,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.asset(image),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                text,
                style: AppTexeStyle.subtitle.copyWith(color: Colors.grey),
              )),
              // Icon(Icons.arrow_forward_outlined)
            ],
          ),
        ),
      );
      
}

Widget webImage(String? url, double? w, {bool full = false}) {
  //print(url);
  return SizedBox(
    width: w ?? double.infinity,
    child: (url == null || url == "")
        ? ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/images/mobile/tree.png',
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              !full ? "https://lavie.orangedigitalcenteregypt.com" + url : url,
              fit: BoxFit.cover,
              loadingBuilder:
                  (context, child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
  );
}
