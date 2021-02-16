import 'package:cfhc/models/usuario.dart';
import 'package:cfhc/providers/auth_provider.dart';
import 'package:cfhc/providers/componentes_provider.dart';
import 'package:cfhc/providers/encuesta_provider.dart';
import 'package:cfhc/providers/ingredientes_provider.dart';
import 'package:cfhc/providers/producto_categoria_provider.dart';
import 'package:cfhc/providers/producto_provider.dart';
import 'package:cfhc/providers/restriccion_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LeftNav {
  static LeftNav _instance;

  factory LeftNav() => _instance ??= new LeftNav._();

  LeftNav._();

  Widget getLeftMenu2(BuildContext context /* , Usuario usuario */) {
    UsuarioProvider authProv = Provider.of<UsuarioProvider>(context);
    EncuestaProvider encuestaProv = Provider.of<EncuestaProvider>(context);
    ComponenteProvider componentProv = Provider.of<ComponenteProvider>(context);
    ProductoProvider productoProv = Provider.of<ProductoProvider>(context);
    IngredientesProvider ingredientesProv =
        Provider.of<IngredientesProvider>(context);
    RestriccionProvider restriccionesProv =
        Provider.of<RestriccionProvider>(context);
    ProductoCategoriaProvider categoriasProdProv =
        Provider.of<ProductoCategoriaProvider>(context);
    Usuario usuario = authProv.getUsuario();

    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            usuario != null ? usuario.nombre : "Usuario",
            style: TextStyle(fontSize: 20),
          ),
          accountEmail:
              Text(usuario != null ? usuario.correo : "usuario@correo.com"),
          /* currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(usuario!=null?'${usuario.nombre[0]}':"U",style: TextStyle(fontSize: 40.0) )
            ) */
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.store),
          title: Text('Lista Locales'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/lista_bares');
            /* Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/lista_bares",
                (route) => route.isCurrent && route.settings.name == "/lista_bares"
                  ? false
                  : true,
                ); */
          },
        ),
        /* 
          ListTile(
            leading: FaIcon(FontAwesomeIcons.store),
            title: Text('Lista Recomendados'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/lista_bares');
            },
          ), */
        if (usuario != null && usuario.tipo == "Administrador") ...[
          SizedBox(
            height: 5,
            child: CustomPaint(painter: Drawhorizontalline()),
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Admin Productos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/registro_producto');
            },
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Admin Productos Categoría'),
            onTap: () {
              encuestaProv.listarCategoriasAlimento();
              productoProv.listarProductos();
              categoriasProdProv.listar();
              Navigator.of(context)
                  .pushReplacementNamed('/productos_categoria');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.allergies),
            title: Text('Admin Alergias'),
            onTap: () {
              encuestaProv.listarAlergias();
              Navigator.of(context).pushReplacementNamed('/alergias_admin');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.headSideMask),
            title: Text('Admin Enfermedades'),
            onTap: () {
              encuestaProv.listarEnfermedades();
              Navigator.of(context).pushReplacementNamed('/enfermedades_admin');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.peace),
            title: Text('Admin Estilos de Vida'),
            onTap: () {
              encuestaProv.listarEnfermedades();
              Navigator.of(context).pushReplacementNamed('/estilos_admin');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.appleAlt),
            title: Text('Admin Categorias Alimento'),
            onTap: () {
              encuestaProv.listarCategoriasAlimento();
              Navigator.of(context)
                  .pushReplacementNamed('/categorias_alimento_admin');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.seedling),
            title: Text('Admin Componentes'),
            onTap: () {
              componentProv.listarComponentes();
              Navigator.of(context)
                  .pushReplacementNamed('/registrar_componentes');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.egg),
            title: Text('Admin Ingredientes'),
            onTap: () {
              componentProv.listarComponentes();
              productoProv.listarProductos();
              ingredientesProv.listarIngredientes();
              Navigator.of(context)
                  .pushReplacementNamed('/registrar_ingredientes');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.ban),
            title: Text('Admin Restricciones'),
            onTap: () {
              componentProv.listarComponentes();
              encuestaProv.listarAlergias();
              encuestaProv.listarEnfermedades();
              encuestaProv.listarEstilosVida();
              encuestaProv.listarCategoriasAlimento();
              componentProv.listarComponentes();
              restriccionesProv.listarRestricciones();
              Navigator.of(context).pushReplacementNamed('/restricciones');
            },
          ),
        ],
        if (usuario != null && usuario.tipo == "Profesional Salud") ...[
          SizedBox(
            height: 5,
            child: CustomPaint(painter: Drawhorizontalline()),
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Admin Productos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/registro_producto');
            },
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Admin Productos Categoría'),
            onTap: () {
              encuestaProv.listarCategoriasAlimento();
              productoProv.listarProductos();
              categoriasProdProv.listar();
              Navigator.of(context)
                  .pushReplacementNamed('/productos_categoria');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.allergies),
            title: Text('Admin Alergias'),
            onTap: () {
              encuestaProv.listarAlergias();
              Navigator.of(context).pushReplacementNamed('/alergias_admin');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.headSideMask),
            title: Text('Admin Enfermedades'),
            onTap: () {
              encuestaProv.listarEnfermedades();
              Navigator.of(context).pushReplacementNamed('/enfermedades_admin');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.peace),
            title: Text('Admin Estilos de Vida'),
            onTap: () {
              encuestaProv.listarEnfermedades();
              Navigator.of(context).pushReplacementNamed('/estilos_admin');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.appleAlt),
            title: Text('Admin Categorias Alimento'),
            onTap: () {
              encuestaProv.listarCategoriasAlimento();
              Navigator.of(context)
                  .pushReplacementNamed('/categorias_alimento_admin');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.seedling),
            title: Text('Admin Componentes'),
            onTap: () {
              componentProv.listarComponentes();
              Navigator.of(context)
                  .pushReplacementNamed('/registrar_componentes');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.egg),
            title: Text('Admin Ingredientes'),
            onTap: () {
              componentProv.listarComponentes();
              productoProv.listarProductos();
              ingredientesProv.listarIngredientes();
              Navigator.of(context)
                  .pushReplacementNamed('/registrar_ingredientes');
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.ban),
            title: Text('Admin Restricciones'),
            onTap: () {
              componentProv.listarComponentes();
              encuestaProv.listarAlergias();
              encuestaProv.listarEnfermedades();
              encuestaProv.listarEstilosVida();
              encuestaProv.listarCategoriasAlimento();
              componentProv.listarComponentes();
              restriccionesProv.listarRestricciones();
              Navigator.of(context).pushReplacementNamed('/restricciones');
            },
          ),
        ],
        if (usuario != null && usuario.tipo == "Operario de Bar") ...[
          SizedBox(
            height: 5,
            child: CustomPaint(painter: Drawhorizontalline()),
          ),
          ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Mi Local'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/mi_bar');
              }),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Productos'),
            onTap: () {
              Navigator.pop(context);
              //Navigator.pushNamed(context, '/registro_producto');
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/registro_producto",
                (route) => route.isCurrent &&
                        route.settings.name == "/registro_producto"
                    ? false
                    : true,
              );
            },
          ),
        ],
        SizedBox(
          height: 5,
          child: CustomPaint(painter: Drawhorizontalline()),
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text('Información de Cuenta'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/info_usuario');
          },
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text('Realizar Encuesta'),
          onTap: () {
            encuestaProv.listarAlergias();
            encuestaProv.listarEnfermedades();
            encuestaProv.listarEstilosVida();
            encuestaProv.listarCategoriasAlimento();
            Navigator.pop(context);
            //Navigator.pushNamed(cont_usuario);
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/alergias",
                (route) => route.isCurrent && route.settings.name == "/alergias"
                    ? false
                    : true,
                arguments: usuario.id_usuario);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Cerrar Sesión'),
          onTap: () {
            authProv.deleteUsuario();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
            //Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ]),
    );
  }
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;

  Drawhorizontalline() {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(4.0, 0.0), Offset(300.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
