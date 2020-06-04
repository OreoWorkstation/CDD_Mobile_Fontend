import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/pet/pet_add_first.dart';
import 'package:cdd_mobile_frontend/view/pet/pet_page.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_list_provider.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetListPage extends StatefulWidget {
  PetListPage({Key key}) : super(key: key);

  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PetListProvider>(context, listen: false).fetchPetList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetListProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.6,
            centerTitle: true,
            title: Text(
              "宠物列表",
              style:
                  TextStyle(color: AppColor.dark, fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: AppColor.dark,
                ),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PetAddFirstPage(),
                    ),
                  );
                  print("back to pet list");
                  // provider.fetchPetList();
                },
              ),
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.dark,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
          ),
          body: Builder(
            builder: (_) {
              // 正在请求数据
              if (provider.isBusy) {
                return Center(child: CircularProgressIndicator());
              }
              // 请求出错
              if (provider.isError) {
                return Container(child: Text("请求出错"));
              }
              // 该用户没有宠物
              if (provider.petList.length == 0) {
                return Center(
                    child: Text(
                  "赶快添加你的宠物吧！",
                  style: TextStyle(
                    color: AppColor.lightGrey,
                    fontSize: sSp(18),
                    fontWeight: FontWeight.bold,
                  ),
                ));
              }
              return PetListBody(
                petListProvider: provider,
              );
            },
          ),
        );
      },
    );
  }
}

const List<Color> _colorList = [
  Color(0xFFEEE0FA),
  Color(0xFFDAF0FE),
  Color(0xFFFDE6D1),
];

class PetListBody extends StatefulWidget {
  final PetListProvider petListProvider;
  PetListBody({Key key, this.petListProvider}) : super(key: key);

  @override
  _PetListBodyState createState() => _PetListBodyState();
}

class _PetListBodyState extends State<PetListBody> {
  PetListProvider _provider;
  @override
  void initState() {
    super.initState();
    _provider = widget.petListProvider;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _provider.petList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => PetProvider(_provider.petList[index].id),
                  child: PetPage(
                    id: _provider.petList[index].id,
                  ),
                ),
              ),
            );
            _provider.fetchPetList();
          },
          child: _buildPetListItem(
              _provider.petList[index], _colorList[index % _colorList.length]),
          // child: _buildPetListItem(provider.petList[index], Colors.white),
        );
      },
    );
  }

  Widget _buildPetListItem(PetEntity pet, Color color) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: sWidth(20), vertical: sHeight(10)),
      padding:
          EdgeInsets.symmetric(horizontal: sWidth(16), vertical: sHeight(16)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: pet.species == 'cat'
                ? Icon(
                    Iconfont.cat,
                    color: AppColor.primary.withOpacity(.7),
                    size: sSp(28),
                  )
                : Icon(
                    Iconfont.dog4,
                    color: AppColor.primary.withOpacity(.7),
                    size: sSp(28),
                  ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Hero(
                  tag: pet.nickname,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: sWidth(2),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      maxRadius: sWidth(60) / 2,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(pet.avatar),
                    ),
                  ),
                ),
                SizedBox(width: sWidth(20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pet.nickname,
                      style: TextStyle(
                        fontSize: sSp(17),
                        color: AppColor.dark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: sHeight(12)),
                    Container(
                        width: sWidth(200),
                        child: Text(
                          pet.introduction,
                          style: TextStyle(
                            fontSize: sSp(15),
                            color: AppColor.grey,
                          ),
                          softWrap: true,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
