import 'package:flutter/material.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_repository/top_repository_response.dart';
import 'package:github_trending/app/module/widget/custom_height_width.dart';
import 'package:github_trending/app/module/widget/item_with_value.dart';
import 'package:github_trending/app/utils/constants.dart';
import 'package:github_trending/app/utils/util_values.dart';
import 'package:github_trending/app/utils/string_extension.dart';

class TopRepositoryDetailsScreen extends StatelessWidget {
  final ItemRepository items;

  const TopRepositoryDetailsScreen({Key? key, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Repository Details"),
        centerTitle: true,
      ),
      backgroundColor: dashboardBgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      getDisplayText(items.name),
                      style:
                          textHeadingWhiteStyle.copyWith(color: primaryColor),
                    ),
                    customHeight(),
                    Text(
                      getDisplayText(items.description),
                      style: body2regular,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            customHeight(),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ItemWithValue("Language", getDisplayText(items.language)),
                    customHeight(),
                    ItemWithValue("Star",
                        getDisplayText(items.stargazersCount.toString())),
                    customHeight(),
                    ItemWithValue(
                        "Fork", getDisplayText(items.forksCount.toString())),
                    customHeight(),
                    ItemWithValue("Watch",
                        getDisplayText(items.watchersCount.toString())),
                    customHeight(),
                    ItemWithValue("Open Issues",
                        getDisplayText(items.openIssuesCount.toString())),
                    customHeight(),
                    ItemWithValue("Owner", getDisplayText(items.owner?.login)),
                    customHeight(),
                    ItemWithValue("Type", getDisplayText(items.owner?.type)),
                    customHeight(),
                    ItemWithValue(
                      "Create At",
                      getDisplayText(
                        items.createdAt?.getFormattedDateFromFormattedString(
                          currentFormat: "yyyy-MM-ddTHH:MM:SSz",
                          desiredFormat: "MMM dd, yyyy hh:mm a",
                          isUtc: true,
                        ),
                      ),
                    ),
                    customHeight(),
                    ItemWithValue(
                      "Update At",
                      getDisplayText(
                        items.updatedAt?.getFormattedDateFromFormattedString(
                          currentFormat: "yyyy-MM-ddTHH:MM:SSz",
                          desiredFormat: "MMM dd, yyyy hh:mm a",
                          isUtc: true,
                        ),
                      ),
                    ),
                    customHeight(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
