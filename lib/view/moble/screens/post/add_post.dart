import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/bloc/main_bloc/app_cubit.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';
import 'package:le_vie_app/view/moble/screens/post/post_form.dart';

import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/DocumentHelper.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_text_styles.dart';

class AppPost extends StatefulWidget {
  const AppPost({Key? key}) : super(key: key);

  @override
  State<AppPost> createState() => _AppPostState();
}

class _AppPostState extends State<AppPost> {
  var keyf = GlobalKey<FormState>();
  var tC = TextEditingController();
  var dC = TextEditingController();
  UserDocumentHelper userDocumentHelper = UserDocumentHelper();
  @override
  void dispose() {
    userDocumentHelper.endUploadFile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        AppCubit cubit = AppCubit.get(context);
        if (state is ScAddPostData) {
          await cubit.getForums(context);
          await cubit.getMyForums(context);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Create New Post",
                style: AppTexeStyle.subheading,
              ),
              leading: IconButton(
                icon: const Icon(Icons.keyboard_backspace),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: (state is LodingAddPostData)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),  
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.05,
                          ),
                          addPhotoBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          postForm(context, keyf, tC, dC, userDocumentHelper),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget addPhotoBox() {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenWidth * 0.35,
          width: SizeConfig.screenWidth * 0.35,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: InkWell(
            onTap: () async {
              await userDocumentHelper.uploadFile();
              setState(() {});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.green,
                  size: 15,
                ),
                Text(
                  "Add Photo",
                  style: AppTexeStyle.title.copyWith(color: AppColors.green),
                )
              ],
            ),
          ),
        ),
        if (userDocumentHelper.uploadedFile != null)
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: SizeConfig.screenWidth * 0.35,
                width: SizeConfig.screenWidth * 0.35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: FileImage(userDocumentHelper.uploadedFile!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        userDocumentHelper.endUploadFile();
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.delete,
                            size: 25, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
