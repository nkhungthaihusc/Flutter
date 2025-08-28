import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/student_provider.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool showWholeSemester = false;

  @override
  void initState() {
    super.initState();
    context.read<StudentProvider>().getSchedule();
  }
  // Lấy danh sách ngày trong tuần bắt đầu từ thứ 2
  List<DateTime> getCurrentWeekDates() {
    DateTime now = DateTime.now();
    int weekday = now.weekday; // 1 = Thứ 2
    DateTime monday = now.subtract(Duration(days: weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  // Hàm mở dialog chi tiết môn học
  void _showSubjectDetail({
    required String subject,
    required String tiet,
    required String phong,
    required String gv,
    required String buoi,
    required DateTime ngay,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    subject,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 12),
                Text("📅 Ngày: ${ngay.day}/${ngay.month}/${ngay.year}"),
                Text("🕑 Buổi: $buoi"),
                Text("⏰ Tiết: $tiet"),
                Text("🏫 Phòng: $phong"),
                Text("👨‍🏫 Giảng viên: $gv"),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Đóng"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildScheduleTable() {
    final days = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'];
    final sessions = ['Sáng', 'Chiều', 'Tối'];
    final weekDates = getCurrentWeekDates();

    return Table(
      border: TableBorder.all(color: Colors.grey),
      defaultColumnWidth: const FixedColumnWidth(120),
      children: [
        // Hàng tiêu đề
        TableRow(
          children: [
            Container(),
            ...List.generate(days.length, (i) {
              final d = weekDates[i];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(days[i],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text("${d.day}/${d.month}",
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
        // Các buổi học
        ...sessions.map((session) {
          return TableRow(
            children: [
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(8),
                child: Text(session,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              ...List.generate(days.length, (i) {
                final d = weekDates[i];
                // Dữ liệu demo
                final subject = showWholeSemester ? "Môn toàn kỳ" : "Môn tuần";
                final tiet = "1-3";
                final phong = "E401";
                final gv = "Nguyễn Văn A";

                return InkWell(
                  onTap: () {
                    _showSubjectDetail(
                      subject: subject,
                      tiet: tiet,
                      phong: phong,
                      gv: gv,
                      buoi: session,
                      ngay: d,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subject, style: const TextStyle(color: Colors.blue)),
                        Text("Tiết: $tiet",
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Phòng: $phong"),
                        Text("GV: $gv",
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thời khóa biểu'),
        backgroundColor: const Color(0xFF1A68B4),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Tuần hiện tại'),
                  selected: !showWholeSemester,
                  onSelected: (selected) {
                    setState(() => showWholeSemester = false);
                  },
                ),
                const SizedBox(width: 12),
                ChoiceChip(
                  label: const Text('Toàn học kỳ'),
                  selected: showWholeSemester,
                  onSelected: (selected) {
                    setState(() => showWholeSemester = true);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: buildScheduleTable(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
