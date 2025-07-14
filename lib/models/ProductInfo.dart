class ProductInfo {
  String nombre;
  String categora;
  String descripcin;
  String presentacin;
  List<String> componentesPrincipales;
  List<String> usosRecomendados;
  List<String> beneficios;
  List<String> instrucciones;
  String vidaUtil;
  String descripcion_general;
  List<String> productosSimilares;

  ProductInfo({
    required this.nombre,
    required this.categora,
    required this.descripcin,
    required this.presentacin,
    required this.componentesPrincipales,
    required this.usosRecomendados,
    required this.beneficios,
    required this.instrucciones,
    required this.vidaUtil,
    required this.productosSimilares,
    required this.descripcion_general
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
    nombre: json["nombre"],
    categora: json["categoría"],
    descripcin: json["descripción"],
    presentacin: json["presentación"],
    componentesPrincipales: List<String>.from(json["componentes_principales"].map((x) => x)),
    usosRecomendados: List<String>.from(json["usos_recomendados"].map((x) => x)),
    beneficios: List<String>.from(json["beneficios"].map((x) => x)),
    instrucciones: List<String>.from(json["instrucciones"].map((x) => x)),
    vidaUtil: json["vida_util"],
    productosSimilares: List<String>.from(json["productos_similares"].map((x) => x)),
    descripcion_general: json["descripcion_general"]
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "categoría": categora,
    "descripción": descripcin,
    "presentación": presentacin,
    "componentes_principales": List<dynamic>.from(componentesPrincipales.map((x) => x)),
    "usos_recomendados": List<dynamic>.from(usosRecomendados.map((x) => x)),
    "beneficios": List<dynamic>.from(beneficios.map((x) => x)),
    "instrucciones": List<dynamic>.from(instrucciones.map((x) => x)),
    "vida_util": vidaUtil,
    "productos_similares": List<dynamic>.from(productosSimilares.map((x) => x)),
  };
}
