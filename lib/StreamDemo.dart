import 'dart:async';
/// https://www.dartlang.org/tutorials/language/streams
//class StreamDemo{
   Future<int> sumStream(Stream<int> stream) async{
     var sum = 0;
     //遍历stream的元素
     await for(var value in stream){
       sum+=value;
     }

     return sum;
   }

   ///产生Stream
   Stream<int> countStream(int to) async*{
      for(int i=0;i<=to;i++){
        yield i;
      }
   }

main() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // 55
}

//}