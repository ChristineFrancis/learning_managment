import 'package:flutter/material.dart';
import 'package:learning_managment_system/core/constant/color.dart';

class CustomAboutUs extends StatelessWidget {
  final String title;
  final String sentence;
  const CustomAboutUs({super.key, required this.title, required this.sentence});
  

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
      Row(
       children: [
        const Padding(
         padding: EdgeInsets.only(right: 2 , left: 1),
         child: Icon(Icons.circle , color: AppColor.violetColor,size: 10,),),
        Text(
         title ,
         textAlign:TextAlign.center,
         style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,),),
                          ],),
       Text(
        sentence ,
        textAlign:TextAlign.center,
        style: const TextStyle(
          color: AppColor.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,),),
                    ],
                 );
  }
}