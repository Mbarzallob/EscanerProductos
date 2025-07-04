import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:identificador_productos/pages/Home.dart';

late List<CameraDescription> _cameras;
void main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();

    _cameras = await availableCameras();
  }catch(ex){

  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Identificador de productos',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.green,
          onPrimary: Colors.white,
          secondary: Colors.brown,
          onSecondary: Colors.grey,
          error: Colors.red,
          onError: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),

          )
        )
      ),
      home: const HomePage(),
    );
  }
}
