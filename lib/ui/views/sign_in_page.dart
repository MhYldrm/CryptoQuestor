import 'package:crypto_questor/ui/views/sign_up_page.dart';
import 'package:crypto_questor/utils/colors.dart';
import 'package:crypto_questor/utils/texts.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';
import 'intro_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late String name, email, password;
  final formKey = GlobalKey<FormState>();
  bool _passwordVisibility = true;
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.sizeOf(context).height;
    double myWidht = MediaQuery.sizeOf(context).width;
    var mText = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: CustomColors.bgcolor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: myHeight / 2.5,
                        width: myWidht,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 110, vertical: 90),
                          child: Image.asset(
                            CustomTexts().walletImagePath,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: myHeight / 4,
                        width: myWidht,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _emailField(myWidht),
                            _passwordField(myWidht),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: myWidht,
                          child: _buttonWidget(myWidht),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(
                                  mText.isNotHaveAccount,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: CustomColors.mGreyPrimary,),
                                ),
                                const SizedBox(width: 10,),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const SignUpPage()));
                                    },
                                    child:  Text(
                                      mText.signUp,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.mYellow,),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Padding _buttonWidget(double myWidht) {
    var mText = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              final result = await FirebaseService().signIn(email, password);
              if (result == "success") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const IntroPage()));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: CustomColors.bgcolor,
                        title:  Text(
                          mText.error,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.mYellow,
                          ),
                        ),
                        content: Text(
                          result!,
                          style: const TextStyle(color: CustomColors.mWhitePrimary),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child:  Text(
                                mText.tryAgain,
                                style: const TextStyle(
                                    color: CustomColors.mYellow),
                              )),
                        ],
                      );
                    });
              }
            } else {}
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.mYellow,
          ),
          child:  Text(
            mText.login,
            style: const TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                color: CustomColors.mPurple),
          ),
        ),
      ),
    );
  }

  Padding _passwordField(double myWidht) {
    var mText = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
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
            errorStyle: const TextStyle(
                fontSize: 15,
                color: CustomColors.mPurple,
                fontWeight: FontWeight.w500),
            prefixIcon: const Icon(
              Icons.key,
              size: 30,
              color: CustomColors.mPurple,
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisibility = !_passwordVisibility;
                  });
                },
                icon: Icon(
                  _passwordVisibility
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: CustomColors.mPurple,
                )),
            hintText: mText.password,
            hintStyle: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w400, color: CustomColors.mBlackPrimary,),
          ),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: CustomColors.mPurple,
          ),
          obscuringCharacter: '*',
          obscureText: _passwordVisibility,
          validator: (value) {
            if (value!.isEmpty) {
              return mText.cannotEmpty;
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

  Padding _emailField(double myWidht) {
    var mText = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
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
            errorStyle: const TextStyle(
                fontSize: 15,
                color: CustomColors.mPurple,
                fontWeight: FontWeight.w500),
            prefixIcon: const Icon(
              Icons.mail_outline_rounded,
              size: 30,
              color: CustomColors.mPurple,
            ),
            hintText: mText.email,
            hintStyle: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w400, color: CustomColors.mBlackPrimary,),
          ),
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: CustomColors.mPurple,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return mText.cannotEmpty;
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
}
