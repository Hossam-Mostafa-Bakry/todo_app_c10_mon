import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app_c10_mon/core/services/snack_bar_service.dart';
import 'package:todo_app_c10_mon/core/widgets/custom_text_field.dart';
import 'package:todo_app_c10_mon/features/firebaseUtils.dart';
import 'package:todo_app_c10_mon/features/layout_view.dart';
import 'package:todo_app_c10_mon/features/register/pages/register_view.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "login";

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(
          image: AssetImage(
            "assets/images/pattern.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Login",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mediaQuery.height * 0.15,
                  ),
                  Text(
                    "Welcome back!",
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "E-mail",
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hint: "Enter your e-mail address",
                    keyboardType: TextInputType.emailAddress,
                    hintColor: Colors.grey.shade700,
                    suffixWidget: const Icon(Icons.email_rounded),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "You must enter your e-mail address";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Password",
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    isPassword: true,
                    maxLines: 1,
                    hint: "Enter your password",
                    hintColor: Colors.grey.shade700,
                    suffixWidget: const Icon(Icons.email_rounded),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "You must enter your password";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     backgroundColor: Colors.white,
                      //     title: Text("Loading....."),
                      //
                      //   ),
                      // );
                      if (formKey.currentState!.validate()) {
                        FirebaseUtils().loginUserAccount(
                          emailController.text,
                          passwordController.text,
                        ).then((value) {
                          if (value == true) {
                            EasyLoading.dismiss();
                            SnackBarService.showSuccessMessage("Successfully logged in");
                            Navigator.pushReplacementNamed(
                              context,
                              LayoutView.routeName,
                            );
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login",
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "OR",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RegisterView.routeName,
                      );
                    },
                    child: Text(
                      "Create new account !..",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // appBar: ,
      ),
    );
  }
}
