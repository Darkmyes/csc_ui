import 'package:cfhc/models/producto_categoria.dart';
import 'package:cfhc/services/conf.dart';
import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;

class ProductoCategoriaCtrl{
  static Future<bool> registrar(int idCat, int idProd) async {
    http.Response response = await http.post(
      GlobalVars.apiUrl + "productos_categoria",
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'id_categoria': idCat.toString(),
        'id_producto': idProd.toString()
        },
      ),
    ); 
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    } 
  }

  static Future<bool> eliminar(int idCat, int idProd) async {
    print(idCat);
    print(idProd);
    http.Response response = await http.delete(
      GlobalVars.apiUrl + "productos_categoria/categoria/"+idCat.toString()+"/producto/"+idProd.toString()
    ); 
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    } 
  }

  static Future<List<ProductoCategoria>> listar() async {
    final response = await http.get(GlobalVars.apiUrl+"productos_categoria");
    if (response.statusCode == 200) {
      print(response.body);
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return parsed["data"].map<ProductoCategoria>((json) => ProductoCategoria.fromJson(json)).toList();
    }
    return null;
  }

  static Future<ProductoCategoria> porId(int idCat, int idProd) async {
    final response = await http.get(GlobalVars.apiUrl+"productos_categoria/categoria/"+idCat.toString()+"/producto/"+idProd.toString());
    if (response.statusCode == 200) {
      print(response.body);
      final parsed = json.decode(response.body);
      if(parsed["message"] != null){
        print(parsed["mensaje"]);
        return ProductoCategoria();
      }
      return ProductoCategoria.fromJson(parsed);
    }
    return null;
  }

  static Future<ProductoCategoria> porProducto(int idProd) async {
    final response = await http.get(GlobalVars.apiUrl+"productos_categoria/producto/"+idProd.toString());
    if (response.statusCode == 200) {
      print(response.body);
      final parsed = json.decode(response.body);
      if(parsed["message"] != null){
        print(parsed["mensaje"]);
        return ProductoCategoria();
      }
      return ProductoCategoria.fromJson(parsed);
    }
    return null;
  }

  static Future<ProductoCategoria> porCategoria(int idCat, int idProd) async {
    final response = await http.get(GlobalVars.apiUrl+"productos_categoria/categoria/"+idCat.toString());
    if (response.statusCode == 200) {
      print(response.body);
      final parsed = json.decode(response.body);
      if(parsed["message"] != null){
        print(parsed["mensaje"]);
        return ProductoCategoria();
      }
      return ProductoCategoria.fromJson(parsed);
    }
    return null;
  }                                            

}