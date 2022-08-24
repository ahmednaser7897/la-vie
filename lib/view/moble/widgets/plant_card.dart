import 'package:flutter/material.dart';
import 'package:le_vie_app/model/plantsModel.dart';
import 'package:le_vie_app/view/common_view/widgets.dart';

import '../../../bloc/main_bloc/app_cubit.dart';
import '../../common_view/theme/app_colors.dart';
import '../../common_view/theme/app_text_styles.dart';

class PlantCard extends StatefulWidget {
  const PlantCard({Key? key,required this.product}) : super(key: key);
  final Product product;
  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit=AppCubit.get(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: constraints.maxHeight - constraints.maxHeight * 0.2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                              child:
                                  Text(widget.product.name!, style: AppTexeStyle.title)),
                          FittedBox(
                            child: Text(widget.product.price!.toString()+" EGP",
                              //"70 EGP",
                                style: AppTexeStyle.title.copyWith(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: SizedBox(
                                width: double.infinity,
                                child: 
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  onPressed: () {
                                    cubit.inMyCart(widget.product, context);
                                  },
                                  color: AppColors.green,
                                  child: FittedBox(
                                    child: Text(
                                      "Add To Card",
                                      style: AppTexeStyle.subtitle
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child:webImage(widget.product.imageurl, constraints.maxWidth * 0.6)
          ),
          Positioned(
            right: 10,
            top: constraints.maxHeight * 0.45,
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      widget.product.indx++;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                Text(widget.product.indx.toString(), style:const TextStyle(fontSize: 14, color: Colors.black)),
                InkWell(
                  onTap: (){
                    setState(() {
                      if(widget.product.indx>1) {
                        widget.product.indx--;
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
        ],
      );
    });
  }
}
