import 'package:crypto_questor/core/components/button/my_custom_button.dart';
import 'package:crypto_questor/core/constants/app_constants.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/view/screens/sign_in_page.dart';
import 'package:crypto_questor/view/widgets/empty_widget.dart';
import 'package:flutter/material.dart';

import '../../core/services/firebase_service.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String name, email, password;
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;
  @override
  Widget build(BuildContext context) {
    double myWidht = MediaQuery.sizeOf(context).width;
    return Form(
      key: formKey,
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColors.bgcolor,
            body: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Expanded(
                      flex: 2,
                      child: BlockchainImageWidgets(),),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        nameField(myWidht),
                        EmptyWidget(value: 30),
                        emailField(myWidht),
                        EmptyWidget(value: 30),
                        passwordField(myWidht),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        MyCustomButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              var result =
                              await FirebaseService().signUp(name, email, password);
                              if (result == "success") {
                                formKey.currentState!.reset();
                                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(context));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignInPage()));
                              } else {
                                buildErrorShowDialog(result);
                              }
                            }
                          },
                          textName: context.mLocalizations.signUp,
                        ),
                        BuildBottomWidget(widht: myWidht/10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }


  // If sign up is success show Snack bar
  SnackBar buildSnackBar(BuildContext context) {
    return SnackBar(
        backgroundColor: CustomColors.mYellow,
        duration: const Duration(seconds: 2),
        content: Text(
          context.mLocalizations.newUserCreated,
          style: const TextStyle(color: CustomColors.bgcolor),));
  }


  // If signup failed or some error
  Future<dynamic> buildErrorShowDialog(String? result) {
    return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: CustomColors.bgcolor,
                        title:  Text(
                          context.mLocalizations.error,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.mYellow,
                          ),
                        ),
                        content: Text(
                          result!,
                          style:  const TextStyle(color: CustomColors.mWhitePrimary,),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                context.mLocalizations.tryAgain,
                                style: const TextStyle(
                                    color: CustomColors.mYellow,),
                              )),
                        ],
                      );
                    });
  }


  // Name - Email and Password TextFields
  Padding passwordField(double widht) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widht / 10.5),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.mYellow,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: CustomColors.mYellow,
            )),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
            prefixIcon: const Icon(
              Icons.key,
              size: 30,
              color: CustomColors.mPurple,
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisibility = !passwordVisibility;
                  });
                },
                icon: Icon(
                  passwordVisibility
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: CustomColors.mPurple,
                )),
            hintText: context.mLocalizations.password,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
          ),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
          obscuringCharacter: '*',
          obscureText: passwordVisibility,
          validator: (value) {
            if (value!.isEmpty) {
              return context.mLocalizations.cannotEmpty;
            } else {}
            return null;
          },
          onSaved: (value) {
            password = value!;
          },
        ),
      ),
    );
  }

  Padding emailField(double widht) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widht / 10.5),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.mYellow,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: CustomColors.mYellow,
            )),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
            prefixIcon: const Icon(
              Icons.mail_outline_rounded,
              size: 30,
              color: CustomColors.mPurple,
            ),
            hintText: context.mLocalizations.email,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
          ),
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
          validator: (value) {
            if (value!.isEmpty) {
              return context.mLocalizations.cannotEmpty;
            } else {}
            return null;
          },
          onSaved: (value) {
            email = value!;
          },
        ),
      ),
    );
  }

  Padding nameField(double widht) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widht / 10.5),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.mYellow,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: CustomColors.mYellow,
            )),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
            prefixIcon: const Icon(
              Icons.person_sharp,
              size: 30,
              color: CustomColors.mPurple,
            ),
            hintText: context.mLocalizations.name,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
          ),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
          validator: (value) {
            if (value!.isEmpty) {
              return context.mLocalizations.cannotEmpty;
            } else {}
            return null;
          },
          onSaved: (value) {
            name = value!;
          },
        ),
      ),
    );
  }
}

// -Already Registered- part widget
class BuildBottomWidget extends StatelessWidget {
  final double widht;
  const BuildBottomWidget({
    required this.widht,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: widht),
      child: Row(
        children: [
          Text(
            context.mLocalizations.isHaveAccount,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CustomColors.mGreyPrimary),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SignInPage()));
              },
              child: Text(
                context.mLocalizations.login,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mYellow,fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}

// -Blockchain Image- part widget
class BlockchainImageWidgets extends StatelessWidget {
  const BlockchainImageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widht/10,
      ),
      child: Image.asset(
        ApplicationConstants.blockchainImagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}