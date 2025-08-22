import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/schedule_model.dart';
import 'package:flutter_application_1/services/schedule_service.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int currentWeek = 1;
  bool showWholeSemester = false;
  Map<int, Map<String, Map<String, Lesson?>>> weeklySchedules = {};
  DateTime semesterStartDate = DateTime(2025, 7, 1);

  @override
  void initState() {
    super.initState();
    currentWeek = calculateCurrentWeek(semesterStartDate);
    loadSchedule();
  }

  int calculateCurrentWeek(DateTime startDate) {
    final today = DateTime.now();
    return ((today.difference(startDate).inDays) ~/ 7) + 1;
  }

  Future<void> loadSchedule() async {
    try {
      if (showWholeSemester) {
        final data = await ScheduleService.fetchWholeSemesterSchedule();
        setState(() => weeklySchedules = data);
      } else {
        final data = await ScheduleService.fetchCurrentWeekSchedule(currentWeek);
        setState(() => weeklySchedules[currentWeek] = data);
      }
    } catch (e) {
      print('Error loading schedule: $e');
    }
  }

  DateTime getWeekStartDate(int week) => semesterStartDate.add(Duration(days: (week - 1) * 7));
  DateTime getWeekEndDate(int week) => getWeekStartDate(week).add(Duration(days: 6));

  Widget buildScheduleTable(Map<String, Map<String, Lesson?>> schedule) {
    final days = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'];
    final sessions = ['Sáng', 'Chiều', 'Tối'];

    return Table(
      border: TableBorder.all(color: Colors.grey),
      defaultColumnWidth: FixedColumnWidth(120),
      children: [
        TableRow(
          children: [
            Container(),
            ...days.map((d) => Center(child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(d, style: TextStyle(fontWeight: FontWeight.bold)),
            ))),
          ],
        ),
        ...sessions.map((session) {
          return TableRow(
            children: [
              Container(
                color: Colors.grey[300],
                padding: EdgeInsets.all(8),
                child: Text(session, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ...days.map((day) {
                final lesson = schedule[session]?[day];
                if (lesson == null) return SizedBox(height: 70);
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lesson.subject, style: TextStyle(color: Colors.blue)),
                      Text('Tiết: ${lesson.time}', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Phòng: ${lesson.room}'),
                      Text('GV: ${lesson.teacher}', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thời khóa biểu'),
        backgroundColor: Color(0xFF1A68B4),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Tuần hiện tại'),
                  selected: !showWholeSemester,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        showWholeSemester = false;
                      });
                      loadSchedule();
                    }
                  },
                ),
                SizedBox(width: 12),
                ChoiceChip(
                  label: Text('Toàn học kỳ'),
                  selected: showWholeSemester,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        showWholeSemester = true;
                      });
                      loadSchedule();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: showWholeSemester
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: weeklySchedules.entries.map((entry) {
                          final week = entry.key;
                          final schedule = entry.value;
                          final startDate = getWeekStartDate(week);
                          final endDate = getWeekEndDate(week);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tuần $week', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Text(
                                'Từ ${startDate.day}/${startDate.month} đến ${endDate.day}/${endDate.month}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              SizedBox(height: 8),
                              buildScheduleTable(schedule),
                              SizedBox(height: 20),
                            ],
                          );
                        }).toList(),
                      )
                    : buildScheduleTable(weeklySchedules[currentWeek] ?? {}),
              ),
            ),
         
          ),
        ],
      ),
    );
  }
}
