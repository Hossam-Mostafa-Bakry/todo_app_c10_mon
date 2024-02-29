import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_mon/core/services/snack_bar_service.dart';
import 'package:todo_app_c10_mon/features/firebaseUtils.dart';
import 'package:todo_app_c10_mon/features/settings_provider.dart';
import 'package:todo_app_c10_mon/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItemWidget({
    super.key,
    required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFE4A49),
        borderRadius: BorderRadius.circular(15.5),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.265,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                EasyLoading.show();
                FirebaseUtils().deleteTask(taskModel).then((value) {
                  EasyLoading.dismiss();
                  SnackBarService.showSuccessMessage(
                      "Task deleted successfully");
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              borderRadius: BorderRadius.circular(15.5),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: 115,
          width: mediaQuery.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: vm.isDark() ? const Color(0xFF141922) : Colors.white,
            borderRadius: BorderRadius.circular(15.5),
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 90,
                decoration: BoxDecoration(
                    color: taskModel.isDone
                        ? const Color(0xFF61E757)
                        : theme.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      taskModel.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: taskModel.isDone
                            ? const Color(0xFF61E757)
                            : theme.primaryColor,
                      ),
                    ),
                    Text(
                      taskModel.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: vm.isDark() ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 18,
                          color: vm.isDark()
                              ? Colors.white
                              : const Color(0xFF141922),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat.yMMMMd().format(taskModel.dateTime),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: vm.isDark()
                                ? Colors.white
                                : const Color(0xFF141922),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (taskModel.isDone)
                Text(
                  "Done !",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF61E757),
                  ),
                ),
              if (!taskModel.isDone)
                InkWell(
                  onTap: () {
                    // EasyLoading.show();
                    var data = TaskModel(
                      id: taskModel.id,
                      title: taskModel.title,
                      description: taskModel.description,
                      isDone: true,
                      dateTime: taskModel.dateTime,
                    );

                    FirebaseUtils().updateTask(data).then((value) {
                      // EasyLoading.dismiss();
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 35,
                        color: Colors.white,
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
