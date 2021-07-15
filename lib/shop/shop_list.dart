import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/shop/shop_detail.dart';

///商品列表页
class ShopListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopListState();
  }
}

class ShopListState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("商品列表"),
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            for(int i = 1; i < 11; i++)
              ListTile(
                leading: CircleAvatar(child: Text('$i')),
                title: Text("商品$i"),
                subtitle: Text("价格：${i * 10}元"),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) {
                      return ShopDetailPage();
                    }
                  ));
                },
              ),
          ],
        ),
      ),
    );
  }
  
  
  
}