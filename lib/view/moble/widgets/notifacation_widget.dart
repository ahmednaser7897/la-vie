
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';

import '../../../bloc/main_bloc/app_cubit.dart';
import '../../../model/user.dart';

Widget notificationList(ctx){
    AppCubit cubit = AppCubit.get(ctx);
    return ListView.separated(      
      physics:const BouncingScrollPhysics(), 
      itemBuilder: (context,i)=>notificationitem(cubit.user!.data!.userNotification![i]),
        separatorBuilder:(context,i)=>const Divider(color: Colors.grey),
        itemCount: cubit.user!.data!.userNotification!.length
      );
  }
  Widget notificationitem(UserNotification n) {
    //print(n.createdAt!);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(n.createdAt!.replaceFirst("T", " "));
    String date =DateFormat.yMMMMEEEEd().format(dateTime);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CircleAvatar(
            radius: 18,
            backgroundImage: (n.imageUrl==null || n.imageUrl=="")?
            const AssetImage( 'assets/images/mobile/user.png', ):
            NetworkImage(n.imageUrl!) as ImageProvider
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(n.message!,style: AppTexeStyle2.subtitle,),
                const SizedBox(height: 5,),
                Text(date,style: AppTexeStyle2.subbody.copyWith(color: Colors.grey),),
              ],
            ),
          )
        ],
      ),
    );
  }
