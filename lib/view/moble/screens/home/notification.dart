// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/shared/services/size_config.dart';
import 'package:le_vie_app/view/common_view/theme/app_text_styles.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../../../bloc/main_bloc/app_states.dart';
import '../../widgets/notifacation_widget.dart';

class NotificationScrean extends StatelessWidget {
  const NotificationScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Notification",
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
            body: cubit.user == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.04,
                        ),
                        Expanded(
                          child: notificationList(context),
                        )
                      ],
                    ),
                  ),
                );
      },
    );
  }
}
