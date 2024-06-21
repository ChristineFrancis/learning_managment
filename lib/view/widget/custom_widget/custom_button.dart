import 'package:flutter/material.dart';
import 'package:learning_managment_system/core/constant/color.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final Function() onTap;
  const CustomButton({super.key, required this.textButton, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:50,           
      decoration: const BoxDecoration(
       color: AppColor.primaryColor,
       borderRadius:  BorderRadius.only(
       bottomLeft:Radius.circular(40) ,
       topRight: Radius.circular(40) )),
      child: MaterialButton(
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.only( 
            bottomLeft:Radius.circular(40) ,
            topRight: Radius.circular(40))) ,
        onPressed:onTap ,
        child: Center(
         child: Text(textButton , 
          style: const TextStyle(color:AppColor.whiteColor , fontWeight: FontWeight.w400 , fontSize: 20 , fontFamily: 'Exo2',),),),
                ),
    );
  }
}