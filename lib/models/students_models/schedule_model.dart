class StudentSchedule {
  final int id;
  final String maLopHocPhan;
  final String tenLopHocPhan;
  final String maSoTayGiangVien;
  final String hoVaTen;
  final int maPhongHoc;
  final String tenPhongHoc;
  final String thuTrongTuan;
  final DateTime ngayHoc;
  final int tietBatDau;
  final int tietKetThuc;
  final int soTiet;
  final int soTietThucDay;
  final int nhom;
  final String? noiDung;
  final String? ghiChu;
  final bool gvDayBu;
  final String gvDangKy;
  final bool tkbChinhThuc;
  final int phanLoaiTKB;
  final bool dayTrucTuyen;
  final bool choPhepDoiHinhThucDay;

  const StudentSchedule({
    required this.id,
    required this.maLopHocPhan,
    required this.tenLopHocPhan,
    required this.maSoTayGiangVien,
    required this.hoVaTen,
    required this.maPhongHoc,
    required this.tenPhongHoc,
    required this.thuTrongTuan,
    required this.ngayHoc,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.soTiet,
    required this.soTietThucDay,
    required this.nhom,
    this.noiDung,
    this.ghiChu,
    required this.gvDayBu,
    required this.gvDangKy,
    required this.tkbChinhThuc,
    required this.phanLoaiTKB,
    required this.dayTrucTuyen,
    required this.choPhepDoiHinhThucDay,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'maLopHocPhan': this.maLopHocPhan,
      'tenLopHocPhan': this.tenLopHocPhan,
      'maSoTayGiangVien': this.maSoTayGiangVien,
      'hoVaTen': this.hoVaTen,
      'maPhongHoc': this.maPhongHoc,
      'tenPhongHoc': this.tenPhongHoc,
      'thuTrongTuan': this.thuTrongTuan,
      'ngayHoc': this.ngayHoc,
      'tietBatDau': this.tietBatDau,
      'tietKetThuc': this.tietKetThuc,
      'soTiet': this.soTiet,
      'soTietThucDay': this.soTietThucDay,
      'nhom': this.nhom,
      'noiDung': this.noiDung,
      'ghiChu': this.ghiChu,
      'gvDayBu': this.gvDayBu,
      'gvDangKy': this.gvDangKy,
      'tkbChinhThuc': this.tkbChinhThuc,
      'phanLoaiTKB': this.phanLoaiTKB,
      'dayTrucTuyen': this.dayTrucTuyen,
      'choPhepDoiHinhThucDay': this.choPhepDoiHinhThucDay,
    };
  }

  factory StudentSchedule.fromMap(Map<String, dynamic> map) {
    return StudentSchedule(
      id: map['id'] as int,
      maLopHocPhan: map['maLopHocPhan'] as String,
      tenLopHocPhan: map['tenLopHocPhan'] as String,
      maSoTayGiangVien: map['maSoTayGiangVien'] as String,
      hoVaTen: map['hoVaTen'] as String,
      maPhongHoc: map['maPhongHoc'] as int,
      tenPhongHoc: map['tenPhongHoc'] as String,
      thuTrongTuan: map['thuTrongTuan'] as String,
      ngayHoc: map['ngayHoc'] as DateTime,
      tietBatDau: map['tietBatDau'] as int,
      tietKetThuc: map['tietKetThuc'] as int,
      soTiet: map['soTiet'] as int,
      soTietThucDay: map['soTietThucDay'] as int,
      nhom: map['nhom'] as int,
      noiDung: map['noiDung'] as String,
      ghiChu: map['ghiChu'] as String,
      gvDayBu: map['gvDayBu'] as bool,
      gvDangKy: map['gvDangKy'] as String,
      tkbChinhThuc: map['tkbChinhThuc'] as bool,
      phanLoaiTKB: map['phanLoaiTKB'] as int,
      dayTrucTuyen: map['dayTrucTuyen'] as bool,
      choPhepDoiHinhThucDay: map['choPhepDoiHinhThucDay'] as bool,
    );
  }
}
