import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:identificador_productos/services/producto.service.dart';

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
    _controller = CameraController(firstCamera, ResolutionPreset.medium);

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
      if (imagen == null) {
        return;
      }
      var valida = await showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) {
          return ShowImage(imagen: imagen!);
        },
      );
      if(valida == null || !valida) return;
      Navigator.pop(context, imagen);
      return;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Escáner de productos",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CameraPreview(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
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

class ShowImage extends StatefulWidget {
  ShowImage({super.key, required this.imagen});
  XFile imagen;
  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 40),
                ),
              ],
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(File(widget.imagen.path)),
              ),
            ),
          ),

          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: IconButton(
              color: Colors.black,
              onPressed: () =>
                Navigator.pop(context, true)
              ,
              icon: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
