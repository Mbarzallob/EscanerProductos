import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:identificador_productos/models/ProductInfo.dart';
import 'package:identificador_productos/services/producto.service.dart';

class ProductInformation extends StatefulWidget {
  final XFile imagen;
  const ProductInformation({required this.imagen, super.key});

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  ProductInfo? productInformation;
  final FlutterTts _tts = FlutterTts();
  bool _loading = true;
  bool _talking = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    try {
      final info = await ProductService.uploadImage(widget.imagen);
      setState(() {
        productInformation = info;
        _loading = false;
      });
      await _speakDescription(info.descripcion_general);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _speakDescription(String text) async {
    if(_talking) return;
    setState(() {
      _talking = true;
    });
    await _tts.setLanguage("es-ES");
    await _tts.setSpeechRate(1);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    await _tts.awaitSpeakCompletion(true);
    await _tts.speak(text);


    _tts.setCompletionHandler(() {
      setState(() => _talking = false);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de Producto'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!, style: TextStyle(color: Colors.red)))
          : _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_talking) {
            _tts.stop();
            setState(() => _talking = false);
          } else {
            _speakDescription(productInformation!.descripcion_general);
          }
        },
        child: Icon(_talking ? Icons.stop : Icons.volume_up),
      ),
    );
  }

  Widget _buildContent() {
    final info = productInformation!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(File(widget.imagen.path), height: 200,),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info.nombre, style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      Text(info.categora, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 16),
                      Text(info.descripcin, style: Theme.of(context).textTheme.bodyMedium),

                    ],
                  ),
                ),
              )
            ],
          ),

          const Divider(height: 32),
          _buildSection('Presentación', info.presentacin),
          _buildListSection('Componentes Principales', info.componentesPrincipales),
          _buildListSection('Usos Recomendados', info.usosRecomendados),
          _buildListSection('Beneficios', info.beneficios),
          _buildListSection('Instrucciones', info.instrucciones),
          _buildSection('Vida Útil', info.vidaUtil),
          const Divider(height: 32),
          Text('Productos Similares', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          ...info.productosSimilares.map((p) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text('- $p', style: Theme.of(context).textTheme.bodyMedium),
          )),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 4),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text('- $item', style: Theme.of(context).textTheme.bodyMedium),
        )),
        const SizedBox(height: 16),
      ],
    );
  }
}
