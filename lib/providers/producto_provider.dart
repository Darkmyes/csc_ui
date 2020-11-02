import 'package:cfhc/controllers/producto_ctrl.dart';
import 'package:cfhc/models/producto.dart';
import 'package:flutter/cupertino.dart';

class ProductoProvider with ChangeNotifier {
  List<Producto> productos = List<Producto>();
  bool loading = false;

  void listarProductos(){
    this.loading = true;
    ProductoCtrl.listarProductos().then((value){
      this.loading = false;
      if(value!=null){
        this.productos = value;
      } else{
        this.productos = List<Producto>();
      }
      notifyListeners();
    });
  }
}