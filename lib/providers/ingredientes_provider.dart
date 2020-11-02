import 'package:cfhc/controllers/ingredientes_ctrl.dart';
import 'package:cfhc/models/ingredientes.dart';
import 'package:flutter/cupertino.dart';

class IngredientesProvider with ChangeNotifier {
  List<Ingredientes> ingredientes = List<Ingredientes>();
  bool loading = false;

  void listarIngredientes(){
    this.loading = true;
    IngredientesCtrl.listarIngredientes().then((value){
      this.loading = false;
      if(value!=null){
        this.ingredientes = value;
      } else{
        this.ingredientes = List<Ingredientes>();
      }
      notifyListeners();
    });
  }
}