import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SubmitReportScreen extends StatefulWidget {
  const SubmitReportScreen({super.key});

  @override
  State<SubmitReportScreen> createState() => _SubmitReportScreenState();
}

class _SubmitReportScreenState extends State<SubmitReportScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<XFile> _mediaFiles = [];
  @override
  void initState() {
    super.initState();
    _controller.clear();
    _mediaFiles.clear();
  }

  void _showSuccessMessage(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 90, // khoảng cách từ đáy màn hình (trên nút cây bút)
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'Gửi thành công!',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Tự động ẩn sau 2 giây
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageOrVideo() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Đổi thành .camera nếu cần
    );

    if (pickedFile != null) {
      setState(() {
        _mediaFiles.add(pickedFile);
      });
    }
  }

  Widget _buildPreview(XFile file) {
    final isVideo =
        file.path.toLowerCase().endsWith('.mp4') ||
        file.path.toLowerCase().endsWith('.mov');

    if (isVideo) {
      return const Icon(Icons.videocam, size: 32, color: Colors.blue);
    } else {
      return Image.file(
        File(file.path),
        fit: BoxFit.cover,
        width: 70,
        height: 70,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Xử lý phản ánh',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              if (_controller.text.trim().isEmpty && _mediaFiles.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nhập kết quả xử lí phản ánh')),
                );
                return;
              }

              // In nội dung ra console (giữ lại nếu cần debug)
              print('Nội dung: ${_controller.text}');
              for (var file in _mediaFiles) {
                print('File: ${file.path}');
              }

              _showSuccessMessage(context); // hiện thông báo
              // Reset sau một chút thời gian rồi quay lại màn hình trước
              Future.delayed(const Duration(milliseconds: 200), () {
                _controller.clear();
                _mediaFiles.clear();
                Navigator.pop(context); // Trở về màn hình trước
              });
            },
          ),
        ],

        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Nhập kết quả xử lí phản ánh',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Đính kèm ảnh và video',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImageOrVideo,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade200, width: 1),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue.shade50,
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Colors.blue, size: 32),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _mediaFiles.asMap().entries.map((entry) {
                final index = entry.key;
                final file = entry.value;

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey.shade200,
                        child: _buildPreview(file),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _mediaFiles.removeAt(index);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
