import 'package:flutter/cupertino.dart';


//route动画

class RouteHelper{


  static Future routeWithCheck(BuildContext context,Widget widget,{RouteTransitionsBuilder? transBuilder}){
    // LogUtils.d("routeTo:"+widget.toStringShort());
    // var tokenValid = Global.user.isTokenValid();
    // var w = tokenValid?widget:LoginPhoneVerifyPage();
    // var trans = tokenValid?transBuilder:getVerticalTrans();
    var w = widget;
    var trans = transBuilder;
    return trans!=null?Navigator.of(context).push(_pageRoute(w,transBuilder: trans))
        :Navigator.of(context).push(CupertinoPageRoute(settings:RouteSettings(name: w.toStringShort()),builder: (context)=>w));
  }

  static Future routeTo(BuildContext context,Widget widget,{RouteTransitionsBuilder? transBuilder}){
    // LogUtils.d("routeTo:"+widget.toStringShort());
    return transBuilder!=null?Navigator.of(context).push(_pageRoute(widget,transBuilder: transBuilder))
        :Navigator.of(context).push(  CupertinoPageRoute(settings:RouteSettings(name: widget.toStringShort()),builder: (context)=>widget));
  }

  static Future routeAndRemoveTo(BuildContext context,Widget widget,{RouteTransitionsBuilder? transBuilder,bool value=false}){
    // LogUtils.d("routeTo:"+widget.toStringShort());
    return Navigator.pushAndRemoveUntil(context, _pageRoute(widget,transBuilder:transBuilder),(route)=>value,);
  }

  static void pop<T extends Object>(BuildContext context, [ T? result ]){
    // LogUtils.d("routeTo:"+context.widget.toStringShort());
    Navigator.pop(context, result);
  }

  static Future routeDirectly(BuildContext context,Widget widget){
    return Navigator.of(context).push(PageRouteBuilder(
        settings:RouteSettings(name: widget.toStringShort()),
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context,anim1,anim2)=>widget,
    ));
  }

  //默认动画
  static PageRouteBuilder _pageRoute(widget,{RouteTransitionsBuilder? transBuilder}){
    return PageRouteBuilder(
        settings:RouteSettings(name: widget.toStringShort()),
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context,anim1,anim2)=>widget,
        transitionsBuilder: transBuilder??getHorizontalTrans()
    );
  }


  //默认动画, 水平滑动
  static RouteTransitionsBuilder getHorizontalTrans(){
    return (BuildContext context, Animation<double> anim1, Animation<double> anim2, Widget child) {
      return SlideTransition(
        position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(CurvedAnimation(parent: anim1, curve: Curves.fastOutSlowIn)),
        child: FadeTransition(opacity: Tween(begin: 0.0, end: 2.0)
              .animate(CurvedAnimation(parent: anim1, curve: Curves.fastOutSlowIn)),
          child: child,
        ),
      );
    } ;
  }

  //缩放
  static RouteTransitionsBuilder getScaleTrans(){
    return (BuildContext context, Animation<double> anim1, Animation<double> anim2, Widget child) {
      return ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: anim1, curve: Curves.fastOutSlowIn)),
          child: FadeTransition(opacity: Tween(begin: 0.0, end: 2.0)
              .animate(CurvedAnimation(parent: anim1, curve: Curves.fastOutSlowIn)),
            child: child,
          ));
    };
  }

  //渐变
  static RouteTransitionsBuilder getFadeTrans(){
    return (BuildContext context, Animation<double> anim1, Animation<double> anim2, Widget child) {
      return FadeTransition(
        opacity: Tween(begin: 0.0, end: 2.0)
            .animate(CurvedAnimation(parent: anim1, curve: Curves.fastOutSlowIn)),
        child: child,
      );
    };
  }

  //从下到上
  static RouteTransitionsBuilder getVerticalTrans(){
    return (BuildContext context, Animation<double> anim1, Animation<double> anim2, Widget child) {
      return SlideTransition(
        position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
            .animate(CurvedAnimation(parent: anim1, curve: Curves.fastOutSlowIn)),
        child: FadeTransition(opacity: Tween(begin: 0.0, end: 2.0)
              .animate(CurvedAnimation(parent: anim1, curve: Curves.fastOutSlowIn)),
          child: child,
        ),
      );
    };
  }

}

//旋转+缩放效果
class CustomRouteRotateZoom extends PageRouteBuilder {
  final Widget widget;
  CustomRouteRotateZoom(this.widget)
      : super(
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: (BuildContext context, Animation<double> anim1,
          Animation<double> anim2) {
        return widget;
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> anim1,
          Animation<double> anim2,
          Widget child) {
        return RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: anim1, curve: Curves.fastOutSlowIn)),
            child: ScaleTransition(
              scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: anim1, curve: Curves.fastOutSlowIn)),
              child: child,
            ));
      });

}
