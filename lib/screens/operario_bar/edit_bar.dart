import 'dart:io';

import 'package:cfhc/models/usuario.dart';
import 'package:cfhc/partials/dialogs.dart';
import 'package:cfhc/providers/auth_provider.dart';
import 'package:cfhc/providers/bar_provider.dart';
import 'package:cfhc/services/conf.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/bar.dart';

class EditarBar extends StatefulWidget {
  EditarBar() : super();

  @override
  _RegitroBarState createState() => _RegitroBarState();
}

class _RegitroBarState extends State<EditarBar> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Información Bar'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 8.0),
          child: RegisterForm(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
  bool _agreedToTOS = true;
  Bar _bar = Bar();
  Usuario usuario;
  BarProvider barProv;
  File _image;
  final picker = ImagePicker();

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
    usuario = Provider.of<UsuarioProvider>(context).getUsuario();
    barProv = Provider.of<BarProvider>(context);
    _bar = barProv.getBar();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    padding: EdgeInsets.all(10),
                    child: _bar.img != null ?
                      AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(GlobalVars.serverUrl + _bar.img, fit: BoxFit.cover,),
                      )
                      : Center(child:FaIcon(FontAwesomeIcons.store, size: 64,))
                  ),
                  Text('Imagen Anterior'),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 150,
                    padding: EdgeInsets.all(10),
                    child: _image == null
                      ? Center(child: Icon(Icons.image, size: 64))
                      : AspectRatio(
                      aspectRatio: 1,
                      child: Image.file(_image, fit: BoxFit.cover,),
                    ),
                  ),
                  Text('Imagen Seleccionada'),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
          Center(child: RaisedButton.icon(
            icon: Icon(Icons.add_photo_alternate, size: 40),
            label: Text('Cambiar Imagen'),
            onPressed: getImage
          ),),
          SizedBox(height: 20,),
          TextFormField(
            initialValue: _bar.nombre,
            style: TextStyle(
              fontSize: 20
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.text_fields),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Nombre del Bar',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'No ha ingresado este campo';
              }
            },
            onSaved: (value){
              setState(() {
                _bar.nombre = value;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: _bar.celular,
            style: TextStyle(
              fontSize: 20
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone_android),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: '# Celular',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'No ha ingresado este campo';
              }
              if(value.trim().length != 10 ){
                return 'Ingrese un Número Móvil correcto (sin +593)';
              }
            },
            onSaved: (value){
              setState(() {
                _bar.celular = value.trim();
              });
            },
          ),
          const SizedBox(height: 16.0),               
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: (){
                  if (_formKey.currentState.validate()){
                    _bar.id_usuario = usuario.id_usuario;
                    _formKey.currentState.save();
                    barProv.actualizarBar(_bar,_image).then((value){
                      if(value){
                        barProv.setBar(_bar);
                        Navigator.pushNamedAndRemoveUntil(context, '/mi_bar', (_) => false, arguments: usuario);
                        Dialogs.mostrarDialog(context, "Éxito", "Se actualizaron los datos exitosamente");                        
                      }else{
                        Dialogs.mostrarDialog(context, "Error", "No se pudo Actualizar");
                      }                      
                    });
                  }
                },
                padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
                color: Colors.green,
                child: Text(
                  'Guardar', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),   
            ],
          ),
        ],
      ),
    );
  }

}