/*
1.Toán tử số học
2.Toán tử so sánh
3.Toán tử kiểm tra kiểu
4.Toán tử gán
5.Toán tử logic
6.Toán tử Bitwase  và Shift 
Toán tử Bitwase và toán tử Shift là những toán tử thực hiện những phép toán trên bit riêng rẻ của kiểu interger
& ; | ; ^ ; ~
<< : Shift left , >> : Shift right
*/

/*
condition ? expr1 : expr2
??
(..) Cascades
 */

//  x = (check == null) ? "Default" : check;
//  x = check ?? "Tin";
//  print(x);
import 'dart:io';
import 'dart:math';

void check({int a = 4 , int b = 5 , int c = 6}){
  print("$a $b $c");
}
void main(){
check();
check(a : 1 , b : 2 , c : 3);
}