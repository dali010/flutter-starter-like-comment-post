import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black.withOpacity(0.45),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: const SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: Color(0xff27AABF),
        ),
      ),
    );
  }
}
