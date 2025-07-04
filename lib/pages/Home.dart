import 'package:flutter/material.dart';
import 'package:identificador_productos/pages/escaner/escaner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text(
          "Pantalla de inicio",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width / 2,
              child: Image.asset("assets/images/carrito.png"),
            ),
            Text(
              "Identificador de productos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>Escaner())),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: Column(
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white,size: 150,),
                    Text(
                      "Escanear producto",
                      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
