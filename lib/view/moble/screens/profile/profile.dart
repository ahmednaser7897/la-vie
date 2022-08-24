import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:le_vie_app/view/common_view/widgets.dart';
import 'package:le_vie_app/view/moble/screens/profile/profile_widgets.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';

import '../../../common_view/theme/app_text_styles.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  var keyf = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        AppCubit cubit = AppCubit.get(context);
        if(state is ScUpdateUserData){
          await cubit.getUser(ctx: context);
          buildToast(context, "Your data has been updated successfully");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        SizeConfig().init(context); 
        return cubit.user==null?
        const Center(child: CircularProgressIndicator(),)
        :Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: SizeConfig.screenHeight * 0.44,
                color: Colors.amber,
                child: Stack(
                  
                  children: [
                    webImage(cubit.user!.data!.imageUrl, double.infinity,full: true),
                    Container(color: Colors.black.withOpacity(0.8),),
                    Align(
                     alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          CircleAvatar(
                            radius: SizeConfig.screenWidth*0.13,
                            backgroundImage:
                           (cubit.user!.data!.imageUrl==null || cubit.user!.data!.imageUrl=="")?
                            const AssetImage( 'assets/images/mobile/tree.png', ):
                            NetworkImage( cubit.user!.data!.imageUrl!) as ImageProvider
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            cubit.user!.data!.firstName!+" "+cubit.user!.data!.lastName!,
                            style: AppTexeStyle.subheading.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: SizeConfig.screenHeight * 0.6,
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: HexColor("#F3FEF1"),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          height: SizeConfig.screenHeight * 0.088,
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(
                                    "assets/images/mobile/Group 1264.png"),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Text(
                                "You have ${cubit.user!.data!.userPoints ?? 0} points",
                                style: AppTexeStyle.subtitle,
                              ))
                            ],
                          ),
                        )
                          ,const SizedBox(height: 20,)
                        ,Text(
                          "Edit Profile",
                          style: AppTexeStyle.title.copyWith(fontWeight: FontWeight.w500),
                        ),
                         const SizedBox(height: 20,),
                          InkWell(
                            onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (context){
                                    return changeData(context,keyf, fname, lname, email);
                                  }
                                );
                            },
                            child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            height: SizeConfig.screenHeight * 0.09,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                 Image.asset("assets/images/mobile/icon.png"),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Chang Name",
                                  style: AppTexeStyle.subheading,
                                )),
                                const Icon(Icons.arrow_forward_outlined)
                              ],
                            ),
                                                ),
                          )
                          ,
                          const SizedBox(height: 30,),
                          InkWell(
                            onTap: (){
                               showDialog(
                                  context: context,
                                  builder: (context){
                                    return changeData(context,keyf, fname, lname, email,name: false);
                                  }
                                );
                            },
                            child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            height: SizeConfig.screenHeight * 0.09,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                 Image.asset("assets/images/mobile/icon.png"),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Chang Email",
                                  style: AppTexeStyle.subheading,
                                )),
                                const Icon(Icons.arrow_forward_outlined)
                              ],
                            ),
                                                ),
                          )
                          ,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon:const Icon(Icons.logout,color: Colors.white,),
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context){
                      return logOut(context);
                    }
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

 }


