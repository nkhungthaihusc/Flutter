import 'package:flutter/material.dart';

class ReportDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String dateTime;
  final bool isProcessed;
  final String description; // nội dung chi tiết

  // Thêm các trường cho phần kết quả xử lý
  final String? resultDepartment;
  final String? resultDate;
  final String? resultContent;
  final List<String>? resultAttachments;

  const ReportDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.dateTime,
    required this.isProcessed,
    required this.description,
    this.resultDepartment,
    this.resultDate,
    this.resultContent,
    this.resultAttachments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết phản ánh"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh phản ánh
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(height: 200, color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 10),

            // Tiêu đề phản ánh
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),

            // Ngày giờ + trạng thái
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateTime, style: const TextStyle(color: Colors.grey)),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isProcessed
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isProcessed ? 'Đã xử lý' : 'Đang xử lý',
                    style: TextStyle(
                      color: isProcessed ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Nội dung phản ánh
            Text(description, style: const TextStyle(fontSize: 15)),
            // Kết quả xử lý
            if (isProcessed) ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4FF), // nền xanh nhạt
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF90CAF9),
                  ), // viền xanh
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề "Kết quả xử lý"
                    const Text(
                      'Kết quả xử lý',
                      style: TextStyle(
                        color: Color(0xFF1976D2), // xanh đậm
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (resultDepartment != null)
                      Text(
                        resultDepartment!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),

                    if (resultDate != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        resultDate!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],

                    if (resultContent != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        resultContent!,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ],

                    if (resultAttachments != null &&
                        resultAttachments!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: resultAttachments!
                              .map(
                                (img) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      img,
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
