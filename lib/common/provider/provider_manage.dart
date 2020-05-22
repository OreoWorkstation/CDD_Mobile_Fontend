import 'package:cdd_mobile_frontend/view_model/article_provider.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:cdd_mobile_frontend/view_model/theme_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (_) => UserProvider(),
  ),
  ChangeNotifierProvider(
    create: (_) => FeedProvider(),
  ),
  ChangeNotifierProvider(
    create: (_) => ArticleProvider(),
  ),
];
