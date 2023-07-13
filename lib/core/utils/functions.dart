import 'dart:convert';

import 'package:flutter_starter_like_comment/core/utils/strings.dart';

import 'failure.dart';

bool isArabic(String text) {
  LineSplitter ls = const LineSplitter();
  List<String> lines = ls.convert(text);

  if (lines.isEmpty) {
    return true;
  }

  var firstLine = lines.first.split(' ');
  if (firstLine.isEmpty) {
    return true;
  }

  for (var i = 0; i < firstLine[0].length; i++) {
    final codeUnit = firstLine[0].codeUnitAt(i);
    if ((codeUnit >= 0x0600 && codeUnit <= 0x06FF)) {
      return true;
    }
  }
  return false;
}

String mapFailureToMessage(Failure failure, {String? errorMessage}) {
  if (failure is ServerFailure) {
    return isArabic(failure.message)
        ? failure.message
        : errorMessage ?? Strings.SERVER_FAILURE_MESSAGE;
  } else if (failure is ServerFailure) {
    return "حدثت مشكلة.\n الرجاء معاودة المحاولة في وقت لاحق.";
  } else if (failure is OfflineFailure) {
    return Strings.OFFLINE_FAILURE_MESSAGE;
  } else {
    return "Unexpected Error , Please try again later .";
  }
}

