
// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/bloc/logein%20cupit/login_cuoit.dart';
import 'package:le_vie_app/shared/network/dio_helper.dart';
import 'package:le_vie_app/view/moble/screens/logein%20screens/login.dart';
import 'package:le_vie_app/view/moble/screens/mobile_home_page.dart';


import 'bloc/main_bloc/app_cubit.dart';
import 'bloc/main_bloc/app_states.dart';

import 'bloc/observer.dart';
import 'shared/database/database.dart';
import 'shared/services/shared_preferences.dart';
import 'view/common_view/widgets.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   
 
  DataBase db=DataBase();
  await db.createDB();
  
  await CachHelper.inti();
  DioHelper.inti();
  accessToken=CachHelper.getData(key: "accessToken")??"";
  refreshToken=CachHelper.getData(key: "refreshToken")??"";

  late Widget widget;
  if(accessToken==""||refreshToken==""){
    widget=const LogIn();
  }else{
    widget= const MobileHomePage();
  }
  if(kIsWeb){
    widget= const  LogIn();
  }
  BlocOverrides.runZoned(() {runApp( MyApp(widget),);
  }, blocObserver: MyBlocObserver());
  Bloc.observer; 
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp(this.widget,{Key? key}) : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:  (ctx) =>LoginCupit(),),
        BlocProvider(create:  (ctx) =>AppCubit()..getUser()..getProducts())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder:(context, state) {
          return  MaterialApp(
            scrollBehavior: MyCustomScrollBehavior(),
            theme:ThemeData(
              appBarTheme: const AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme:IconThemeData(color: Colors.black) ,
                centerTitle: true
              )
            ) ,
          title: 'la vie',
          debugShowCheckedModeBanner: false,
          home:widget  ,
        );
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
