class ProductoCategoria {
  int id_categoria;
  int id_producto;
  String categoria;
  String producto;

  ProductoCategoria ({this.id_categoria, this.id_producto, this.categoria, this.producto});

  factory ProductoCategoria .fromJson(Map<String, dynamic> json) {
    return ProductoCategoria (
      id_categoria: json['id_categoria'],
      id_producto: json['id_producto'],
      categoria: json['categoria'],
      producto: json['producto']
    );
  }
}