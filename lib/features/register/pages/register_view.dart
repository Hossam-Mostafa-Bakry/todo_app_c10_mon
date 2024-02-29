import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app_c10_mon/core/services/snack_bar_service.dart';
import 'package:todo_app_c10_mon/features/firebaseUtils.dart';
import 'package:todo_app_c10_mon/features/login/pages/login_view.dart';

import '../../../core/widgets/custom_text_field.dart';

class RegisterView extends StatelessWidget {
  static const String routeName = "register";
  var formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  RegisterView({super.key});

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
            "Create Account",
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
                    "Full Name",
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: fullNameController,
                    hint: "Enter your Full Name",
                    keyboardType: TextInputType.name,
                    hintColor: Colors.grey.shade700,
                    suffixWidget: const Icon(Icons.person),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter your password";
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(height: 20),
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
                        return "you must enter your e-mail";
                      }

                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if (!regex.hasMatch(value)) {
                        return "Invalid email";
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
                    onChanged: (value) {
                      print(passwordController.text);
                    },
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter your password";
                      }

                      var regex = RegExp(
                          r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");

                      if (!regex.hasMatch(value)) {
                        return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 8 characters long.";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Confirm Password",
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    isPassword: true,
                    maxLines: 1,
                    hint: "Enter your confirm password",
                    hintColor: Colors.grey.shade700,
                    suffixWidget: const Icon(Icons.email_rounded),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter your password";
                      }

                      if (value != passwordController.text) {
                        return "password not matched";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseUtils()
                            .createUserAccount(
                          emailController.text,
                          passwordController.text,
                        ).then((value) {
                          if (value) {
                            EasyLoading.dismiss();
                            SnackBarService.showSuccessMessage("Account successfully created");
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginView.routeName,
                              (route) => false,
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
                          "Create Account",
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
