import 'package:cfhc/controllers/producto_categoria_ctrl.dart';
import 'package:cfhc/models/categoria_alimento.dart';
import 'package:cfhc/models/producto.dart';
import 'package:cfhc/models/producto_categoria.dart';
import 'package:cfhc/partials/dialogs.dart';
import 'package:cfhc/partials/left_nav.dart';
import 'package:cfhc/providers/componentes_provider.dart';
import 'package:cfhc/providers/encuesta_provider.dart';
import 'package:cfhc/providers/producto_categoria_provider.dart';
import 'package:cfhc/providers/producto_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ProductosCategoriaAdmin extends StatefulWidget {
  ProductosCategoriaAdmin() : super();

  @override
  _ProductosCategoriaAdminState createState() => _ProductosCategoriaAdminState();
}

class _ProductosCategoriaAdminState extends State<ProductosCategoriaAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EncuestaProvider encuestaProv;
  
  List<DropdownMenuItem> list = List<DropdownMenuItem>();
  List<DropdownMenuItem> list2 = List<DropdownMenuItem>();
  Map dropDownItemsMap;
  Map dropDownItemsMap2;
  CategoriaAlimento _selectedItem;
  Producto _selectedItem2;
  ComponenteProvider componenteProvider;
  ProductoProvider productoProvider;
  ProductoCategoriaProvider prodCategoriasProv;

  GlobalKey _keyLoader = new GlobalKey();

  List<DropdownMenuItem> getSelectOptions(List<CategoriaAlimento> comp){
    dropDownItemsMap = new Map();
    list.clear();
    comp.forEach((componentes) {
      print(componentes.id);
      int index = componentes.id;
      dropDownItemsMap[index] = componentes;
      list.add(new DropdownMenuItem(
        child: Text(componentes.nombre),
        value: componentes.id)
      );
    });
    return list;
  }

    List<DropdownMenuItem> getSelectOptions2(List<Producto> prod){ 
    dropDownItemsMap2 = new Map();
    list2.clear();
    prod.forEach((productos) {
      print(productos.id);
      int index = productos.id;
      dropDownItemsMap2[index] = productos;
      list2.add(new DropdownMenuItem(
        child: Text(productos.nombre),
        value: productos.id)
      );
    });
    return list2;
  }

  List<TableRow> getRows(List<ProductoCategoria> ingredientes){
    List<TableRow> tableRows = List<TableRow>();
    ingredientes.forEach((e) { 
      tableRows.add(
        TableRow(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[400]),
            ),
          ),
          children: [
            Text(""+e.categoria+" > "+e.producto),
            IconButton(
              icon: Icon(Icons.delete,color: Colors.red[400]),
              onPressed: () { showAlertDialog(context,e.id_categoria, e.id_producto); }
            )
        ]),
      );
    });

    return tableRows;
  }

  @override
  Widget build(BuildContext context) {
    componenteProvider = Provider.of<ComponenteProvider>(context);
    productoProvider = Provider.of<ProductoProvider>(context);
    prodCategoriasProv = Provider.of<ProductoCategoriaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Productos Categoría'),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: LeftNav().getLeftMenu2(context),
      body: SingleChildScrollView(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10), 
              child: Form(
                key: _formKey,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Selector<ProductoProvider, Tuple2<List<Producto>, bool>>(
                          selector: (context, model) => Tuple2(model.productos, model.loading),
                          builder: (context, model, widget) => Column(
                            children: <Widget>[
                              if (!model.item2) ...[
                                if (model.item1.length > 0) ...[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        items: getSelectOptions2(model.item1),
                                        onChanged: (selected) {
                                          _selectedItem2 = dropDownItemsMap2[selected];
                                          setState(() {
                                            _selectedItem2 = dropDownItemsMap2[selected];
                                          });
                                        },
                                        hint: new Text(
                                          _selectedItem2 != null ? _selectedItem2.nombre: "Productos",
                                        ),
                                      ),
                                    )
                                  ),
                                ] else ...[
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'No existen Registros',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24
                                          ),
                                        )
                                      ],
                                    )
                                  )
                                ]
                              ] else ...[
                                Center(
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              ]
                            ]
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 10), 
              child: Form(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Selector<EncuestaProvider, Tuple2<List<CategoriaAlimento>, bool >>(
                          selector: (context, model) => Tuple2(model.categoriasAlimento, model.loadingCategoriasAlimento),
                          builder: (context, models, widget) => Column(
                            children: <Widget>[
                              if (!models.item2) ...[
                                if (models.item1.length > 0) ...[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        items: getSelectOptions(models.item1),
                                        onChanged: (selected) {
                                          _selectedItem = dropDownItemsMap[selected];
                                          setState(() {
                                            _selectedItem = dropDownItemsMap[selected];
                                          });
                                        },
                                        hint: new Text(
                                          _selectedItem != null ? _selectedItem.nombre: "Componentes",
                                        ),
                                      ),
                                    )
                                  ),
                                ] else ...[
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'No existen Registros',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24
                                          ),
                                        )
                                      ],
                                    )
                                  )
                                ]
                              ] else ...[
                                Center(
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              ]
                            ]
                          ),
                        ),
                      ),
                      IconButton(
                      color: Colors.green,
                      iconSize: 38,
                      icon: FaIcon(FontAwesomeIcons.solidSave),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Dialogs.mostrarLoadingDialog(context,_keyLoader, "Registrando");                          
                          prodCategoriasProv.registrar(_selectedItem.id, _selectedItem2.id).then((value) {
                            Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                            if (value) {
                              Dialogs.mostrarDialog(context, "Éxito", "Se registró con éxito la categoria alimento");
                            } else {
                              Dialogs.mostrarDialog(context, "Error", "Error al registrar la categoria alimento");
                            }
                          });
                        }
                      }
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Selector<ProductoCategoriaProvider,Tuple2<List<ProductoCategoria>, bool>>(
                    selector: (context, model) => Tuple2(model.productosCategoria, model.loadingProductosCategorias),
                    builder: (context, model, widget) => Column(
                      children: <Widget>[
                        if (!model.item2) ...[
                          if (model.item1.length > 0) ...[
                            Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              columnWidths: {                  
                                0: FlexColumnWidth(1),
                                1: FixedColumnWidth(40),
                              },
                              children: getRows(model.item1)
                            )
                          ] else ...[
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Lista Vacía',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32
                                    ),
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.listAlt,
                                    size: 60,
                                  )
                                ],
                              )
                            )
                          ]
                        ] else ...[
                          Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ]
                      ]
                    ),
                  ), 
                ]
              ) 
            )
          ],
        )
      )
    );
  }

  showAlertDialog(BuildContext context, int idCat, int idProd) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Eliminar"),
      onPressed:  () {
        Dialogs.mostrarLoadingDialog(context,_keyLoader, "Eliminando");
          prodCategoriasProv.eliminar(idCat, idProd).then((value) {
            prodCategoriasProv.listar();
            Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
            if (value) {
              Navigator.of(context).pop();
              Dialogs.mostrarDialog(context, "Éxito", "Producto Categoria eliminada con éxito");
            }else {
              Navigator.of(context).pop();
              Dialogs.mostrarDialog(context, "Error", "Error al eliminar");
            }
          });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar Producto Categoria"),
      content: Text("¿Estas seguro de eliminar esta Producto Categoria?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}