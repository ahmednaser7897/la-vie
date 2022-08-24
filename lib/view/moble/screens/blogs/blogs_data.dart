import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/model/blogs.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_text_styles.dart';

class  BlogsDataScreen extends StatefulWidget {
  const BlogsDataScreen({ Key? key,required this.mainData }) : super(key: key);
  final MainData mainData;
  @override
  State<BlogsDataScreen> createState() => _BlogsDataScreenState();
}

class _BlogsDataScreenState extends State<BlogsDataScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder:(context, state) {
           SizeConfig().init(context);
          return 
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
            body:
                  SingleChildScrollView(
                    physics:const  BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight*0.33,
                  width: double.infinity,
                  child: (widget.mainData.imageUrl==null || widget.mainData.imageUrl=="")?
                  Image.asset( 'assets/images/mobile/tree.png',fit: BoxFit.cover,):
                  Image.network("https://lavie.orangedigitalcenteregypt.com"+widget.mainData.imageUrl!,fit: BoxFit.cover,)
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(widget.mainData.name!,style: AppTexeStyle.subheading,),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:Text(widget.mainData.description!,style: AppTexeStyle.subtitle.copyWith(color: Colors.grey,height: 1.5),),
                )
              ],
            ),
            ),
            ),
          );
        },
    );
  }
}