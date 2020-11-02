class ProductoBar {
  int id;
  int id_bar;
  String nombre;
  String img;
  double precio;

  ProductoBar ({this.id, this.id_bar, this.nombre, this.precio, this.img});

  factory ProductoBar .fromJson(Map<String, dynamic> json) {
    return ProductoBar (
      id: json['id_producto'],
      id_bar: json['id_bar'],
      nombre: json['nombre'],
      img: json['img'],
      precio: double.parse(json['precio'].toString())
    );
  }
}