import 'package:cfhc/controllers/producto_ctrl.dart';
import 'package:cfhc/models/bar.dart';
import 'package:cfhc/models/producto.dart';
import 'package:cfhc/models/producto_bar.dart';
import 'package:cfhc/partials/dialogs.dart';
import 'package:cfhc/providers/bar_provider.dart';
import 'package:cfhc/services/conf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductosBar extends StatefulWidget {
  ProductosBar() : super();

  @override
  _ProductosBarState createState() => _ProductosBarState();
}

class _ProductosBarState extends State<ProductosBar> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    String id_usuario = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos de mi Bar'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
          child: RegisterForm(),
        ),
      ),
    );
  }

}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Bar bar;
  Map dropDownItemsMap;
  Future<List<Producto>> productos;
  Producto _selectedItem;
  List<DropdownMenuItem> list = List<DropdownMenuItem>();
  Future<List<ProductoBar>> productosBar;
  double _precio;

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();  
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    productos = ProductoCtrl.listarProductos();
    bar = Provider.of<BarProvider>(context).getBar();    
    productosBar = ProductoCtrl.listarProductosBar(bar.id.toString());

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.fastfood, size: 36,),
              SizedBox(width: 10),
              Expanded(
                child:   FutureBuilder<List<Producto>>(
                  future: productos,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return new Container();
                    } else if (snapshot.hasData) {
                      list.clear();
                      dropDownItemsMap = new Map();

                      snapshot.data.forEach((producto) {
                        int index = producto.id;
                        dropDownItemsMap[index] = producto;

                        list.add(new DropdownMenuItem(
                          child: Text(producto.nombre),
                          value: producto.id));
                      });

                      return Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: list,
                            onChanged: (selected) {
                              print(selected);
                              print(dropDownItemsMap[selected]);
                              _selectedItem = dropDownItemsMap[selected];
                              setState(() {
                                _selectedItem = dropDownItemsMap[selected];
                              });
                            },
                            hint: new Text(
                              _selectedItem != null ? _selectedItem.nombre: "No Seleccionado",
                            ),
                          )
                        )
                      );
                    } else {
                      return Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ), 
              ),              
            ]
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 160,
                height: 160,
                margin: EdgeInsets.all(10),
                color: Colors.white,
                child: _image == null
                    ? Center(child: Icon(Icons.image, size: 64)) //Center(child: Text('No hay imagen seleccionada'))
                    : AspectRatio(
                      aspectRatio: 1,
                      child: Image.file(_image, fit: BoxFit.cover,)
                    ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RaisedButton.icon(
                            icon: Icon(Icons.add_photo_alternate, size: 40),
                            label: Text('Subir Imagen'),
                            onPressed: getImage
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money),
                              labelText: 'Precio',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'No ha ingresado este campo';
                              }
                            },
                            onSaved: (value){
                              setState(() {
                                _precio = double.parse(value.trim());
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RaisedButton.icon(
                          color: Colors.green,
                          icon: Icon(Icons.add,size: 40,color: Colors.white,),
                          label: Text('Agregar', style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              if(_selectedItem == null) {
                                Dialogs.mostrarDialog(context, "Advertencia", "Debes Seleccionar un producto"); 
                                return;
                              }
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print(_selectedItem.id.toString());
                                print(bar.id.toString());
                                
                                ProductoCtrl.insertProductoBar(bar.id.toString(),_selectedItem.id.toString(),_precio,_image).then((value){
                                  print(value);
                                  if(value == true){
                                    setState(() {
                                      productosBar = ProductoCtrl.listarProductosBar(bar.id.toString());
                                      _showDialog("Producto Agregado Correctamente"); 
                                    });
                                  } else {
                                    _showDialog("Error en el Registro");
                                  }
                                });
                              }
                            }
                          )
                        )
                      ],
                    ),                    
                  ]
                )
              )              
            ]
          ),
          SizedBox(height: 30),
          Center(
            child: SizedBox(
              height: 600.0,
              child: FutureBuilder<List<ProductoBar>>(
                future: productosBar,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return Container();
                  }
                  if (snapshot.hasData) {
                    if(snapshot.data.length == 0){
                      return Text("No existen Productos Registrados");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data);
                        return Card(
                          child: ListTile(
                            leading: Container(
                                width:80,
                                height:80,
                                child: snapshot.data[index].img != null ? 
                                  AspectRatio(aspectRatio: 1, child: Image.network(GlobalVars.serverUrl + snapshot.data[index].img, fit: BoxFit.cover))
                                  : Icon(Icons.fastfood, size:30, color: Colors.orange[400],),
                              ),
                            title: Text(snapshot.data[index].nombre + " ,  \$ " + snapshot.data[index].precio.toString()),
                            trailing: new IconButton(
                              icon: new Icon(Icons.clear,color: Colors.red,),
                              onPressed: () {
                                print(bar.id.toString());
                                ProductoCtrl.deleteProductoBar(bar.id.toString(),snapshot.data[index].id.toString()).then((value){
                                  print(value);
                                  if(value == true){                     
                                    setState(() {
                                      productosBar = ProductoCtrl.listarProductosBar(bar.id.toString());
                                    });
                                    _showDialog("Producto Eliminado Correctamente"); 
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(),
                    ),
                  );                 
                },
              ),
            ),
          ),
        ]
      ),
    );
  }

  void _showDialog(String mssg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Información"),
          content: new Text(mssg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}