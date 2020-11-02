import 'package:cfhc/controllers/components_ctrl.dart';
import 'package:cfhc/models/components.dart';
import 'package:flutter/cupertino.dart';

class ComponenteProvider with ChangeNotifier {
  List<Components> componentes = List<Components>();
  bool loading = false;

  void listarComponentes(){
    this.loading = true;
    ComponentsCtrl.listarComponentes().then((value){
      this.loading = false;
      if(value!=null){
        this.componentes = value;
      } else{
        this.componentes = List<Components>();
      }
      notifyListeners();
    });
  }
}