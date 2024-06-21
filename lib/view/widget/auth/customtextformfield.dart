import 'package:flutter/material.dart';
import 'package:learning_managment_system/core/constant/color.dart';


class CustomTextFormFieldAuth extends StatelessWidget {
  final String hintTextAuth;
  final String labelTextAuth;
  final  IconData suffixIconAuth;
  final TextEditingController controllerAuth;
  final String? Function(String?) valid;
  final bool isNum;
  final bool? obscureText ;
  final void Function()? onTap;
  const CustomTextFormFieldAuth({super.key, required this.hintTextAuth, required this.labelTextAuth, required this.suffixIconAuth,
   required this.controllerAuth, required this.valid, required this.isNum, this.obscureText, this.onTap
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 35),
      child: TextFormField(
         keyboardType:isNum ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text ,
         validator: valid,
         controller: controllerAuth,
         obscureText:obscureText==null || obscureText==false ? false : true ,
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 12 ),
                hintText: hintTextAuth,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor ), borderRadius: BorderRadius.circular(20) ),
                focusColor: AppColor.primaryColor,
                floatingLabelBehavior:FloatingLabelBehavior.always ,
                contentPadding:const EdgeInsets.symmetric( horizontal: 30 , vertical: 20) ,
                label: Container(margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(labelTextAuth ,)),
                suffixIcon: InkWell(child: Icon(suffixIconAuth),onTap:onTap ,),
                 border: OutlineInputBorder( borderRadius: BorderRadius.circular(20))),),
    );
  }
}