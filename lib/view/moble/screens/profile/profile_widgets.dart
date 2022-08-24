import 'package:flutter/material.dart';

import '../../../../bloc/main_bloc/app_cubit.dart';
import '../../widgets/form.dart';
import '../logein screens/login.dart';

Widget changeData(ctx, keyf, fname, lname, email, {bool name = true}) {
  AppCubit cubit = AppCubit.get(ctx);
  return AlertDialog(
    insetPadding: const EdgeInsets.all(10),
    contentPadding: const EdgeInsets.all(15),
    elevation: 5,
    scrollable: true,
    title: Text(name ? 'Change Name' : 'Change Email'),
    content: Form(
      key: keyf,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (name) ...formfiled(fname, "First Name", false),
          if (name)
            const SizedBox(
              height: 15,
            ),
          if (name) ...formfiled(lname, "Last Name", false),
          if (name)
            const SizedBox(
              height: 15,
            ),
          if (!name) ...formfiled(email, "Email", false),
        ],
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text("Cancel")),
      TextButton(
          onPressed: () async {
            if (keyf.currentState!.validate()) {
              if (name) {
                cubit.updateUser(ctx,fName: fname.text, lName: lname.text);
              } else {
                cubit.updateUser(ctx,email: email.text);
              }
            }
          },
          child: const Text("Change")),
    ],
  );
}

Widget logOut(ctx, {String? text}) {
  AppCubit cubit = AppCubit.get(ctx);
  return AlertDialog(
    title: const Text('Log out'),
    content: Text(text ?? "Do you want to logout from your account?"),
    elevation: 5,
    actions: [
      if (text == null)
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text("Cancel")),
      TextButton(
          onPressed: () async {
            await cubit.logeout();
            await cubit.changBottomBarIndix(2, ctx);
            Navigator.push(
                ctx, MaterialPageRoute(builder: (context) => const LogIn()));
          },
          child: const Text("Logout")),
    ],
  );
}
