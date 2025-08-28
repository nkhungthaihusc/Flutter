import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool showWholeSemester = false; // state để chuyển qua lại

  Widget buildScheduleTable() {
    final days = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'];
    final sessions = ['Sáng', 'Chiều', 'Tối'];

    return Table(
      border: TableBorder.all(color: Colors.grey),
      defaultColumnWidth: const FixedColumnWidth(120),
      children: [
        TableRow(
          children: [
            Container(),
            ...days.map(
                  (d) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    d,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        ...sessions.map((session) {
          return TableRow(
            children: [
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(8),
                child: Text(
                  session,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...days.map((day) {
                // Dữ liệu demo
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(showWholeSemester ? "Môn toàn kỳ" : "Môn tuần hiện tại",
                          style: const TextStyle(color: Colors.blue)),
                      const Text("Tiết: 1-3", style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text("Phòng: E401"),
                      const Text("GV: Nguyễn Văn A",
                          style: TextStyle(fontWeight: FontWeight.bold)),
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
                    setState(() {
                      showWholeSemester = false;
                    });
                  },
                ),
                const SizedBox(width: 12),
                ChoiceChip(
                  label: const Text('Toàn học kỳ'),
                  selected: showWholeSemester,
                  onSelected: (selected) {
                    setState(() {
                      showWholeSemester = true;
                    });
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
