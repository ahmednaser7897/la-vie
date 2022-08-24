import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/model/blogs.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/theme/app_text_styles.dart';
import '../../../common_view/widgets.dart';
import 'blogs_data.dart';

class  BlogsScreen extends StatefulWidget {
  const BlogsScreen({ Key? key }) : super(key: key);

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder:(context, state) {
           SizeConfig().init(context);
           AppCubit cubit=AppCubit.get(context);
          return 
          cubit.blogs==null ||cubit.blogs!.data==null?
        const Center(child: CircularProgressIndicator(),):
         Column(
           children: [
             SizedBox(height: SizeConfig.screenHeight*0.04,),
            Text("Blogs",style: AppTexeStyle.subheading,textAlign:TextAlign.center ,),
            SizedBox(height: SizeConfig.screenHeight*0.03,),
             Expanded(child: myItems(context)),
           ],
         );
         
        },
    );
  }

  Widget myItems(context) {
     AppCubit cubit=AppCubit.get(context);
     List<MainData> newList =  List.from(cubit.blogs!.data!.plants!)..addAll(cubit.blogs!.data!.seeds!)..addAll(cubit.blogs!.data!.tools!);
    return ListView.separated(
      physics:const BouncingScrollPhysics(),
        itemBuilder: (context, i) => myItemsCard(newList[i]),
        separatorBuilder: (context, i) => const SizedBox(height: 10,),
        itemCount: newList.length);
  }

  Widget myItemsCard(MainData product) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
       MaterialPageRoute(builder: (context) =>  BlogsDataScreen(mainData: product,)));
      },
      child: Card(
          color: AppColors.white,
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: LayoutBuilder(builder: (context, c) {
              return Row(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight*0.15,
                    child: webImage(product.imageUrl,c.maxWidth * 0.4,)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                      children: [    
                        Text("2 days ago",
                            style: AppTexeStyle.title
                                .copyWith(fontSize: 12, color: Colors.green)),
                        const SizedBox(height: 10,),
                         Text(
                          product.name!,
                          style: AppTexeStyle.title.copyWith(fontWeight: FontWeight.bold),
                        ),
                         const SizedBox(height: 10,),
                         Text(
                          product.name!,
                          style: AppTexeStyle.body.copyWith(fontWeight: FontWeight.w400,color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
          )),
    );
  }
}