import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/aboutus/contactUs_controller.dart';
import 'package:learning_managment_system/core/class/handlinigdataview.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:learning_managment_system/core/functions/validinput.dart';
import 'package:learning_managment_system/view/widget/aboutUs/customContactUs.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';

class ContactUs extends StatelessWidget {
 const ContactUs({super.key});
 @override
  Widget build(BuildContext context) {
  final ContactUsControllerImp controllerImp=Get.put(ContactUsControllerImp());
  return Scaffold(
   appBar: AppBar(
    centerTitle: true,
    elevation: 5,
    leading: IconButton(
     onPressed: () { Get.back();},
     icon: const Icon(Icons.arrow_back),),
    title:const Text('Contact Us' ,
     textAlign:TextAlign.start,
     style: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w700,
      color: AppColor.primaryColor, ),) ,
                        ),                    
     body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 4 , vertical: 5),
      child: GetBuilder<ContactUsControllerImp>(builder: (controller)=>
         HandinigDataRequest(statusRequest: controller.statusRequest, widget:
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
               "Got questions, feedback, or just want to chat? We're here to help! Reach out to us through your preferred channel:" ,
               textAlign:TextAlign.center,
               style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w600,),),
              const SizedBox(height: 15,),
              CustomContact(
               icon:Icons.telegram_outlined ,
               text:'FekraApp2024',
               onPressed:(){controllerImp.goUrl(controller.telegramUrl);},),
              const SizedBox(height: 8,),
              CustomContact(
                icon:Icons.email_rounded,
                text:'FekraApp2024@gmail.com',
                onPressed:(){controllerImp.goUrl(controller.emailUrl);}),
              const SizedBox(height: 8,),
              CustomContact(
                icon:Icons.facebook_outlined,
                text:'Fekra App2024',
                onPressed:(){controllerImp.goUrl(controller.facebookUrl);}),
              Image.asset(ImageAsset.contactUs ,height: Get.height/4, ), 
              const Text(
                "Or you can let your message in the box" ,
                 textAlign:TextAlign.center,
                 style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w600,),),
              Container(
                margin: const EdgeInsets.only(top: 35 , left: 20 , right: 20),
                child: Form(
                  key: controllerImp.formState,
                  child: TextFormField(
                   cursorColor:AppColor.primaryColor ,
                   maxLines: 3,
                   controller: controllerImp.message,
                   validator: (value) {
                     return validInput(value!, 2, 350, 'nothing');
                   },
                  decoration: InputDecoration(
                    fillColor: AppColor.primaryColor,
                    hintStyle: const TextStyle(fontSize: 12 ),
                    hintText: 'Write your message...',
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor ), borderRadius: BorderRadius.circular(20) ),
                    focusColor: AppColor.primaryColor,
                    floatingLabelBehavior:FloatingLabelBehavior.always ,
                    contentPadding:const EdgeInsets.symmetric( horizontal: 20 , vertical:35) ,
                    label: Container(margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text('Message',)),
                    suffixIcon:  const Icon(Icons.message_outlined),
                     border: OutlineInputBorder( borderRadius: BorderRadius.circular(20))),),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.size.width/4, vertical: 10),
                child: CustomButton(textButton: 'Send', onTap: (){controllerImp.sendMessage();} ),
              ),
            ]),
    )
    )
    )                    
    );
  }
}
