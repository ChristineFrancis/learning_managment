import 'package:flutter/material.dart';
import 'package:learning_managment_system/core/constant/color.dart';

class CustomContact extends StatelessWidget {
  final IconData icon;
  final String text;
 final void Function() onPressed;
   const CustomContact({super.key, required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
     Icon(icon ,size:35,color: AppColor.grey,),
     const SizedBox(width: 5,),
     TextButton(
     onPressed: onPressed,
     style: ButtonStyle(
     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
     minimumSize: MaterialStateProperty.all(const Size(0, 0)),
     tapTargetSize: MaterialTapTargetSize.padded,),
    child: Text(text,style: const TextStyle(fontSize: 17 , fontWeight: FontWeight.w500), )),
               ],);
  }
}