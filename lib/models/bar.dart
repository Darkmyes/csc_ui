class Bar{
  int id;
  int id_usuario;
  String nombre;
  String celular;
  String img;

  Bar({this.id, this.id_usuario, this.celular, this.nombre, this.img});

  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar(
      id: json['id'],
      id_usuario: json['id_usuario'],
      nombre: json['nombre'],
      celular: json['celular'],
      img: json['img']
    );
  }
}