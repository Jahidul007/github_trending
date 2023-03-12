import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:github_trending/app/module/home_screen/controller/home_controller.dart';
import 'package:github_trending/app/module/home_screen/data/enum/menu_item_type.dart';
import 'package:github_trending/app/module/widget/custom_divider.dart';
import 'package:github_trending/app/module/widget/custom_height_width.dart';
import 'package:github_trending/app/utils/show_toast.dart';

List<String> countryList = [
  'Afghanistan',
  'Albania',
  'Algeria',
  'American Samoa',
  'Andorra',
  'Angola',
  'Anguilla',
  'Antarctica',
  'Antigua & Barbuda',
  'Argentina',
  'Armenia',
  'Aruba',
  'Australia',
  'Austria',
  'Azerbaijan',
  'Bahamas',
  'Bahrain',
  'Bangladesh',
  'India',
  'Pakistan',
  'Nepal'
];

showMenuDialog(BuildContext context, HomeController homeController) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Filter'),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.cancel_outlined),
            )
          ],
        ),
        actions: [
          StreamBuilder<MenuItemType>(
            stream: homeController.menuItemStream,
            builder: (context, snapshot) {
              MenuItemType menuItemType = MenuItemType.topRepositories;
              if (snapshot.hasData) {
                menuItemType = snapshot.data!;
              }
              return Column(
                children: [
                  DropdownSearch<MenuItemType>(
                    enabled: true,
                    items: MenuItemType.values,
                    selectedItem: menuItemType,
                    itemAsString: (item) => getMenuItemAsString(item),
                    onChanged: (value) {
                      homeController.updateMenuItem(value!);
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        label: Text('Search By'),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  if (menuItemType == MenuItemType.topUserByCountry)
                    customHeight(height: 10),
                  if (menuItemType == MenuItemType.topUserByCountry)
                    StreamBuilder<String?>(
                      stream: homeController.selectedCountryStream,
                      builder: (context, snapshot) {
                        String? selectedCountry;
                        if (snapshot.hasData) {
                          selectedCountry = snapshot.data!;
                        }
                        return DropdownSearch<String?>(
                          popupProps: const PopupProps.dialog(showSearchBox: true),
                          enabled: true,
                          items: countryList,
                          selectedItem: homeController.selectedCountryName,
                          itemAsString: (item) => item.toString(),
                          onChanged: (value) {
                            homeController.updateCountry(value!);
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              label: Text('Country'),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        );
                      },
                    ),
                  customDividerGrey(),
                  TextButton(
                    onPressed: () {
                      if (menuItemType == MenuItemType.topRepositories) {
                        Navigator.of(context).pop();
                        homeController.getTopRepositories();
                      } else if (menuItemType ==
                          MenuItemType.topUserByCountry) {
                        if (homeController.checkCountryInput()) {
                          Navigator.of(context).pop();
                          homeController.getTopUsers();
                        } else {
                          showToast("Please select a Country");
                        }
                      }
                    },
                    child: const Text('Search'),
                  )
                ],
              );
            },
          ),
        ],
      );
    },
  );
}
