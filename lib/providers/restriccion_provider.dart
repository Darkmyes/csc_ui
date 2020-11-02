import 'package:cfhc/controllers/restricciones_ctrl.dart';
import 'package:cfhc/models/restriccion.dart';
import 'package:flutter/cupertino.dart';

class RestriccionProvider with ChangeNotifier {
  List<Restriccion> restricciones = List<Restriccion>();
  bool loading = false;

  void listarRestricciones() async {
    this.loading = true;
    RestriccionesCtrl.listarRestricciones().then((value) {
      this.loading = false;
      if(value != null){
        this.restricciones = value;
      }else{
        this.restricciones = List<Restriccion>();
      }
      notifyListeners();
    });
  }

  Future<bool> registrarRestriccion(Restriccion rest) async {
    bool value = await RestriccionesCtrl.registrarRestricciones(rest);
    if (value) {
      this.listarRestricciones();
    }
    return value;
  }

  Future<bool> actualizarRestricciones(int id, String tipo) async {
    bool value = await RestriccionesCtrl.actualizarRestricciones(id, tipo);
    if (value) {
      this.listarRestricciones();
    }
    return value;
  }

  Future<bool> eliminarRestricciones(int id) async {
    bool value = await RestriccionesCtrl.eliminarRestriccion(id);
    if (value) {
      this.listarRestricciones();
    }
    return value;
  }

}