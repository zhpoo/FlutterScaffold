/// 根据通用的[RouteArguments]路由参数判断是否来自[target]页面
bool isRouteFrom(RouteArguments arguments, SourcePage target) {
  return arguments != null && arguments.source == target;
}

/// 路由参数对象封装
class RouteArguments<T> {
  final SourcePage source;
  final T data;

  RouteArguments({this.source = SourcePage.unknown, this.data});
}

/// 跳转界面的来源
enum SourcePage {
  unknown,
  login,
  signUp,

  // could add more enum values if need.
}
