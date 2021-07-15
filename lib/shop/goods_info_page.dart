import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


///商品详情page内容页
class GoodsInfoPage extends StatefulWidget {

  const GoodsInfoPage({Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GoodsInfoState();
  }
}

class GoodsInfoState extends State<GoodsInfoPage> with AutomaticKeepAliveClientMixin {
  ///状态栏高度
  double statusHeight = MediaQueryData.fromWindow(window).padding.top ?? 20;

  ///banner广告图片
  List imgs = ["https://gd1.alicdn.com/imgextra/i1/2534651412/O1CN01ytQaH61MIjvsJWajq_!!2534651412.jpg",
    "https://gd1.alicdn.com/imgextra/i1/2534651412/O1CN01SlocUr1MIjsSIvL7r_!!2534651412.jpg",
    "https://gd2.alicdn.com/imgextra/i2/2534651412/O1CN01SATjJ91MIjtw2hVNC_!!2534651412.jpg"];

  /// 商品说明:
  String description = "上市时间 2020年10月\n" +
      "机身内存 128G\n" + "屏幕尺寸 6.1英寸\n";

  GoodsInfoState();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return buildListView(context);
  }

  ///构建布局内容
  Widget buildListView(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  ///banner广告图
                  child: Swiper(
                    key: UniqueKey(),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        Uri.encodeFull(imgs[index]),
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: imgs.length,
                    loop: imgs.length == 1 ? false : true,
                    autoplay: true,
                    pagination: SwiperPagination(
                      builder: SwiperPagination.dots,
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  padding:
                  EdgeInsets.only(left: 12, right: 48, top: 40, bottom: 20),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Image.asset(
                      "assets/images/back_status.webp",
                      width: 30,
                      height: 30,
                      fit: BoxFit.fitWidth,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          buildBodyView(context),
        ],
      ),
    );
  }

  /// 详情页商品信息展示
  Widget buildBodyView(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 12, right: 12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Text("Apple iPhone12(A2404)128G 白色 支持移动联通电信5G 双卡双待手机",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      softWrap: true,
                      maxLines: 2,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        ///商品价格
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: "￥",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: "6599",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: ".00",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                          ]),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text("首开会员年卡可省58.8元",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ],
                ),
                )],
            ),
        ),
        SizedBox(
          height: 6,
        ),

        ///商品描述
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 4),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 8),
            decoration: ShapeDecoration(
              color: Colors.white60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(description,
                  style: TextStyle(
                      fontSize: 14, color: Colors.black38),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
