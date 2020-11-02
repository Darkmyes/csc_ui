import 'package:cfhc/controllers/producto_categoria_ctrl.dart';
import 'package:cfhc/models/producto_categoria.dart';
import 'package:flutter/cupertino.dart';

class ProductoCategoriaProvider with ChangeNotifier {
  List<ProductoCategoria> productosCategoria = List<ProductoCategoria>();
  bool loadingProductosCategorias = false;

  void listar(){
    this.loadingProductosCategorias = true;
    ProductoCategoriaCtrl.listar().then((value){
      this.loadingProductosCategorias = false;
      if(value != null){
        this.productosCategoria = value;
      } else{
        this.productosCategoria = List<ProductoCategoria>();
      }
      notifyListeners();
    });
  }

  Future<bool> registrar(int idCat, int idProd) async {
    bool value = await ProductoCategoriaCtrl.registrar(idCat, idProd);
    if (value) {
      this.listar();
    }
    return value;
  }

  Future<bool> eliminar(int idCat, int idProd) async {
    bool value = await ProductoCategoriaCtrl.eliminar(idCat, idProd);
    if (value) {
      this.listar();
    }
    return value;
  }
}