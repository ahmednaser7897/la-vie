import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:le_vie_app/bloc/main_bloc/app_cubit.dart';
import 'package:le_vie_app/bloc/main_bloc/app_states.dart';
import 'package:le_vie_app/shared/services/size_config.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';

import '../../common_view/theme/app_colors.dart';
import '../../moble/screens/home/exam.dart';

class WebHome extends StatefulWidget {
  const WebHome({Key? key}) : super(key: key);

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  ScrollController scrollController = ScrollController();
  int indx = 1;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      setState(() {
        indx++;
      });
      print("indx is " + indx.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, stste) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExamScreen()));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.question_mark,
                          size: 25,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    homeFirstPart(),
                    popularCategories(),
                    bestSalers(),
                    blogs(),
                    aboutUS(),
                    mobileInfo(),
                    //footer()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget footer(){
    return Container(
      margin:const EdgeInsets.only(top: 20),
      padding:const EdgeInsets.all(30),
      color: HexColor("#FAFAFA"),
      child: Row(
        children: const [

        ],
      ),
    );
  }

  Widget mobileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/web/Group 1000003333.png",
            width: SizeConfig.screenWidth * 0.4,
            height: SizeConfig.screenHeight * 0.3,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemName("Mobile Application", ""),
              const SizedBox(
                height: 20,
              ),
              Text(
                """You can install La Vie mobile application and enjoy with new featurs, earn more points and get discounts 
Also you can scan QR codes in your plants’ pots so that you can get discount on everything in the website up to 70% """,
                style: AppTexeStyle2.body
                    .copyWith(fontSize: 18, color: Colors.grey),
              ),
              Text("install by", style: AppTexeStyle2.title),
              Row(
                children: [
                  boutton("Play Store","assets/images/web/Background - 2022-08-10T112502 1.png",(){}),
                  const SizedBox(width: 20,),
                   boutton("App Store","assets/images/web/Vector.png",(){}),
                   ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget boutton(String title,String uri ,Function fun) {
    return InkWell(
      onTap: () {fun();},
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          children: [
            Image.asset(
              uri,
              height: 15,
              width: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: AppTexeStyle2.body.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget aboutUS() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                itemName("About us", ""),
                Text(
                  """Welcome to La Vie, your number one source for planting. We're dedicated to giving you the very best of plants, with a focus on dependability, customer service and uniqueness.\nFounded in 2020, La Vie has come a long way from its beginnings in a  home office our passion for helping people and give them some advices about how to plant and take care of plants. We now serve customers all over Egypt, and are thrilled to be a part of the eco-friendly wing """,
                  style: AppTexeStyle2.body
                      .copyWith(fontSize: 18, color: Colors.grey),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          SizedBox(
            height: SizeConfig.screenWidth * 0.33,
            width: SizeConfig.screenWidth * 0.33,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: SizeConfig.screenWidth * 0.31,
                    width: SizeConfig.screenWidth * 0.31,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.green)),
                  ),
                ),
                Image.asset(
                  "assets/images/web/tset.png",
                  height: SizeConfig.screenWidth * 0.31,
                  width: SizeConfig.screenWidth * 0.31,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget blogs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          itemName("Blogs", ""),
          SizedBox(
            height: 300,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => Card(
                      elevation: 5,
                      child: SizedBox(
                        width: 250,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/web/image 74.png",
                              height: 150,
                              width: 250,
                              fit: BoxFit.fill,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("2 days ago",
                                        style: AppTexeStyle.title.copyWith(
                                            fontSize: 12, color: Colors.green)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "5 Simple Tips treat plant ",
                                      style: AppTexeStyle.title.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "leaf, in botany, any usually flattened green outgrowth from the stem of ",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTexeStyle.body.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (ctx, i) => const SizedBox(width: 20),
                itemCount: 10),
          )
        ],
      ),
    );
  }

  Widget bestSalers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          itemName("Best seller", ""),
          SizedBox(
            height: 300,
            child: ListView.separated(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => Column(
                  children: [
                    if (i.isEven)
                      const SizedBox(
                        height: 50,
                      ),
                    Image.asset(
                      "assets/images/web/image 57.png",
                      height: 150,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Plants",
                      style: AppTexeStyle2.heading.copyWith(fontSize: 25),
                    ),
                    Text(
                      "180 EGP",
                      style: AppTexeStyle2.heading.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    if (!i.isEven)
                      const SizedBox(
                        height: 50,
                      ),
                  ],
                ),
                separatorBuilder: (ctx, i) => const SizedBox(width: 20),
                itemCount: 10),
          )
        ],
      ),
    );
  }

  Widget popularCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          itemName("Popular", "Categories"),
          SizedBox(
            height: 250,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => Column(
                  children: [
                    Image.asset(
                      "assets/images/web/image 49.png",
                      height: 150,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Plants",
                      style: AppTexeStyle2.heading.copyWith(fontSize: 25),
                    )
                  ],
                ),
                separatorBuilder: (ctx, i) => const SizedBox(width: 20),
                itemCount: 10),
          )
        ],
      ),
    );
  }

  Row homeFirstPart() {
    return Row(
      children: [
        Image.asset(
          "assets/images/web/Background - 2022-08-07T152230 1.png",
          width: SizeConfig.screenWidth * 0.3,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Perfect way to plant in house",
                  style: AppTexeStyle2.heading
                      .copyWith(color: AppColors.green, fontSize: 25),
                ),
                Text(
                  "leaf, in botany, any usually flattened green outgrowth from the stem of a vascular plant. As the primary sites of photosynthesis, leaves manufacture food for plants, which in turn ultimately nourish and sustain all land animals.",
                  style: AppTexeStyle2.title.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: AppColors.green)),
                  minWidth: 180,
                  height: 45,
                  onPressed: () {},
                  color: AppColors.green,
                  child: Text(
                    "Explore Now",
                    style: AppTexeStyle.subtitle.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget itemName(text1, tetxt2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text1,
              style: AppTexeStyle2.heading.copyWith(fontSize: 25),
            ),
            const SizedBox(
              width: 5,
            ),
            const SizedBox(
                width: 25,
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ))
          ],
        ),
        if (tetxt2 != "")
          Text(
            tetxt2,
            style: AppTexeStyle2.heading.copyWith(fontSize: 25),
          ),
      ],
    );
  }
}
