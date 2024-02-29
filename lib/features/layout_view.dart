import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_mon/features/firebaseUtils.dart';
import 'package:todo_app_c10_mon/features/task_bottom_sheet.dart';
import 'package:todo_app_c10_mon/models/task_model.dart';

import 'settings_provider.dart';

class LayoutView extends StatelessWidget {
  static const String routeName = "layout";

  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => TaskBottomSheet(),
          );

          // var data = TaskModel(
          //   title: "play football",
          //   description: "go to club",
          //   isDone: false,
          //   dateTime: DateTime.now(),
          // );
          //
          // FirebaseUtils().addANewTask(data);
        },
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
      body: vm.screens[vm.currentIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: vm.currentIndex,
          onTap: vm.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
