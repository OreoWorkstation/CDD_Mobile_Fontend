import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/util/diary_map.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/diary/calendar.dart';
import 'package:cdd_mobile_frontend/view/diary/diary_operation.dart';
import 'package:cdd_mobile_frontend/view_model/diary/diary_delete_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
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
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DiaryOperationPage(
            operation: 0,
            diary: DiaryEntity(
              petId: widget.petId,
              createTime: _currentSelectedDay,
            ),
          ),
        ),
      );
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DiaryOperationPage(
            operation: 1,
            diary: DiaryEntity(
              petId: widget.petId,
              content: _selectedEvents[3],
              imagePath: _selectedEvents[0],
              createTime: _currentSelectedDay,
            ),
          ),
        ),
      );
    }
    _fetchDiaryList();
  }

  _handleDeleteButton(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => DiaryDeleteProvider(),
          child: Consumer<DiaryDeleteProvider>(
            builder: (_, diaryDeleteProvider, __) {
              return LoadingOverlay(
                isLoading: diaryDeleteProvider.isBusy,
                color: Colors.transparent,
                child: DeleteConfirmDialog(
                  "确定删除这篇日记吗?",
                  () async {
                    await diaryDeleteProvider.deleteDiary(
                        diaryId: _selectedEvents[4]);
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
          ),
        );
      },
    );
    _fetchDiaryList();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              elevation: 0.6,
              title: Text(
                "日记",
                style: TextStyle(
                    color: AppColor.dark, fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back, color: AppColor.dark),
              ),
              actions: <Widget>[
                _selectedEvents.length == 0
                    ? SizedBox.shrink()
                    : IconButton(
                        onPressed: () => _handleDeleteButton(context),
                        icon: Icon(
                          Iconfont.shanchu,
                          color: Colors.red,
                          size: sSp(25),
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
                    color: AppColor.dark,
                    size: sSp(25),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: sWidth(20)),
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
      padding: EdgeInsets.symmetric(vertical: sHeight(20)),
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
                    fontSize: sSp(46),
                    color: AppColor.dark,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: sWidth(14)),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    cddGetChineseMonth(_currentSelectedDay),
                    style: TextStyle(
                      color: AppColor.dark,
                      fontWeight: FontWeight.bold,
                      fontSize: sSp(16),
                    ),
                  ),
                  SizedBox(height: sHeight(16)),
                  Text(
                    "${_currentSelectedDay.year}",
                    style: TextStyle(
                      color: AppColor.dark,
                      fontWeight: FontWeight.bold,
                      fontSize: sSp(16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            cddGetChineseWeekday(_currentSelectedDay),
            style: TextStyle(
                color: AppColor.dark,
                fontWeight: FontWeight.bold,
                fontSize: sSp(18)),
          ),
          IconButton(
            onPressed: () => _handleDiaryOperation(context),
            icon: Icon(
              Iconfont.bianji,
              color: AppColor.dark,
              size: sSp(30),
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
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SinglePhotoView(
                              imageProvider: NetworkImage(_selectedEvents[0]),
                              heroTag: 'simple',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: sHeight(300),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: Radii.k10pxRadius,
                          image: DecorationImage(
                            image: NetworkImage(_selectedEvents[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: sHeight(10)),
              Text(
                _selectedEvents[3],
                style: TextStyle(
                  fontSize: sSp(16),
                  letterSpacing: 0.6,
                  color: AppColor.dark,
                ),
              ),
            ],
    );
  }

  Widget _buildDiaryTip() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(height: sHeight(50)),
        Container(
          height: sHeight(250),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/state/edit.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: sHeight(30)),
        Text(
          "记录你与宠物的快乐时光吧",
          style: TextStyle(
              fontSize: sSp(20),
              fontWeight: FontWeight.bold,
              color: AppColor.lightGrey,
              letterSpacing: 0.6),
        ),
      ],
    );
  }
}
/*
class DiaryPage extends StatefulWidget {
  DiaryPage({Key key}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _currentSelectedDay = cddFormatDatetime(DateTime.now());

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryListProvider>(
      builder: (_, diaryListProvider, __) => Builder(
        builder: (_) {
          if (diaryListProvider.isBusy) {
            return Center(child: CircularProgressIndicator());
          }
          return LoadingOverlay(
            isLoading: diaryListProvider.isBusy,
            color: Colors.transparent,
            child: Scaffold(
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
                            size: sSp(25),
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
                      size: sSp(25),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: sWidth(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _buildHeader(),
                    const SizedBox(height: 8.0),
                    Expanded(child: _buildDiaryList()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/
