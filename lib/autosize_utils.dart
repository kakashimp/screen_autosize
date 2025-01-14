part of screen_autosize;

class AutoSizeUtils {
  static const double NON_INIT_RATIO = 0.0;

  double baseScreenWidth = 375;

  // 工厂模式
  factory AutoSizeUtils() => instance;

  static AutoSizeUtils get instance => _getInstance();
  static AutoSizeUtils? _instance;

  AutoSizeUtils._internal();

  void initConfig({required double baseWidth}) {
    baseScreenWidth = baseWidth;

    devicePixelRatio = NON_INIT_RATIO;
    _tryInit();
  }

  void _tryInit() {
    if (devicePixelRatio != NON_INIT_RATIO) {
      return;
    }
    var window = WidgetsBinding.instance?.window ?? ui.window;
    devicePixelRatio = window.physicalSize.width / baseScreenWidth;
    mediaWidth = baseScreenWidth;
    mediaHeight = window.physicalSize.height / devicePixelRatio;
    statusBarHeight = window.padding.top / devicePixelRatio;
    bottomBarHeight = window.padding.bottom / devicePixelRatio;
  }

  static AutoSizeUtils _getInstance() {
    if (_instance == null) {
      _instance = new AutoSizeUtils._internal();
    }
    _instance!._tryInit();
    return _instance!;
  }

  EdgeInsets getPadding() {
    return EdgeInsets.only(top: statusBarHeight, bottom: bottomBarHeight);
  }

  Size get screenSize => Size(mediaWidth, mediaHeight);

  // 屏幕宽
  late double mediaWidth;

  // 屏幕高
  late double mediaHeight;

  //屏幕像素密度
  late double devicePixelRatio = NON_INIT_RATIO;

  late double bottomBarHeight;

  late double statusBarHeight;
}
