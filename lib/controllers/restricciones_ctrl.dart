import 'package:cfhc/models/restriccion.dart';
import 'package:cfhc/services/conf.dart';
import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;

class RestriccionesCtrl{
  static Future<bool> registrarRestricciones(Restriccion rest) async {
    http.Response response = await http.post(
      GlobalVars.apiUrl + "restricciones",
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'id_causante': rest.id_causante,
        'id_restriccion': rest.id_restriccion,
        'tipo': rest.tipo,
        'por': rest.por,
        'de': rest.de
        },
      ),
    ); 
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    } 
  }

  static Future<bool> actualizarRestricciones(int id, String tipo) async {
    http.Response response = await http.put(
      GlobalVars.apiUrl + "restricciones/"+id.toString(),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'tipo': tipo 
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    } 
  }

  static Future<bool> eliminarRestriccion(int id) async {
    http.Response response = await http.delete(
      GlobalVars.apiUrl + "restricciones/"+id.toString()
    ); 
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    } 
  }

  static Future<List<Restriccion>> listarRestricciones() async {
    final response = await http.get(GlobalVars.apiUrl+"restricciones");
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return parsed["data"].map<Restriccion>((json) => Restriccion.fromJson(json)).toList();
    }
    return null;
  }

  static Future<Restriccion> restriccionPorId(String id_component) async {
    final response = await http.get(GlobalVars.apiUrl+"restricciones/"+id_component);
    if (response.statusCode == 200) {
      print(response.body);
      final parsed = json.decode(response.body);
      if(parsed["message"] != null){
        print(parsed["mensaje"]);
        return Restriccion();
      }
      return Restriccion.fromJson(parsed);
    }
    return null;
  }

}