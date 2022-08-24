import 'package:flutter/material.dart';
import 'package:le_vie_app/view/web/screens/web_about.dart';
import 'package:le_vie_app/view/web/screens/web_blogs.dart';
import 'package:le_vie_app/view/web/screens/web_home.dart';
import 'package:le_vie_app/view/web/screens/web_posts.dart';
import 'package:le_vie_app/view/web/screens/web_shop.dart';

import '../../../shared/services/size_config.dart';

import '../../common_view/theme/app_text_styles.dart';

class WebMainApp extends StatefulWidget {
  const WebMainApp({Key? key}) : super(key: key);

  @override
  State<WebMainApp> createState() => _WebMainAppState();
}

class _WebMainAppState extends State<WebMainApp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/common/logo.png",
                    width: SizeConfig.screenWidth * 0.1,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
      
                        },
                        child: Image.asset("assets/images/web/Cart.png")),
                        const SizedBox(width: 20,),
                        InkWell(
                        onTap: (){
      
                        },
                        child: Image.asset("assets/images/common/Bell.png",)
                      ,
                      ),
                        const SizedBox(width: 20,),
                        InkWell(
                        onTap: (){
      
                        },
                        child: Image.asset("assets/images/web/Background - 2022-08-09T012830 1.png")),
                        const SizedBox(width: 10,)
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth*0.2),
              height: 50,
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom:  TabBar(
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                 labelStyle: AppTexeStyle.title,
                 unselectedLabelStyle:AppTexeStyle.title ,
                 indicatorColor: Colors.white,
                  tabs:const [
                  Tab(
                    text: 'Home',
                  ),
                  Tab(
                    text: 'Shop',
                  ),
                  Tab(
                    text: 'Blog',
                  ),
                  Tab(
                    text: 'About',
                  ),
                  Tab(
                    text: 'Community',
                  )
                ]),
              ),
            ),
            const Expanded(
                child: TabBarView(
              children: [
                WebHome(),
                WebShop(),
                WebBlog(),
                WebAbout(),
                WebPost(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
