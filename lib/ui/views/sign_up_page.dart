import 'package:crypto_questor/ui/views/sign_in_page.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String name, email, password;
  final formKey = GlobalKey<FormState>();
  bool _passwordVisibility = true;
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.sizeOf(context).height;
    double myWidht = MediaQuery.sizeOf(context).width;
    return Form(
      key: formKey,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xff001E34),
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
                              horizontal: 30, vertical: 70),
                          child: Image.asset(
                            "assets/blockchain.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: myHeight / 3,
                        width: myWidht,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _nameField(myWidht),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: myWidht / 5),
                          child: Row(
                            children: [
                              const Text(
                                "I'm aldready registered",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
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
                                    "Log in",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurpleAccent.shade200),
                                  ))
                            ],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              try {
                var result =
                await FirebaseService().signUp(name, email, password);
                if (result == "success") {
                  formKey.currentState!.reset();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: const Color(0xffFFD400),
                      duration: const Duration(seconds: 2),
                      content: Text(
                        "New User Created",
                        style:
                        TextStyle(color: Colors.deepPurpleAccent.shade700),
                      )));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xff001E34),
                          title: const Text(
                            "ERROR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFFD400),
                            ),
                          ),
                          content: Text(
                            result!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Try Again",
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent.shade700),
                                )),
                          ],
                        );
                      });
                }
              } catch (e) {
                print(e.toString());
              }
            } else {}
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFFD400),
          ),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple.shade900),
          ),
        ),
      ),
    );
  }

  Padding _passwordField(double myWidht) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffFFD400),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color(0xffFFD400),
            )),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorStyle: const TextStyle(
                fontSize: 15,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.w500),
            prefixIcon: const Icon(
              Icons.key,
              size: 30,
              color: Colors.deepPurple,
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
                  color: Colors.deepPurple,
                )),
            hintText: "Password",
            hintStyle: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurple,
          ),
          obscuringCharacter: '*',
          obscureText: _passwordVisibility,
          validator: (value) {
            if (value!.isEmpty) {
              return "Cannot be Empty";
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffFFD400),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color(0xffFFD400),
            )),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorStyle: const TextStyle(
                fontSize: 15,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.w500),
            prefixIcon: const Icon(
              Icons.mail_outline_rounded,
              size: 30,
              color: Colors.deepPurple,
            ),
            hintText: "E-mail",
            hintStyle: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurple,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Cannot be Empty";
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

  Padding _nameField(double myWidht) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffFFD400),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color(0xffFFD400),
            )),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorStyle: const TextStyle(
                fontSize: 15,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.w500),
            prefixIcon: const Icon(
              Icons.person_sharp,
              size: 30,
              color: Colors.deepPurple,
            ),
            hintText: "Name",
            hintStyle: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurple,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Cannot be Empty";
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
