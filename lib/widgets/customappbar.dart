import 'package:flutter/material.dart';

import '../ui/views/intro_page.dart';

class CustomAppBar extends StatelessWidget{
  CustomAppBar({
    required this.title,
    required this.icon,
    required this.iconSize,
    required this.iconColor,

  });

  String title;
  IconData icon;
  double iconSize;
  Color iconColor;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(90),
      )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(90),
          ),
          color: const Color(0xffFFD400).withOpacity(0.8),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 23),
        child: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const IntroPage()));
        }, icon:const Icon(Icons.arrow_back_ios_rounded,size: 26,color: Color(0xff001E34),)),
      ),
      title:  Padding(
        padding:  const EdgeInsets.only(top: 30,left: 10),
        child: Row(

          children: [
            Icon(icon,
              size: iconSize,
              color: iconColor,
            ),
            const SizedBox(width: 30,),
            Text(
              title,
              style: const TextStyle(
                  color: Color(0xff001E34),
                  fontSize: 23,fontWeight: FontWeight.w800),),
          ],
        ),
      ),
    ); // Your custom widget implementation.
  }


}