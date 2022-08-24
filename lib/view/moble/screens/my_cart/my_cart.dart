

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/bloc/main_bloc/app_cubit.dart';
import 'package:le_vie_app/model/plantsModel.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';
import 'package:le_vie_app/view/moble/widgets/empty.dart';

import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';
import '../../../common_view/widgets.dart';
import 'my_cart_widgets.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  TextEditingController visa = TextEditingController();
  TextEditingController visaPass = TextEditingController();
  var keyf = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        int price = 0;
        for (var element in cubit.myCarts) {
          price = price + element.price! * element.indx;
        }
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "My Cart",
                style: AppTexeStyle.subheading,
              ),
              leading: IconButton(
                icon: const Icon(Icons.keyboard_backspace),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.white,
            body: cubit.myCarts.isNotEmpty
                ? SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        myItems(context),
                        const SizedBox(
                          height: 30,
                        ),
                        checkOut(price, context, keyf, visa, visaPass),
                      ],
                    ),
                  )
                : emptyWidget("no items", "", SizeConfig.screenHeight * 0.22),
          ),
        );
      },
    );
  }

  Widget myItems(context) {
    AppCubit cubit = AppCubit.get(context);
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) => myItemsCard(cubit.myCarts[i]),
        separatorBuilder: (context, i) => const Divider(color: Colors.grey),
        itemCount: cubit.myCarts.length);
  }

  Widget myItemsCard(Product product) {
    AppCubit cubit = AppCubit.get(context);
    return Card(
      color: AppColors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return Row(
            children: [
              webImage(
                product.imageurl,
                boxConstraints.maxWidth * 0.4,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      style: AppTexeStyle.title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${product.price} EGP",
                        style: AppTexeStyle.title
                            .copyWith(fontSize: 12, color: Colors.green)),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: AppColors.filedBackGround,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    product.indx++;
                                  });
                                  await product.update();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.filedBackGround,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 14,
                                  ),
                                ),
                              ),
                              Text(product.indx.toString(),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black)),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    if (product.indx > 1) {
                                      product.indx--;
                                    }
                                  });
                                  await product.update();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.filedBackGround,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              cubit.inMyCart(product, context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.green,
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
