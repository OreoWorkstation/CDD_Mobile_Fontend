import 'package:cdd_mobile_frontend/provider/cost_provider.dart';
import 'package:cdd_mobile_frontend/provider/diary_provider.dart';
import 'package:cdd_mobile_frontend/provider/pet_provider.dart';
import 'package:cdd_mobile_frontend/provider/photo_provider.dart';
import 'package:cdd_mobile_frontend/provider/user_provider.dart';
import 'package:cdd_mobile_frontend/provider/weight_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => UserProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => PetProvider(),
  ),
  // ChangeNotifierProvider(
  //   create: (context) => DiaryProvider(),
  // ),
  // ChangeNotifierProvider(
  //   create: (context) => PhotoProvider(),
  // ),
  ChangeNotifierProvider(
    create: (context) => WeightProvider(),
  ),
  // ChangeNotifierProvider(
  //   create: (context) => CostProvider(),
  // ),
];
