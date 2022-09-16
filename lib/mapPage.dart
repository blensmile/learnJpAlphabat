
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn50map/utils/route_helper.dart';
var list = [
  ["あ ア a","い イ i","う ウ u","え エ e","お オ o"],
  ["か カ ka","き キ ki","く ク ku","け ケ ke","こ コ ko"],
  ["さ サ sa","し シ shi","す ス su","せ セ se","そ ソ so"],
  ["た タ ta","ち チ chi","つ ツ tsu","て テ te","と ト to"],
  ["な ナ na","に ニ ni","ぬ ヌ nu","ね ネ ne","の ノ no"],
  ["は ハ ha","ひ ヒ hi","ふ フ fu","へ ヘ he","ほ ホ ho"],
  ["ま マ ma","み ミ mi","む ム mu","め メ me","も モ mo"],
  ["や ヤ ya","ゆ ユ yu","よ ヨ yo"],
  ["ら ラ ra","り リ ri","る ル ru","れ レ re","ろ ロ ro"],
  ["わ ワ wa","を ヲ wo"],
  ["ん ン n"],
  ["が ガ ga","ぎ ギ gi","ぐ グ gu","げ ゲ ge","ご ゴ go"],
  ["ざ ザ za","じ ジ ji","ず ズ zu","ぜ ゼ ze","ぞ ゾ zo"],
  ["だ ダ da","ぢ ヂ ji","づ ヅ zu","で デ de","ど ド do"],
  ["ば バ ba","び ビ bi","ぶ ブ bu","べ ベ be","ぼ ボ bo"],
  ["ぱ パ pa","ぴ ピ pi","ぷ プ pu","ぺ ペ pe","ぽ ポ po"],
];

class MapPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var itemW = width/6;
    var textStyle = TextStyle(fontSize: itemW/3.5,fontWeight: FontWeight.w500,color: Colors.black87);
    return Scaffold(
      appBar: AppBar(title: Text("五十音图"),actions: [
        InkWell(child:Center(child:  Text("测试",style: TextStyle(fontSize: 16),),),onTap: ()=>RouteHelper.routeTo(context, TestPage()),),
      SizedBox(width: 10,)]),
      body:ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          var item = list[index];
          var viewList = <Widget>[];
          var indx = 0;
          item.forEach((element) {
            var s = element.split(' ');
            viewList.add(Container(
                height: itemW,
                width: itemW+itemW*0.1,
                color: ((indx+index)%2==0)?Colors.blue[50]:Colors.white,
                padding: EdgeInsets.all(itemW*0.1,),
                child:Stack(
                  children: [
                    Align(alignment: Alignment.topLeft, child: Text(s[0],style: textStyle,),),
                    Align(alignment: Alignment.topRight,child: Text(s[1],style: textStyle),),
                    Align(alignment: Alignment.bottomCenter,child: Text(s[2],style: textStyle),)
                  ],
                )
            ));
            indx++;
          });
          return Container(
              padding: EdgeInsets.only(left: itemW*0.25,right: itemW*0.25),
              child:Row(
                children: viewList,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ));
        },),
    );
  }

}

class TestPage extends StatefulWidget{

  var set = [];

  @override
  StatefulElement createElement() {
    for(List item in list){
        set.addAll(item);
    }
    return super.createElement();
  }
  @override
  State<StatefulWidget> createState() {
    return TestState();
  }

}

class TestState extends State<TestPage>{

  bool isHide = true;
  String current = "";
  bool isExchange=false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textStyle = TextStyle(fontSize: size.width/10,fontWeight: FontWeight.w300,color: Colors.black87);
    if(isHide){
      current = widget.set[Random().nextInt(widget.set.length)];
      isExchange = Random().nextBool();
    }
    var s = current.split(" ");
    return Scaffold(
      appBar: AppBar(title: Text("测试"),),
      body:
      InkWell(
      // GestureDetector(
      //   behavior: HitTestBehavior.opaque,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue[50],
            padding: EdgeInsets.fromLTRB(20,20,20,size.height/4,),
            child:Stack(
              children: [
                Align(alignment: Alignment.center, child: Text(isExchange?s[1]:s[0],style: TextStyle(fontSize: size.width/3,fontWeight: FontWeight.w500,color: Colors.black87),),),
                Align(alignment: Alignment.bottomCenter,child: Text(isHide?"":(isExchange?s[0]:s[1])+"    "+s[2],style: textStyle),),
              ],
            )
        ),
        onTap: (){
          isHide = !isHide;
          setState(() {});
        },
      ),
    );
  }

}

