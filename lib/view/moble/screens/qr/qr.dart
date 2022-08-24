import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/model/blogs.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';
import 'package:le_vie_app/view/moble/screens/qr/plant_details.dart';
import 'package:flutter/services.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../../../shared/services/size_config.dart';
import '../../../common_view/theme/app_colors.dart';

class QRViewPlants extends StatefulWidget {
  const QRViewPlants({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewPlantsState();
}

class _QRViewPlantsState extends State<QRViewPlants> {
  dynamic _scanBarcode = '';
  late AppCubit cubit;
  late Function fun;
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> dispose() async {
    _scanBarcode = '';
    cubit.endQrRead();
    super.dispose();
    await fun();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print("barcodeScanRes  " + barcodeScanRes);
    } on PlatformException {
      print('Failed to get platform version.');
      barcodeScanRes = "";
    } catch (e) {
      print("Failed in qr " + e.toString());
      barcodeScanRes = "";
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = AppCubit.get(context);
        fun = () async {
          await cubit.changBottomBarIndix(2, context);
        };
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/mobile/Meet the Maker_ Nathalie Gibbins _ Rose & Grey 1.png"),
                    fit: BoxFit.cover)),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                      onTap: () async {
                        await scanQR();
                        print("_scanBarcode is " + _scanBarcode);
                        if (_scanBarcode != "-1") {
                          await cubit.getProductById(
                              _scanBarcode.toString(), context);
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/images/mobile/Rectangle 75.png",
                            width: SizeConfig.screenWidth * 0.6,
                          ),
                          Text("Click Here To Scan",
                              style: AppTexeStyle.title.copyWith(
                                color: Colors.white,
                              )),
                        ],
                      )),
                  if (cubit.productId != null)
                    goTodetielsBoutton(context, state)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //LodingGetProductByIdData
  Widget goTodetielsBoutton(BuildContext context, state) {
    return (state is LodingGetProductByIdData ||state is LoadingGetFavCart)
        ? const Positioned(bottom: 20, child: CircularProgressIndicator())
        : Positioned(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: SizeConfig.screenWidth * 0.95,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[300]!.withOpacity(0.7),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (cubit.productId != null)
                                ? cubit.productId!.plant!.name!
                                : "SNAKE PLANT (SANSEVIERIA)",
                            style: AppTexeStyle.subtitle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            (cubit.productId != null)
                                ? cubit.productId!.plant!.description!
                                : "Native to southern Africa",
                            style: AppTexeStyle.subbody,
                          )
                        ],
                      ),
                    ),
                    FloatingActionButton(
                      elevation: 0,
                      mini: true,
                      onPressed: () {
                        Plant plant = Plant(
                            description: "Common Snake Plant Diseases",
                            id: "",
                            imageUrl: "",
                            name: "SNAKE PLANT (SANSEVIERIA)",
                            sunLight: 67,
                            temperature: 35,
                            waterCapacity: 29);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlantDetails(
                                      plant: cubit.productId!.plant ?? plant,
                                    ))).then((value) async {
                          Navigator.pop(context);
                        });
                      },
                      backgroundColor: AppColors.green,
                      child: const Icon(Icons.arrow_forward_outlined),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
