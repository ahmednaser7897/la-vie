import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/bloc/main_bloc/app_cubit.dart';
import 'package:le_vie_app/bloc/main_bloc/app_states.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';
import 'package:le_vie_app/view/moble/widgets/forums_card.dart';

import '../../../../model/forum.dart';

// ignore: must_be_immutable
class PostWithCommentScreen extends StatefulWidget {
  
  final Forum forum;
   const PostWithCommentScreen({Key? key,required this.forum}) : super(key: key);

  @override
  State<PostWithCommentScreen> createState() => _PostWithCommentScreenState();
}

class _PostWithCommentScreenState extends State<PostWithCommentScreen> {
  var tc = TextEditingController();

  var sc = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Builder(
    builder: (context){
       print(widget.forum.forumId);
      return BlocConsumer<AppCubit,AppStates>( 
        listener:(context,state){},
        builder: (context,state){
          AppCubit cupit=AppCubit.get(context);
          return Scaffold(
            key: sc,
            appBar: AppBar(),
            body:      
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              postItem(widget.forum,context: context),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context,indix) {
                                    //print(widget.forum.forumComments![indix].comment);
                                    return commentItem(
                                    context, widget.forum.forumComments![indix] ,widget.forum                                  
                                  );
                                  },
                                  separatorBuilder: (context,indix)=>const SizedBox(height: 20,),
                                  itemCount: widget.forum.forumComments!.length
                                ),
                              ),
                             ],
                          ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                        children: [
                          const SizedBox(width: 5,),
                          Expanded(
                            child: Scrollbar(
                              thickness: 3,
                              child: TextFormField(
                                style:const TextStyle(color: Colors.black),
                                controller: tc,
                                maxLines: 4,
                                minLines: 1,
                                
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: "write comment", 
                                    hintStyle:const TextStyle(color: Colors.black),
                                    labelStyle: TextStyle(color: AppColors.green),
                                    hintMaxLines: 1),
                              ),
                            ),
                          ),
                          FloatingActionButton(
                          mini: true,
                          onPressed:() {
                            if(tc.text!=""){
                               cupit.setcomment(widget.forum, tc.text);
                              tc.text="";
                            }    
                          },
                          elevation: 0,
                          child: const Icon(Icons.send ,color: Colors.white,size: 25,),
                          backgroundColor: Colors.green,
                          ),
                        ],
                        ),
                      ),
                    )       
                  ],
                )
          );
        },
      );
    
    },
    );
  }

  Widget commentItem(context,ForumComments comment,Forum forum){
    AppCubit cupit=AppCubit.get(context);
    return  InkWell(
      onLongPress: (){
        if(comment.userId==cupit.user!.data!.userId) {
          sc.currentState!.showBottomSheet((context) {
          return Container(
            color:Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        cupit.deleteComment(comment, forum);
                      },
                      child: Row(                  
                        children: [
                           Icon(Icons.delete, size: 20,color: AppColors.green,),
                          const SizedBox(width: 5,),
                          Text("Delete Comment",style: Theme.of(context).textTheme.caption!. copyWith (color: AppColors.green, fontSize: 15),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
        }
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:comment.userId==cupit.user!.data!.userId?
            NetworkImage(cupit.user!.data!.imageUrl!) as ImageProvider
            :const AssetImage("assets/images/mobile/user.png"),
          ),
          const SizedBox(width: 5,),
          Expanded(
            child:
            Container(
              decoration:const  BoxDecoration(
                color:Colors.white,
                border:  Border(bottom: BorderSide(color: Colors.green)),
                //borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.userId==cupit.user!.data!.userId?
                    cupit.user!.data!.firstName!+" "+cupit.user!.data!.lastName!:
                     "Khaled mohamed",style: AppTexeStyle.subtitle),
                   
                    Text(comment.comment!,style:AppTexeStyle.body.copyWith(color: Colors.grey)),
                ],),
              ),
            ),
          ), 
        ],
      ),
    );        
  }
}
          
 