import 'dart:io';

class Canbo {
  String? maCanBo;
  String? hoTen;
  String? gioiTinh;

  // Nhập dữ liệu
  void nhapThongTin() {
    print("Nhập mã cán bộ:");
    maCanBo = stdin.readLineSync();
    print("Nhập họ tên:");
    hoTen = stdin.readLineSync();
    print("Nhập giới tính (nam/nữ):");
    gioiTinh = stdin.readLineSync();
  }

  // Hiển thị thông tin
  void hienThiThongTin() {
    print("Mã cán bộ: $maCanBo");
    print("Họ tên: $hoTen");
    print("Giới tính: $gioiTinh");
  }

  // Trả về giá trị các thuộc tính
  String? getMaCanBo() => maCanBo;
  String? getHoTen() => hoTen;
  String? getGioiTinh() => gioiTinh;
}


class Congnhan extends Canbo {
  int? bac; // Bậc từ 1 đến 3
  int? soNgayLamViec;
  DateTime? ngayKyHopDong;

  // Nhập dữ liệu
  @override
  void nhapThongTin() {
    super.nhapThongTin();
    print("Nhập bậc (1-3):");
    bac = int.parse(stdin.readLineSync()!);
    print("Nhập số ngày làm việc:");
    soNgayLamViec = int.parse(stdin.readLineSync()!);
    print("Nhập ngày ký hợp đồng (dd/mm/yyyy):");
    var ngayThangNam = stdin.readLineSync()!.split('/');
    ngayKyHopDong = DateTime(
      int.parse(ngayThangNam[2]), // năm
      int.parse(ngayThangNam[1]), // tháng
      int.parse(ngayThangNam[0]), // ngày
    );
  }

  // Tính lương
  int tinhLuong() {
    int tienCong = 0;
    if (bac == 1) tienCong = 300000;
    if (bac == 2) tienCong = 350000;
    if (bac == 3) tienCong = 400000;
    return (soNgayLamViec ?? 0) * tienCong;
  }

  // Hiển thị thông tin
  @override
  void hienThiThongTin() {
    super.hienThiThongTin();
    print("Bậc: $bac");
    print("Số ngày làm việc: $soNgayLamViec");
    print("Ngày ký hợp đồng: ${ngayKyHopDong?.day}/${ngayKyHopDong?.month}/${ngayKyHopDong?.year}");
    print("Tiền lương: ${tinhLuong()}");
  }

  // Toán tử so sánh `>`
  bool operator >(Congnhan other) {
    return (ngayKyHopDong?.isAfter(other.ngayKyHopDong!) ?? false);
  }
}
void main() {
  List<Congnhan> danhSachCongNhan = [];

  // Nhập danh sách
  print("Nhập số lượng công nhân (n <= 50):");
  int n = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < n; i++) {
    print("Nhập thông tin công nhân thứ ${i + 1}:");
    Congnhan congnhan = Congnhan();
    congnhan.nhapThongTin();
    danhSachCongNhan.add(congnhan);
  }

  // Sắp xếp theo ngày ký hợp đồng tăng dần
  danhSachCongNhan.sort((a, b) => a.ngayKyHopDong!.compareTo(b.ngayKyHopDong!));

  // Hiển thị danh sách sau khi sắp xếp
  print("\nDanh sách công nhân sau khi sắp xếp theo ngày ký hợp đồng:");
  for (var congnhan in danhSachCongNhan) {
    congnhan.hienThiThongTin();
    print("----------------");
  }

  // Tìm công nhân nam có lương cao nhất
  int luongCaoNhat = 0;
  List<Congnhan> congNhanNam = danhSachCongNhan
      .where((cn) => cn.gioiTinh == 'nam' && cn.tinhLuong() > luongCaoNhat)
      .toList();

  if (congNhanNam.isNotEmpty) {
    luongCaoNhat = congNhanNam.map((cn) => cn.tinhLuong()).reduce((a, b) => a > b ? a : b);
    print("\nCông nhân nam có lương cao nhất:");
    for (var cn in congNhanNam.where((cn) => cn.tinhLuong() == luongCaoNhat)) {
      cn.hienThiThongTin();
      print("----------------");
    }
  } else {
    print("\nKhông có công nhân nam nào.");
  }
}
