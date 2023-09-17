import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/login_provider/reser_password.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';
import 'package:hotspot/presentation/widgets/teal_login_button.dart';
import 'package:hotspot/presentation/widgets/text_field.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedTealTextFormField(labelText: 'email',
            controller: context.read<ResetPassword>().emailController),
            SpaceWithHeight(size: size),
            TealLoginButton(
                onPressed: () async{
                 await context.read<ResetPassword>().resetPassword(context);
                },
                text: 'Reset',
                isLoading: context.read<ResetPassword>().isLoading)
          ],
        ),
      )),
    );
  }
}
