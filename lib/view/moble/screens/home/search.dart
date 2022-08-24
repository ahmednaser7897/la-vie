import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/shared/services/shared_preferences.dart';

import 'package:le_vie_app/view/moble/widgets/plant_card.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/theme/app_text_styles.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
   List l=[];
  static const String key="search";
  @override
  void initState() {
   
    super.initState();
    decode();
  }
  void addandincode(String text)  {
    l.add(text);
    String value=json.encode(l);
    CachHelper.setData(key: key, value: value);
  }
  void decode()  {
    String data=CachHelper.getData(key: key)??json.encode([]);
    l=json.decode(data);
  }

  void deleteAndincode(String text)  {
    setState(() {
      l.remove(text);
    });
    
    String value=json.encode(l);
    CachHelper.setData(key: key, value: value);
  }
   var searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var keyf = GlobalKey<FormState>();
       
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit=AppCubit.get(context);
        SizeConfig().init(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
            
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
                        onFieldSubmitted: (value) {
                          if (keyf.currentState!.validate()) {
                            cubit.searchProducts(value);
                            addandincode(value);
                           
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
                          
                        ),
                      ),
                    ),
                  ),
                ),
            
              if( cubit.foundproducts.isEmpty&&l.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Text("Recent Search",style: AppTexeStyle2.body.copyWith(color: Colors.grey),textAlign:TextAlign.start ,),
                  ],
                ),
              ),
              
              cubit.foundproducts.isEmpty?
              Expanded(child:recentSearchList())
              :Expanded(child:foundList(context))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget foundList(BuildContext context) {
    AppCubit cubit=AppCubit.get(context);
    //print(SizeConfig.screenWidth*0.4);
    //print("h is"+(SizeConfig.screenHeight*0.385).toString());
    return GridView.count(
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      childAspectRatio://1/1.6,
       SizeConfig.screenHeight *0.75/SizeConfig.screenWidth *0.4 ,
      //physics: const NeverScrollableScrollPhysics(),
     // shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(cubit.foundproducts.length, (index) =>  PlantCard(product: cubit.foundproducts[index],)),
    );
  }

  Widget recentSearchList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView.separated(        
        itemBuilder: (context,i)=>recentSearchItem(l[i]),
          separatorBuilder:(context,i)=>const SizedBox(height: 15,),
          itemCount: l.length
        ),
    );
  }

  Widget recentSearchItem (String text){
    return ListTile(
      onTap: (){
        searchC.text=text;
      },
     contentPadding: const EdgeInsets.all(0),
     minLeadingWidth: 0,
        title: Text(text,style: AppTexeStyle2.subtitle.copyWith(color: Colors.grey),),
        leading: const Icon(Icons.access_time),
        iconColor: Colors.grey,
        trailing: IconButton(
          onPressed: (){
            deleteAndincode(text);
          },
          icon: const Icon(Icons.highlight_remove_sharp),)
      );
  }
}
