import 'package:flutter/material.dart';
import 'gv_submit_report_screen.dart';
import 'gv_report_detail_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isProcessed = true;
  bool showPersonal = false;

  final String currentUserId = 'user_123'; // Giả định người dùng đang đăng nhập

  // Dữ liệu mẫu
  final List<Map<String, dynamic>> reports = [
    {
      'image': 'https://via.placeholder.com/400x200.png?text=Ảnh+1',
      'title': 'Vòi nước bị rò rỉ ở nhà vệ sinh tầng 2 dãy E',
      'dateTime': '22/2/2025 09:27',
      'status': true,
      'userId': 'user_123',
      'description':
          'Tôi xin phản ánh tình trạng vòi nước tại nhà vệ sinh tầng 2, dãy E đang bị rò rỉ...',
      'resultDepartment': 'Phòng Cơ sở vật chất',
      'resultDate': '27/2/2025 09:00',
      'resultContent':
          'Phòng Cơ sở vật chất xin thông báo: Sau khi tiếp nhận phản ánh về tình trạng vòi nước bị rò rỉ tại nhà vệ sinh tầng 2, dãy E, bộ phận kỹ thuật đã tiến hành kiểm tra và xử lý xong sự cố. Vòi nước đã được thay thế/sửa chữa (tùy theo thực tế), đảm bảo hoạt động bình thường. Sự cố đã được khắc phục, cửa sổ đã được thay mới và đảm bảo an toàn.',
      'resultAttachments': [
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
      ],
    },
    {
      'image': 'https://via.placeholder.com/400x200.png?text=Ảnh+2',
      'title': 'Đèn hành lang bị hỏng ở tầng 3 dãy B',
      'dateTime': '21/2/2025 20:45',
      'status': false,
      'userId': 'user_456',
      'description':
          'Tôi xin phản ánh tình trạng vòi nước tại nhà vệ sinh tầng 2, dãy E đang bị rò rỉ...',
      'resultDepartment': 'Phòng Cơ sở vật chất',
      'resultDate': '21/2/2025 09:00',
      'resultContent':
          'Sự cố đã được khắc phục, cửa sổ đã được thay mới và đảm bảo an toàn.',
      'resultAttachments': [
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
      ],
    },
    {
      'image': 'https://via.placeholder.com/400x200.png?text=Ảnh+3',
      'title': 'Cửa sổ bị vỡ ở lớp học A104',
      'dateTime': '20/2/2025 14:10',
      'status': true,
      'userId': 'user_123',
      'description':
          'Tôi xin phản ánh tình trạng vòi nước tại nhà vệ sinh tầng 2, dãy E đang bị rò rỉ...',
      'resultDepartment': 'Phòng Cơ sở vật chất',
      'resultDate': '21/2/2025 09:00',
      'resultContent':
          'Sự cố đã được khắc phục, cửa sổ đã được thay mới và đảm bảo an toàn.',
      'resultAttachments': [
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
      ],
    },
    {
      'image': 'https://via.placeholder.com/400x200.png?text=Ảnh+7',
      'title': 'Sân bóng bị đọng nước sau mưa',
      'dateTime': '18/2/2025 15:00',
      'status': true,
      'userId': 'user_456',
      'description':
          'Tôi xin phản ánh tình trạng vòi nước tại nhà vệ sinh tầng 2, dãy E đang bị rò rỉ...',
      'resultDepartment': 'Phòng Cơ sở vật chất',
      'resultDate': '21/2/2025 09:00',
      'resultContent':
          'Sự cố đã được khắc phục, cửa sổ đã được thay mới và đảm bảo an toàn.',
      'resultAttachments': [
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
      ],
    },
    {
      'image': 'https://via.placeholder.com/400x200.png?text=Ảnh+8',
      'title': 'Wifi chập chờn tại phòng máy 1',
      'dateTime': '17/2/2025 13:33',
      'status': false,
      'userId': 'user_456',
      'description':
          'Tôi xin phản ánh tình trạng vòi nước tại nhà vệ sinh tầng 2, dãy E đang bị rò rỉ...',
      'resultDepartment': 'Phòng Cơ sở vật chất',
      'resultDate': '21/2/2025 09:00',
      'resultContent':
          'Sự cố đã được khắc phục, cửa sổ đã được thay mới và đảm bảo an toàn.',
      'resultAttachments': [
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
      ],
    },
    {
      'image': 'https://via.placeholder.com/400x200.png?text=Ảnh+9',
      'title': 'Sân trường có vết nứt nguy hiểm',
      'dateTime': '17/2/2025 09:10',
      'status': true,
      'userId': 'user_123',
      'description':
          'Tôi xin phản ánh tình trạng vòi nước tại nhà vệ sinh tầng 2, dãy E đang bị rò rỉ...',
      'resultDepartment': 'Phòng Cơ sở vật chất',
      'resultDate': '21/2/2025 09:00',
      'resultContent':
          'Sự cố đã được khắc phục, cửa sổ đã được thay mới và đảm bảo an toàn.',
      'resultAttachments': [
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
      ],
    },
    {
      'image': 'https://via.placeholder.com/400x200.png?text=Ảnh+4',
      'title': 'Rác chưa được dọn ở khuôn viên sau trường',
      'dateTime': '20/2/2025 08:55',
      'status': false,
      'userId': 'user_456',
      'description':
          'Tôi xin phản ánh tình trạng vòi nước tại nhà vệ sinh tầng 2, dãy E đang bị rò rỉ...',
      'resultDepartment': 'Phòng Cơ sở vật chất',
      'resultDate': '21/2/2025 09:00',
      'resultContent':
          'Sự cố đã được khắc phục, cửa sổ đã được thay mới và đảm bảo an toàn.',
      'resultAttachments': [
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
      ],
    },
    {
      'image': 'https://via.placeholder.com/400x200.png?text=Ảnh+5',
      'title': 'Bàn học bị gãy ở phòng B203',
      'dateTime': '19/2/2025 17:40',
      'status': true,
      'userId': 'user_123',
      'description':
          'Tôi xin phản ánh tình trạng vòi nước tại nhà vệ sinh tầng 2, dãy E đang bị rò rỉ...',
      'resultDepartment': 'Phòng Cơ sở vật chất',
      'resultDate': '21/2/2025 09:00',
      'resultContent':
          'Sự cố đã được khắc phục, cửa sổ đã được thay mới và đảm bảo an toàn.',
      'resultAttachments': [
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
        'https://placehold.co/600x400.png',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filteredReports = reports.where((r) {
      final matchStatus = r['status'] == isProcessed;
      final matchUser = !showPersonal || r['userId'] == currentUserId;
      return matchStatus && matchUser;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Phản ánh hiện trường',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilterButton(
                label: 'Đã xử lý',
                selected: isProcessed,
                onTap: () {
                  setState(() {
                    isProcessed = true;
                  });
                },
              ),
              const SizedBox(width: 12),
              FilterButton(
                label: 'Đang xử lý',
                selected: !isProcessed,
                onTap: () {
                  setState(() {
                    isProcessed = false;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filteredReports.isEmpty
                ? const Center(
                    child: Text(
                      'Không có phản ánh nào',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.only(bottom: 80),
                    children: filteredReports
                        .map(
                          (r) => ReportCard(
                            imageUrl: r['image'],
                            title: r['title'],
                            dateTime: r['dateTime'],
                            isProcessed: r['status'],
                            description: r['description'],
                            resultDepartment: r['resultDepartment'],
                            resultDate: r['resultDate'],
                            resultContent: r['resultContent'],
                            resultAttachments: List<String>.from(
                              r['resultAttachments'] ?? [],
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: Colors.blue.shade100,
      labelStyle: TextStyle(
        color: selected ? Colors.blue : Colors.black,
        fontWeight: FontWeight.w600,
      ),
      shape: StadiumBorder(side: BorderSide(color: Colors.blue.shade200)),
      backgroundColor: Colors.white,
      onSelected: (_) => onTap(),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String dateTime;
  final bool isProcessed;
  final String description;
  final String resultDepartment;
  final String resultDate;
  final String resultContent;
  final List<String> resultAttachments;

  const ReportCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.dateTime,
    required this.isProcessed,
    required this.description,
    required this.resultDepartment,
    required this.resultDate,
    required this.resultContent,
    required this.resultAttachments,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReportDetailScreen(
              imageUrl: imageUrl,
              title: title,
              dateTime: dateTime,
              isProcessed: isProcessed,
              description: description,
              resultDepartment: resultDepartment,
              resultDate: resultDate,
              resultContent: resultContent,
              resultAttachments: resultAttachments,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(height: 120, color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateTime),
                Text(
                  isProcessed ? 'Đã xử lý' : 'Đang xử lý',
                  style: TextStyle(
                    color: isProcessed ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
