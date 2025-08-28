class StudentProfile {
  final String phanLoai;
  final String maSinhVien;
  final String ho;
  final String ten;
  final String gioiTinh;
  final String ngaySinh;
  final String noiSinh;
  final String diDong;
  final String email;
  final String diaChiCuTru;
  final String diaChiThuongTru;
  final NganhHoc nganhHoc;

  StudentProfile({
    required this.phanLoai,
    required this.maSinhVien,
    required this.ho,
    required this.ten,
    required this.gioiTinh,
    required this.ngaySinh,
    required this.noiSinh,
    required this.diDong,
    required this.email,
    required this.diaChiCuTru,
    required this.diaChiThuongTru,
    required this.nganhHoc,
  });

  factory StudentProfile.fromMap(Map<String, dynamic> map) {
    return StudentProfile(
      phanLoai: map['PhanLoai'] ?? '',
      maSinhVien: map['MaSinhVien'] ?? '',
      ho: map['Ho'] ?? '',
      ten: map['Ten'] ?? '',
      gioiTinh: map['GioiTinh'] ?? '',
      ngaySinh: map['NgaySinh'] ?? '',
      noiSinh: map['NoiSinh'] ?? '',
      diDong: map['DiDong'] ?? '',
      email: map['Email'] ?? '',
      diaChiCuTru: map['DiaChiCuTru'] ?? '',
      diaChiThuongTru: map['DiaChiThuongTru'] ?? '',
      nganhHoc: NganhHoc.fromMap(map['NganhHoc'] ?? {}),
    );
  }
}

class NganhHoc {
  final String maNganh;
  final String tenNganh;
  final String maHocTap;
  final List<QuaTrinhHoc> quaTrinhHoc;

  NganhHoc({
    required this.maNganh,
    required this.tenNganh,
    required this.maHocTap,
    required this.quaTrinhHoc,
  });

  factory NganhHoc.fromMap(Map<String, dynamic> map) {
    return NganhHoc(
      maNganh: map['MaNganh'] ?? '',
      tenNganh: map['TenNganh'] ?? '',
      maHocTap: map['MaHocTap'] ?? '',
      quaTrinhHoc: (map['QuaTrinhHoc'] as List? ?? [])
          .map((e) => QuaTrinhHoc.fromMap(e))
          .toList(),
    );
  }
}

class QuaTrinhHoc {
  final String maHocKy;
  final String maKhoaHoc;
  final String tenKhoaHoc;
  final String maNganh;
  final String tenNganh;

  QuaTrinhHoc({
    required this.maHocKy,
    required this.maKhoaHoc,
    required this.tenKhoaHoc,
    required this.maNganh,
    required this.tenNganh,
  });

  factory QuaTrinhHoc.fromMap(Map<String, dynamic> map) {
    return QuaTrinhHoc(
      maHocKy: map['MaHocKy'] ?? '',
      maKhoaHoc: map['MaKhoaHoc'] ?? '',
      tenKhoaHoc: map['TenKhoaHoc'] ?? '',
      maNganh: map['MaNganh'] ?? '',
      tenNganh: map['TenNganh'] ?? '',
    );
  }
}
