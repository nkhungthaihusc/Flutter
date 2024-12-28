import 'dart:io';

import 'Convert.dart';

class Canbo{
  String? maCanBo;
  String? hoTen;
  String? gioiTinh;
  void nhapThongTin(){
    print("Nhap ten Can bo(CB0X):");
    maCanBo = stdin.readLineSync()!;
    print("Nhap ho ten Can bo:");
    hoTen = stdin.readLineSync()!;
    print("Nhap gioi tinh (nam/nu):");
    gioiTinh = stdin.readLineSync()!;
  }
  void inThongTin(){
    print("Ma Can bo:$maCanBo");
    print("Ten Can bo:$hoTen");
    print("Gioi Tinh:$gioiTinh");
  }
  String? getMaCanBo() => maCanBo;
  String? getHoTen() => hoTen;
  String? getGioiTinh() => gioiTinh;
}
class Congnhan extends Canbo{
  int? bac;
  int? soNgayLamViec;
  DateTime? ngayKyHopDong;
  
  void nhapThongTin(){
    super.nhapThongTin();
    print("Nhap bac cua Cong nhan(1/2/3):");
    bac = int.parse(stdin.readLineSync()!);
    print("Nhap so ngay lam viec:");
    soNgayLamViec = int.parse(stdin.readLineSync()!);
    print("Nhap ngay ki hop dong(dd/mm/yy):");
    var ngayThangNam = stdin.readLineSync()!.split("/");
    ngayKyHopDong = DateTime(
      int.parse(ngayThangNam[2]),
      int.parse(ngayThangNam[1]),
      int.parse(ngayThangNam[0]),
    );
    }
    int salary(){
      int tienCong = 0;
      if (bac == 1) tienCong = 300000;
      if (bac == 2) tienCong = 350000;
      if (bac == 3) tienCong = 400000;
      return (soNgayLamViec ?? 0) * tienCong;
    }
    @override
    void inThongTin(){
      super.inThongTin();
      print("Bac cua cong nhan:$bac");
      print("So ngay lam viec cua cong nhan:$soNgayLamViec");
      print("Ngay ki hop dong voi cong nhan: ${ngayKyHopDong?.day}/${ngayKyHopDong?.month}/${ngayKyHopDong?.year}");
      print("Tien luong: ${salary()} VND");
    }
    bool operator >(Congnhan other){
      return (ngayKyHopDong?.isAfter(other.ngayKyHopDong!) ?? false);
    }
}


void main(){
List<Congnhan> CN = [];
print("Nhap so luong cong nhan (n <= 50):");
int? n = int.parse(stdin.readLineSync()!);
for (int i = 0 ; i < n ; i++){
  print("Nhap thong tin cong nhan thu ${i + 1}:");
  Congnhan congnhan = Congnhan();
  congnhan.nhapThongTin();
  CN.add(congnhan);
}
for (int i = 0 ; i < n ; i++){
  print("Thong tin cong nhan thu ${i + 1} la:");
  CN[i].inThongTin();
}
CN.sort((a , b) => a.ngayKyHopDong!.compareTo(b.ngayKyHopDong!));
print("Danh sach cong nhan sau khi sap xep:");
for (int i = 0 ; i < n ; i++){
  print("Thong tin cong nhan thu ${i + 1} la:");
  CN[i].inThongTin();
}
int max = -9999;
for (var congnhan in CN){
  if (congnhan.salary() > max){
    max = congnhan.salary();
  }
}
List<Congnhan> DScongNhanNam = [];
for (var congNhanNam in CN){
  if(congNhanNam.salary() == max && congNhanNam.gioiTinh == 'nam'){
    DScongNhanNam.add(congNhanNam);
  }
}
if(DScongNhanNam.isNotEmpty){
  print("Danh sach cong nhan nam co luong cao nhat:");
  for (var congnhan in DScongNhanNam){
    congnhan.inThongTin();
  }
}
else{
  print("Khong co cong nhan nam");
}
}