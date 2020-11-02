import 'package:cfhc/controllers/alergia_ctrl.dart';
import 'package:cfhc/controllers/categoria_alimento_ctrl.dart';
import 'package:cfhc/controllers/enfermedad_ctrl.dart';
import 'package:cfhc/controllers/estilo_vida_ctrl.dart';
import 'package:cfhc/models/alergia.dart';
import 'package:cfhc/models/categoria_alimento.dart';
import 'package:cfhc/models/enfermedad.dart';
import 'package:cfhc/models/estilo_vida.dart';
import 'package:flutter/cupertino.dart';

class EncuestaProvider with ChangeNotifier {
  List<Alergia> alergias = List<Alergia>();
  List<Enfermedad> enfermedades = List<Enfermedad>();
  List<EstiloVida> estilosVida = List<EstiloVida>();
  List<CategoriaAlimento> categoriasAlimento = List<CategoriaAlimento>();
  bool loadingAlergias = false;
  bool loadingEnfermedades = false;
  bool loadingEstilosVida = false;
  bool loadingCategoriasAlimento = false;

  void listarAlergias() {
    this.loadingAlergias = true;
    AlergiaCtrl.ListarAlergias().then((value) {
    this.loadingAlergias = false;
      if(value != null){
        this.alergias = value;
      }else{
        this.alergias = List<Alergia>();
      }
      notifyListeners();
    });
  }

  void listarEnfermedades() async {
    this.loadingEnfermedades = true;
    EnfermedadCtrl.ListarEnfermedades().then((value) {
    this.loadingEnfermedades = false;
      if(value != null){
        this.enfermedades = value;
      }else{
        this.enfermedades = List<Enfermedad>();
      }
      notifyListeners();
    });    
  }

  void listarEstilosVida() async {
    this.loadingEstilosVida = true;
    EstiloVidaCtrl.listarEstilosVida().then((value) {
    this.loadingEstilosVida = false;
      if(value != null){
        this.estilosVida = value;
      }else{
        this.estilosVida = List<EstiloVida>();
      }
      notifyListeners();
    });
  }

  void listarCategoriasAlimento() async {
    this.loadingCategoriasAlimento = true;
    CategoriaAlimentoCtrl.listarCategoriaAlimentos().then((value) {
    this.loadingCategoriasAlimento = false;
      if(value != null){
        this.categoriasAlimento = value;
      }else{
        this.categoriasAlimento = List<CategoriaAlimento>();
      }
      notifyListeners();
    });
  }

}