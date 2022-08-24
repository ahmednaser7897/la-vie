
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/theme/app_text_styles.dart';
import '../../widgets/forums_card.dart';
/// always return empt list
class PostSearch extends StatefulWidget {
  const PostSearch({Key? key}) : super(key: key);

  @override
  State<PostSearch> createState() => _PostSearchState();
}

class _PostSearchState extends State<PostSearch> {
     
  var searchC = TextEditingController();
  var keyf = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit=AppCubit.get(context);
        SizeConfig().init(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body:Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Form(
                  key: keyf,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius:const BorderRadius.all(Radius.circular(5)),
                      child: TextFormField(
                        
                        controller: searchC,
                        onChanged: (value) {
                          if (keyf.currentState!.validate()) {
                            cubit.searchFourms(value);                           
                          }
                        },
                        
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hoverColor: Colors.green,
                          border:InputBorder.none,
                          filled: true,
                          fillColor: AppColors.filedBackGround,
                          hintText: "Search",
                          hintStyle: AppTexeStyle.subtitle.copyWith(color:Colors.grey), 
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          suffix: Image.asset("assets/images/mobile/Filter.png"), 
                        ),
                      ),
                    ),
                  ),
                ),
              //if you searsh with api do not get data 
            /*
            (cubit.searchForums==null ||cubit.searchForums!.forum==null)?
            const Center()
            :cubit.searchForums!.forum!.isEmpty?
              Expanded(child:SingleChildScrollView(child: emptyWidget("Not found", "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.", SizeConfig.screenHeight * 0.22)))
              :Expanded(child:searchListByApi(context))*/
              //so we will make local search
              (cubit.foundFourms.isEmpty)?Container()
              :Expanded(child:searchList(context))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget searchListByApi(ctx){
    AppCubit cubit = AppCubit.get(ctx);
    return ListView.separated( 
      physics:const BouncingScrollPhysics(),      
      itemBuilder: (context,i)=>postItem(cubit.searchForums!.forum![i], context: context),
        separatorBuilder:(context,i)=>const Divider(color: Colors.grey),
        itemCount: cubit.user!.data!.userNotification!.length
      );
  }
  Widget searchList(ctx){
    AppCubit cubit = AppCubit.get(ctx);
    return ListView.separated( 
      physics:const BouncingScrollPhysics(),      
      itemBuilder: (context,i)=>postItem(cubit.foundFourms[i], context: context),
        separatorBuilder:(context,i)=>const Divider(color: Colors.grey),
        itemCount: cubit.foundFourms.length
      );
  }
 }
