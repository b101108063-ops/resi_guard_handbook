import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // 匯入首頁

void main() {
  runApp(const ResiGuardApp());
}

class ResiGuardApp extends StatelessWidget {
  const ResiGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResiGuard 住院醫師助手',
      debugShowCheckedModeBanner: false, // 移除右上角 Debug 標籤
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00695C), // 醫療綠
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // 若有中文建議後續設定中文字型
      ),
      home: const HomeScreen(),
    );
  }
}