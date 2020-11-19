import 'package:flutter/material.dart';

import 'my_page/my_page.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: MyPage.wrapped(),
     theme: ThemeData(
       brightness: Brightness.dark,
       primaryColor: Colors.green
     ),
   );
 }
}