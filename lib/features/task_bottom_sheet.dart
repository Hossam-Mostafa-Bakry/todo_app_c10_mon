import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_mon/core/services/snack_bar_service.dart';
import 'package:todo_app_c10_mon/core/utils/extract_date.dart';
import 'package:todo_app_c10_mon/core/widgets/custom_text_field.dart';
import 'package:todo_app_c10_mon/features/firebaseUtils.dart';
import 'package:todo_app_c10_mon/features/settings_provider.dart';
import 'package:todo_app_c10_mon/models/task_model.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    return Container(
      width: mediaQuery.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          )),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add A New Task",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: vm.isDark() ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: titleController,
              hint: "enter your task title",
              hintColor: Colors.grey.shade600,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "you must enter the task title";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: descController,
              hint: "enter your task description",
              hintColor: Colors.grey.shade600,
              maxLines: 3,
              maxLength: 150,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "you must enter the task description";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Text(
              "Select time",
              textAlign: TextAlign.start,
              style: theme.textTheme.titleMedium?.copyWith(
                color: vm.isDark() ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                vm.selectTaskDate(context);
              },
              child: Text(
                DateFormat.yMMMMd().format(vm.selectedDate),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                    color: vm.isDark() ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var data = TaskModel(
                    title: titleController.text,
                    description: descController.text,
                    isDone: false,
                    dateTime: extractDateTime(vm.selectedDate),
                  );

                  EasyLoading.show();

                  FirebaseUtils().addANewTask(data).then((value) {
                    EasyLoading.dismiss();
                    Navigator.pop(context);
                    SnackBarService.showSuccessMessage(
                        "Task successfully created");
                  }).onError((error, stackTrace) {
                    EasyLoading.dismiss();
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
              child: Text(
                "Add Task",
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
