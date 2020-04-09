import 'package:cdd_mobile_frontend/view/page/pet/diary/add_diary_page.dart';
import 'package:cdd_mobile_frontend/view/page/pet/diary/show_diary_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({Key key}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(123, 104, 238, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print("press add diary button");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddDiaryPage(),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Pet Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
          ),
          DiaryList()
        ],
      ),
    );
  }
}

class DiaryList extends StatelessWidget {
  /*const DiaryList({Key key}) : super(key: key);*/
  var items=new List<String>.generate(100, (i) => "Items $i");
  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context,int index) {
          return new GestureDetector(
            onTap: () {
              print("tab item...");
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowDiaryPage(),
              ));
            },
            child: Card(
              color: Colors.white,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${items[index]}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

/*class DiaryList extends StatelessWidget {
  const DiaryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        padding: EdgeInsets.all(4),
        childAspectRatio: 11 / 2,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("tab item...");
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowDiaryPage(),
              ));
            },
            child: Card(
              color: Colors.white,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "日记项1",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "日记项2",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "日记项3",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "日记项4",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "日记项5",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "日记项6",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "日记项7",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
