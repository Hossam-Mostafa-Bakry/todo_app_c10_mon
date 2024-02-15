import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings_provider.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  List<String> languagesList = [
    "English",
    "عربي",
  ];

  List<String> themesList = [
    "Dark",
    "Light",
  ];

  // state management (provider)

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: mediaQuery.width,
          height: mediaQuery.height * 0.22,
          color: theme.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80),
          child: Text(
            "Settings",
            style: theme.textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Language",
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                items: languagesList,
                initialItem: "English",
                decoration: CustomDropdownDecoration(
                  closedFillColor: vm.isDark()
                      ? const Color(0xFF141922)
                      : Colors.white,
                  closedSuffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: vm.isDark()
                        ? const Color(0xFF141922)
                        : Colors.black,
                  ),
                  expandedFillColor: vm.isDark()
                      ? const Color(0xFF141922)
                      : Colors.white,
                  expandedSuffixIcon: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: vm.isDark()
                        ? const Color(0xFF141922)
                        : Colors.black,
                  ),
                ),
                onChanged: (value) {
                  // if (value == "English") {
                  //   vm.changeLanguage("en");
                  // } else if (value == "عربي") {
                  //   vm.changeLanguage("ar");
                  // }
                },
              ),
              const SizedBox(height: 40),
              Text(
                "Theme",
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                items: themesList,
                initialItem: vm.isDark() ? "Dark" : "Light",
                decoration: CustomDropdownDecoration(

                  closedBorderRadius: BorderRadius.circular(4.0),
                  closedBorder: Border.all(
                    color: theme.primaryColor,
                  ),
                  closedFillColor: vm.isDark()
                      ?const Color(0xFF141922)
                      : Colors.white,
                  closedSuffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: vm.isDark()
                        ? const Color(0xFF141922)
                        : Colors.black,
                  ),
                  expandedFillColor: vm.isDark()
                      ? const Color(0xFF141922)
                      : Colors.white,
                  expandedSuffixIcon: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: vm.isDark()
                        ? const Color(0xFF141922)
                        : Colors.black,
                  ),
                ),
                onChanged: (value) {
                  if (value == "Dark") {
                    vm.changeTheme(ThemeMode.dark);
                  } else if (value == "Light") {
                    vm.changeTheme(ThemeMode.light);
                  }
                },
              ),
            ],
          ),
        ),

      ],
    );
  }
}
