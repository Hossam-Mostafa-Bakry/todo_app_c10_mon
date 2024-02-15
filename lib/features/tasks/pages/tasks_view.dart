import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_mon/features/settings_provider.dart';
import 'package:todo_app_c10_mon/features/tasks/widgets/task_item_widget.dart';

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
                      color: vm.isDark() ? const Color(0xFF141922): Colors.white,

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
                        color: vm.isDark() ? const Color(0xFF141922): Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black38)),
                  ),
                  height: 100,
                ),
                onDateChange: (selectedDate) {
                  setState(() {
                    focusTime = selectedDate;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              TaskItemWidget(),
              TaskItemWidget(),
              TaskItemWidget(),
              TaskItemWidget(),
              TaskItemWidget(),
              TaskItemWidget(),
              TaskItemWidget(),
              TaskItemWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
