import 'dart:collection';

var list = [4,5,6];
List<int> number = [1,2,3];
List<String> list1 = ["Thai" , "Khai" , "Bang"];

void main(){
  //Cach 1: Duyet tung phan tu roi add tuong ung
  Set<String> set1 = {};  
  list.forEach((i){
    set1.add("$i");
  });
  print(set1.length);
  set1.forEach((i){
    print(i);
    print(i.runtimeType);
  });
  // add all phan tu
  Set<String> set2 = {};
  set2.addAll(list1);

  set2.forEach((i){
    print(i);
  });
  //.from
  Set<dynamic> set3 = Set.from(number);
  set3.forEach((i){
    print(i);
  });

  var q = Queue.from(number);
  q.removeFirst();
  q.forEach((i){
    print(i);
  });
  //.map()


  List<String> strNumber = number.map((number){
    return "$number";
  }).toList();
  strNumber.forEach((i){
    print(i);
    print(i.runtimeType);
  });

  Set<String> str = list1.map((number){
    return number;
  }).toSet();
  str.forEach((i){
    print(i);
  });
}