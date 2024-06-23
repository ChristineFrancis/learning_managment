import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';

class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   int? valu;
  @override
  Widget build(BuildContext context) {
    Get.put(QuizControllerImp());
    return Scaffold(
      body: GetBuilder<QuizControllerImp>(
          builder: (controller) =>
         ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                RadioListTile(title:Text('koko0') , value:0 , groupValue: controller.valu, 
                onChanged: (val){
                  controller.valu=val;
                  controller.update();
                //   setState(() {
                //   valu=val;
                // });
                 print(controller.valu);
                }),
        
                 RadioListTile(title:Text('koko1') , value:1, groupValue: controller.valu, 
                onChanged: (val){
                  controller.valu=val;
                  controller.update();
                  
                //   setState(() {
                //   valu=val;
                // });
                print(controller.valu);
                }),
        
                 RadioListTile(title:Text('koko2') , value:2 , groupValue: controller.valu, 
                onChanged: (val){
                  controller.valu=val;
                  controller.update();
                //   setState(() {
                //   valu=val;
                // });
                print(controller.valu);}),
              ],
            );
        
          },),
      ),
    );
  }
}