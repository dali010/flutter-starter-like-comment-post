import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarMessage {
  void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF27AABF),
          ),
          child: Text(message,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700),
              textDirection: TextDirection.rtl),
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        // Set the background color to transparent
        elevation: 0,
        duration: const Duration(seconds: 1)));
  }

  void showErrorSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          // height: 28.h,
          alignment: Alignment.center,
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFFF4B346),
          ),
          child: Text(
            message,
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ),
        backgroundColor: Colors.transparent,
        // Set the background color to transparent
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 3)));
  }
}
