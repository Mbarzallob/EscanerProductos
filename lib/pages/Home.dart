import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:identificador_productos/pages/escaner/escaner.dart';
import 'package:identificador_productos/pages/product_information.dart';
import 'package:identificador_productos/services/producto.service.dart';

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
            SizedBox(
              width: size.width/1.2,
              child: Text(
                "Identificador de productos",
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: size.width/1.5,
              child: ElevatedButton(
                onPressed: () async {
                  var imagen = await Navigator.push<XFile?>(context, MaterialPageRoute(builder: (context)=>Escaner()));
                  if(imagen == null) return;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductInformation(imagen: imagen)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt, color: Colors.white,size: 50,),
                      Text(
                        "Escanear producto",
                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
