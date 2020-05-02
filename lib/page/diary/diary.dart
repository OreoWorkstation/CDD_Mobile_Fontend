import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/diary_map.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/page/diary/calendar.dart';
import 'package:cdd_mobile_frontend/page/diary/diary_add.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryPage extends StatefulWidget {
  final petId;
  DiaryPage({Key key, @required this.petId}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with TickerProviderStateMixin {
  APIResponse<List<DiaryEntity>> _apiResponse;

  bool _isLoading = false;

  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _currentSelectedDay = cddFormatDatetime(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchDiaryList();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  _fetchDiaryList() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await DiaryAPI.getDiaryList(petId: widget.petId);
    setState(() {
      _isLoading = false;
      _events = cddConvertDiaryMap(_apiResponse.data);
      print(_events.containsKey(DateTime(2020, 4, 14)));
      _selectedEvents = _events[_currentSelectedDay] ?? [];
    });
  }

  _handleDiaryOperation(BuildContext context) async {
    if (_selectedEvents.length == 0) {
      await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DiaryAddPage(),
      ));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              elevation: 0.0,
              title: Text(
                "日记",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              actions: <Widget>[
                _selectedEvents.length == 0
                    ? Spacer()
                    : IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Iconfont.shanchu,
                          color: Colors.red,
                          size: cddSetFontSize(25),
                        ),
                      ),
                IconButton(
                  onPressed: () async {
                    var response = await showDialog(
                      context: context,
                      builder: (context) => CalendarPage(
                        events: _events,
                        selectedEvents: _selectedEvents,
                        animationController: _animationController,
                        calendarController: _calendarController,
                        initialSelectedDay: _currentSelectedDay,
                      ),
                    );
                    _selectedEvents =
                        response != null ? response[0] : _selectedEvents;
                    _calendarController =
                        response != null ? response[1] : _calendarController;
                    _currentSelectedDay =
                        response != null ? response[2] : _currentSelectedDay;
                    setState(() {});
                  },
                  icon: Icon(
                    Iconfont.rili,
                    color: Colors.black,
                    size: cddSetFontSize(25),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: cddSetWidth(20)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildHeader(),
                  const SizedBox(height: 8.0),
                  Expanded(child: _buildDiaryList()),
                ],
              ),
            ),
          );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: cddSetHeight(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${_currentSelectedDay.day}",
                style: TextStyle(
                    fontSize: cddSetFontSize(46),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: cddSetWidth(14)),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    cddGetChineseMonth(_currentSelectedDay),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: cddSetFontSize(17),
                    ),
                  ),
                  SizedBox(height: cddSetHeight(17)),
                  Text(
                    "${_currentSelectedDay.year}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: cddSetFontSize(17),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            cddGetChineseWeekday(_currentSelectedDay),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: cddSetFontSize(20)),
          ),
          IconButton(
            onPressed: () => _handleDiaryOperation(context),
            icon: Icon(
              Iconfont.bianji,
              color: Colors.black,
              size: cddSetFontSize(30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiaryList() {
    return ListView(
      children: _selectedEvents.length == 0
          ? <Widget>[_buildDiaryTip()]
          : <Widget>[
              _selectedEvents[0] == ""
                  ? Container()
                  : Container(
                      height: cddSetHeight(300),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: Radii.k10pxRadius,
                        image: DecorationImage(
                          image: NetworkImage(_selectedEvents[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SizedBox(height: cddSetHeight(10)),
              Text(
                _selectedEvents[3],
                style:
                    TextStyle(fontSize: cddSetFontSize(17), letterSpacing: 2),
              ),
            ],
    );
  }

  Widget _buildDiaryTip() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(height: cddSetHeight(30)),
        Text(
          "今天还没有记录日记哦，赶快记录今天你与宠物的快乐时光吧",
          style: TextStyle(
              fontSize: cddSetFontSize(20),
              fontWeight: FontWeight.bold,
              color: AppColor.secondaryElement),
        ),
        SizedBox(height: cddSetHeight(100)),
        Container(
          height: cddSetHeight(250),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/edit.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
