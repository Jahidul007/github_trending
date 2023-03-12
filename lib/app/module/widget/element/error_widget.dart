import 'package:flutter/material.dart';
import 'package:github_trending/app/utils/constants.dart';

Widget buildErrorWidget(String errorMsg) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Center(
          child: Text(
            errorMsg,
            style: captionGrey,
          ),
        ),
      ),
    ],
  );
}
