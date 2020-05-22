import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:flutter/material.dart';

Color color = Color(0xff59c2ff);
final img =
    "https://images.unsplash.com/photo-1587733761351-c75905de4127?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=300&ixlib=rb-1.2.1&q=80&w=300";

class ArticleDetailPage extends StatefulWidget {
  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            width: width,
            height: height * .4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(img),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            width: width,
            height: height * .4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.2),
                    Colors.black.withOpacity(.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: height * .3,
            left: 0,
            width: width,
            height: (height * .7),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Beautiful House in Malang",
                    style: TextStyle(
                      fontSize: sSp(20),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: sHeight(14)),
                  Container(
                    height: sHeight(5),
                    width: width * .25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: color,
                    ),
                  ),
                  SizedBox(height: sHeight(20)),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: new NetworkImage(
                          "https://heavyeditorial.files.wordpress.com/2017/07/jessica-johnson-5.jpg?w=531&quality=65&strip=all&h=531"),
                    ),
                    title: Text("by Lynne William"),
                    subtitle: Text("January 23, 2019"),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        "Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo, haciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, consecteur, en un pasaje de Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones 1.10.32 y 1.10.33 de de Finnibus Bonorum et Malorum (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, Lorem ipsum dolor sit amet.., viene de una linea en la sección 1.10.32. El trozo de texto estándar de Lorem Ipsum usado desde el año 1500 es reproducido debajo para aquellos interesados. Las secciones 1.10.32 y 1.10.33 de de Finibus Bonorum et Malorum por Cicero son también reproducidas en su forma original exacta, acompañadas por versiones en Inglés de la traducción realizada en 1914 por H. Rackham.",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
