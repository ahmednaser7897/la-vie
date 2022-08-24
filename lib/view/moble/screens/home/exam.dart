

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:le_vie_app/view/common_view/theme/app_colors.dart';
import 'package:le_vie_app/view/common_view/widgets.dart';

import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_text_styles.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  PageController controller=PageController(keepPage: true,initialPage: 0);
  int val = -1;
  int page=0;
  int grade=0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.07),
          child: Column(children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            Text(
              "Course Exam",
              style: AppTexeStyle.subheading,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.065,
            ),
            Expanded(child: examQuestions())
          ]),
        ),
      ),
    );
  }

  Widget examQuestions() {
    return PageView.builder(
      itemBuilder: (context, index) => question(index,2,context),
      itemCount: 5,
      controller: controller,
      physics:const NeverScrollableScrollPhysics(),
      onPageChanged: (i){
        setState(() {
          page=i;
        });
      },
    );
  }

  Widget question(int index, correctAnswer,ctx) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Question",
                style: AppTexeStyle.heading,
              ),
              const SizedBox(
                width: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection:
                        VerticalDirection.up, // <-- reverse direction
                    children: [
                      Text(
                        (index + 1).toString(),
                        style: AppTexeStyle.heading
                            .copyWith(color: AppColors.green, fontSize: 26),
                      ), // <-- first child
                    ],
                  ),
                  Text(
                    "/5",
                    style: AppTexeStyle.body.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Text(
                "How old was Prophet Muhammad, may God bless him and grant him peace, when he died?",
                style: AppTexeStyle.subheading,
              ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          radioItem(0,"67 years old"),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          radioItem(1,"65 years old"),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          radioItem(2,"63 years old"),
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Row(
            mainAxisAlignment:kIsWeb?MainAxisAlignment.end:
             (page !=0)? MainAxisAlignment.spaceBetween:MainAxisAlignment.end,
            children: [
              if(page!=0)
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0),
                side: BorderSide(color: AppColors.green)
                 ), 
                minWidth:kIsWeb?180: SizeConfig.screenWidth * 0.4,
                onPressed: () {
                  if(page!=0){
                    controller.jumpToPage(page-1);
                  }
                },
                //color: AppColors.green,
                child: Text(
                  "Back",
                  style: AppTexeStyle.subtitle.copyWith(color: Colors.green),
                ),
              ),
              if(kIsWeb)
              const SizedBox(width: 50,),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ,
                side: BorderSide(color: AppColors.green)
                ),
                minWidth:kIsWeb?180: SizeConfig.screenWidth * 0.4,
                onPressed: () {
                  if(correctAnswer==val){
                    setState(() {
                      grade++;
                    });
                  }
                  if(page!=4){
                    controller.jumpToPage(page+1);
                  }else{
                    buildToast(ctx, "your grade is $grade");
                    Navigator.pop(ctx);
                  }
                },
                color: AppColors.green,
                child: Text(
                 page==4?"Finish":"Next",
                  style: AppTexeStyle.subtitle.copyWith(color: Colors.white),
                ),
              ), 
            ],
          )
        ],
      ),
    );
  }

  Widget radioItem(int value,String answer) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.green),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(children: [
        Expanded(
            child: Text(
          answer,
          style: AppTexeStyle.subtitle,
        )),
        Radio(
          value: value,
          groupValue: val,
          activeColor: Colors.green,
          onChanged: (v) {
            setState(() {
              val = v as int;
            });
          },
        )
      ]),
    );
  }
}
