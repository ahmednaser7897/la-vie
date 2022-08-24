import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/view/moble/screens/post/post_search.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/theme/app_text_styles.dart';
import '../../widgets/forums_card.dart';
import '../../widgets/home_widgets.dart';
import 'add_post.dart';

class DiscussionForums extends StatefulWidget {
  const DiscussionForums({Key? key}) : super(key: key);

  @override
  State<DiscussionForums> createState() => _DiscussionForumsState();
}

class _DiscussionForumsState extends State<DiscussionForums> {
  int pageIndx = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SizeConfig().init(context);
        AppCubit cubit = AppCubit.get(context);
        print("cubit.forums is "+cubit.forums.toString());
        return Scaffold(  
          body: (cubit.forums == null || cubit.myForums == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : 
              Column(children: [
                  SizedBox(height: SizeConfig.screenHeight*0.04,),
                  Text("Forums",style: AppTexeStyle.subheading,textAlign:TextAlign.center ,),
                  SizedBox(height: SizeConfig.screenHeight*0.03,),
                  searchrow(context, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostSearch()));
                  }, shop: false),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        botton("All Forums", 0),
                        const SizedBox(
                          width: 20,
                        ),
                        botton("My Forums", 1),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Expanded(child: forumsList(context))
                ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AppPost()));
            },
            backgroundColor: AppColors.green,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget botton(String text, int i) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: i == pageIndx ? AppColors.green : Colors.grey)),
      minWidth: SizeConfig.screenWidth * 0.25,
      height: 40,
      onPressed: () {
        setState(() {
          pageIndx = i;
        });
      },
      color: i == pageIndx ? AppColors.green : Colors.white,
      child: Text(
        text,
        style: AppTexeStyle.body.copyWith(
            color: i == pageIndx ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget forumsList(context) {
    AppCubit cubit = AppCubit.get(context);
    late List<Widget> l;
    if (pageIndx == 0) {
      l = List.generate(cubit.forums!.forum!.length, (index) {
        return postItem(cubit.forums!.forum![index], context: context);
      });
    } else {
      l = List.generate(cubit.myForums!.forum!.length, (index) {
        return postItem(cubit.myForums!.forum![index], context: context);
      });
    }
    return ListView(
      physics:const BouncingScrollPhysics(),
      children: l,
    );
  }
}
