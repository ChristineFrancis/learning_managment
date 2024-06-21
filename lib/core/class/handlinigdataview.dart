
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:lottie/lottie.dart';


class HandinigDataView extends StatelessWidget {
  
  final StatusRequest statusRequest;
  final Widget widget;
  const HandinigDataView({super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return 
    statusRequest ==StatusRequest.loading ?
    const Center(child: Text('Loading'),) :

    statusRequest ==StatusRequest.offlineFailure ?
    const Center(child: Text('offlineFailure'),) :

    statusRequest ==StatusRequest.serverFailure ?
    const Center(child: Text('serverFailure'),) :

    statusRequest ==StatusRequest.failure ?
    const Center(child: Text('NoData'),) :

    widget;
  }
}


class HandinigDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandinigDataRequest({super.key, required this.statusRequest, required this.widget});

  void showOfflineDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.size.height / 3,
              child: Lottie.asset(ImageAsset.offlineLottie, fit: BoxFit.fitHeight),
            ),
            const Text(
              'You are offline\nCheck your internet',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.primaryColor, fontSize: 30, fontWeight: FontWeight.w700, ), ),
          ] ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('try again' , style: TextStyle( color: AppColor.primaryColor,)),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
     if (statusRequest == StatusRequest.offlineFailure) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showOfflineDialog(context);
      });
    }
    return statusRequest == StatusRequest.loading
        ? Center(child: Lottie.asset(ImageAsset.loadingLottie))
        : statusRequest == StatusRequest.serverFailure
        ? const Center(child: Text('Server failure'))
        : widget;
  }
}