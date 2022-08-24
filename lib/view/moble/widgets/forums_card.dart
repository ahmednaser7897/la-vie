import 'package:flutter/material.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';

import '../../../bloc/main_bloc/app_cubit.dart';
import '../../../model/forum.dart';
import '../screens/post/comments.dart';

Widget postItem(Forum forum,{context}) {
  
  AppCubit cubit=AppCubit.get(context);
  return Card(
    shape: RoundedRectangleBorder( 
    side: BorderSide(
      color: Colors.grey[400]!,
    ),
  ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation:0,
    margin: const EdgeInsetsDirectional.all(5),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //post header
          Row(
            children: [
               CircleAvatar(
                radius: 20,
                backgroundImage:  forum.userId==cubit.user!.data!.userId?
            NetworkImage(cubit.user!.data!.imageUrl!) as ImageProvider
            :const AssetImage("assets/images/mobile/user.png"),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(cubit.user!.data!.userId==forum.userId?
                    cubit.user!.data!.firstName!+" "+cubit.user!.data!.lastName!:
                     "Khaled mohamed", style: AppTexeStyle.subtitle),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "a month ago",
                      style: AppTexeStyle.subbody.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //post text
          Text(
            forum.title!,
            style: AppTexeStyle.subtitle.copyWith(color: AppColors.green),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            forum.description!,
            style: AppTexeStyle.body.copyWith(color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),

          //post image
          if(forum.imageUrl!=null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 140,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Image(
                  image:  NetworkImage(
                    "https://lavie.orangedigitalcenteregypt.com"+forum.imageUrl!,
                  ),
                  fit: BoxFit.cover,
                  loadingBuilder:
                      (context, child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                        height: 150,
                        child: Center(child: CircularProgressIndicator()));
                  },
                ),
              ),
            ),
          ),
          
          //like and comment numbers row
          Row(
            children: [
              InkWell(
                onTap: () async {
                await  cubit.setLike(forum);
                
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Image.asset("assets/images/mobile/Group1.png",color: forum.fav?Colors.red:Colors.black),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        forum.forumLikes!.length.toString() + " Likes",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PostWithCommentScreen(forum: forum,)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                       forum.forumComments!.length.toString() + " Replies",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
