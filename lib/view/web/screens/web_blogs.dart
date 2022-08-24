import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/bloc/main_bloc/app_cubit.dart';
import 'package:le_vie_app/bloc/main_bloc/app_states.dart';

class  WebBlog extends StatelessWidget {
  const WebBlog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, stste) {
          return const Center(child: Text("blogs"),);
        },
    );
  }
}