import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_mon/core/utils/extract_date.dart';
import 'package:todo_app_c10_mon/features/firebaseUtils.dart';
import 'package:todo_app_c10_mon/features/settings_provider.dart';
import 'package:todo_app_c10_mon/features/tasks/widgets/task_item_widget.dart';
import 'package:todo_app_c10_mon/models/task_model.dart';

class TaskView extends StatefulWidget {
  TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  DateTime focusTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 55.0),
          child: Stack(
            alignment: const Alignment(0, 2.0),
            clipBehavior: Clip.none,
            children: [
              Container(
                width: mediaQuery.width,
                height: mediaQuery.height * 0.22,
                color: theme.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80),
                child: Text(
                  "TODO List",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              EasyInfiniteDateTimeLine(
                firstDate: DateTime(2023),
                focusDate: focusTime,
                lastDate: DateTime(2025),
                showTimelineHeader: false,
                timeLineProps: const EasyTimeLineProps(separatorPadding: 20),
                dayProps: EasyDayProps(
                  inactiveDayStyle: DayStyle(
                    dayNumStyle: theme.textTheme.bodySmall,
                    dayStrStyle: theme.textTheme.bodySmall,
                    monthStrStyle: theme.textTheme.bodySmall,
                    decoration: BoxDecoration(
                      color:
                          vm.isDark() ? const Color(0xFF141922) : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  activeDayStyle: DayStyle(
                    dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                    ),
                    dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                    ),
                    monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                    ),
                    decoration: BoxDecoration(
                        color: vm.isDark()
                            ? const Color(0xFF141922)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black38)),
                  ),
                  height: 100,
                ),
                onDateChange: (selectedDate) {
                  setState(() {
                    focusTime = selectedDate;
                    vm.selectedDate = focusTime;
                  });
                },
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseUtils().getStreamDataFromFireStore(vm.selectedDate,),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Column(
                children: [
                  Text(
                    "Something went wrong",
                  ),
                  Icon(Icons.refresh),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var tasksList = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) =>
                    TaskItemWidget(taskModel: tasksList[index]),
                itemCount: tasksList.length,
              ),
            );
          },
        ),


        // FutureBuilder<List<TaskModel>>(
        //   future: FirebaseUtils().getDataFromFireStore(vm.selectedDate,),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return const Column(
        //         children: [
        //           Text(
        //             "Something went wrong",
        //           ),
        //           Icon(Icons.refresh),
        //         ],
        //       );
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //
        //     var tasksList = snapshot.data ?? [];
        //
        //     return Expanded(
        //       child: ListView.builder(
        //         padding: EdgeInsets.zero,
        //         itemBuilder: (context, index) =>
        //             TaskItemWidget(taskModel: tasksList[index]),
        //         itemCount: tasksList.length,
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
