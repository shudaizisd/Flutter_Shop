import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'goods_info_page.dart';

///商品详情页面，实现淘宝京东等效果
class ShopDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopDetailState();
  }
}

class ShopDetailState extends State with SingleTickerProviderStateMixin {
  ///tab栏
  var tabs = <Tab>[];
  TabController _tabController;
  ///滑动监听
  ScrollController _scrollController = new ScrollController();
  ///监听商品模块的位置信息
  GlobalKey _goodsKey = GlobalKey();
  var _goodHeight = 0.0;
  ///详情页，用于展示商品图文信息
  Html _html;
  ///滑动多少距离显示顶部bar
  double DEFAULT_SCROLLER = 100;

  ///顶部bar的透明度，默认为透明，1为不透明
  double toolbarOpacity = 0.0;
  String htmlUrl = '<style>img {width: 100%}</style><p><img src="https://img10.360buyimg.com/cms/jfs/t1/182872/6/133/795112/607f3495Ea178190e/01c683a879c788c5.jpg"></p>';
  @override
  void initState() {
    super.initState();
    _html = new Html(data: htmlUrl);

    tabs = [
      Tab(text: "商品"),
      Tab(text: "详情"),
    ];
    _tabController = new TabController(length: 2, vsync: this);
    _scrollController.addListener(() {
      ///如果滑动的偏移量超出了自己设定的值，tab栏就进行透明化操作
      double t = _scrollController.offset / DEFAULT_SCROLLER;
      if (t < 0.0) {
        t = 0.0;
      } else if (t > 1.0) {
        t = 1.0;
      }
      if (mounted) {
        setState(() {
          toolbarOpacity = t;
        });
      }
      ///如果滑动偏移量大于商品页高度，tab就切换到详情页
      if (_scrollController.offset >= _goodHeight) {
        _tabController.animateTo(1);
      } else {
        _tabController.animateTo(0);
      }
    });

    ///计算商品信息页高度和位置信息
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      calculateHeight();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _tabController.dispose();
  }

  ///计算商品信息页的高度
  void calculateHeight() {
    _goodHeight =
        getSize(_goodsKey.currentContext) - (Platform.isIOS ? 88 : 50);
    print("calculateHeight $_goodHeight");
  }

  double getSize(BuildContext buildContext) {
    final RenderBox box = buildContext.findRenderObject();
    final size = box.size;
    return size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///底部购买商品、购物车
      bottomNavigationBar: buildBottomBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  key: _goodsKey,
                  ///商品页
                  child: GoodsInfoPage(),
                ),
                Container(
                  ///详情中的图片
                  child: _html,
                ),
              ],
            ),
          ),
          ///根据透明度显隐顶部的bar
          Opacity(
            opacity: toolbarOpacity,
            child: Container(
              height: 78,
              color: Colors.red,
              ///顶部显隐的bar
              child: buildTopBar(),
            ),
          )
        ],
      ),
    );
  }

  ///顶部
  AppBar buildTopBar() {
    double scale = MediaQuery.of(context).devicePixelRatio;
    return AppBar(
      backgroundColor: Colors.red,
      leading: Platform.isIOS ? GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(vertical:  scale > 2 ? 0 : 10),
            child: Image.asset("assets/images/back_status.webp",)
        ),
        onTap: (){
          Navigator.pop(context);
        },
      ) :
      IconButton(
        padding: EdgeInsets.symmetric(vertical:  scale > 3.0 ? 0 : 10),
        icon: Image.asset("assets/images/back_status.webp"),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      title: TabBar(
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(10),
        tabs: tabs,
        indicatorWeight: 3.5,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        controller: _tabController,
        onTap: (index) {
          if(_tabController.indexIsChanging) {
            switch(index) {
              case 0:
                _scrollController.jumpTo(0);
                _tabController.animateTo(0);
                break;
              case 1:
                _scrollController.jumpTo(_goodHeight);
                _tabController.animateTo(1);
                break;
            }
          }
        },
      ),
      centerTitle: true,
    );
  }

  ///创建底部栏
  BottomAppBar buildBottomBar(){
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20,),
            Expanded(
                flex: 3,
                child: Text("联系客服")),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(colors: [
                    Color(int.parse("ffff9b00", radix: 16)),
                    Color(int.parse("ffF8CD6A", radix: 16)),
                  ]),
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                child: Center(child: Text("加入购物车", style: TextStyle(color: Colors.white),)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(colors: [
                    Color(int.parse("ffFF5252", radix: 16)),
                    Color(int.parse("ffFF0000", radix: 16)),
                  ]),
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                child: Center(child: Text("直接购买", style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}