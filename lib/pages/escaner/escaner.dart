import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Escaner extends StatefulWidget {
  const Escaner({super.key});

  @override
  State<Escaner> createState() => _EscanerState();
}

class _EscanerState extends State<Escaner> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late XFile? imagen;

  @override
  void initState() {
    super.initState();
    inicializarControler();
  }

  inicializarControler() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void tomarFoto() async {
    try {
      final XFile picture = await _controller.takePicture();


      setState(() {
        imagen = picture; // Asignar la imagen tomada
      });

      // Mostrar la imagen en un BottomSheet
      await showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Image.file(File(imagen!.path))),
                    ElevatedButton(onPressed: ()=>Navigator.pop(context), child: Text("Aceptar", style: TextStyle(color: Colors.white),))
                  ],
                ),
              ),
            ],
          );
        },
      );


    } catch (e) {
      print("Error tomando foto: $e");
    }


  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Escáner de cámara"),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // Si el controlador se ha inicializado, mostrar la vista previa de la cámara
                      return Expanded(child: CameraPreview(_controller));
                    } else {
                      // Mientras se inicializa, mostrar un indicador de carga
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  onPressed: () => tomarFoto(),
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.camera),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
