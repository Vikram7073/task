import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/modal/list_data_model.dart';
import 'package:http/http.dart'as http;
class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
// data fetched by api
  List<Data>? postList = [];
  List _item=[];

  Future<List<Data>?>getPostApi1() async {
    postList?.clear();
    final response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    var data =jsonDecode(response.body.toString());
    print(data);
    if(response.statusCode==200){
      for(var i in data['data']){
        postList?.add(Data.fromJson(i));
        setState(() {

        });
      }
      // print(postList?.length);
      return postList;
    }
    else{
      return postList;
    }
  }

 // fetch data from  json
  Future readjson()async{
    final String res=await rootBundle.loadString("assets/data.json");
    final data=await json.decode(res);
    setState(() {
      _item.addAll(data["fast_food_items"]);
      print(data);
      print("this is len ${_item.length}");

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPostApi1();
    readjson();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Task",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  //color: Colors. green,
                  borderRadius: BorderRadius.circular(10.r)
              ),
              child: const TabBar(
                  indicatorColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.green,
                  tabs: [
                    Tab(text: "Tab1"),
                    Tab(text: "Tab2"),
                  ]),
            ),
            Expanded(
                child:
                TabBarView(children: [
                  tab1Data(),
                  tab2Data()
                ])
            ),
          ],
        ),
      ),
    );
  }

   tab1Data(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: postList?.length,
        itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.network(postList?[index].avatar??"",height: 60.h,width: 60.w,fit: BoxFit.fill,)),
              SizedBox(width: 30.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(postList?[index].firstName??""),
                  Text(postList?[index].email??""),
                  Text(postList?[index].id.toString()??"")

                ],
              )


            ],
          ),
        );

    });
  }
  tab2Data(){
    return ListView.builder(
      shrinkWrap: true,
        itemCount: _item.length,
        itemBuilder: (context,index){
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ClipRRect(
                //     borderRadius: BorderRadius.circular(30.r),
                //     child: Image.network(_item[index]["image"].toString()??"",)),
                // SizedBox(width: 20.w,),
                Icon(Icons.radio_button_checked,color: (_item[index]["veg"]??false==true)?Colors.green:Colors.red,),
                SizedBox(width: 20.w,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 Text(_item[index]["name"]??""),
                    SizedBox(
                      width: 250.w,
                        child: Text(_item[index]["description"]??"",overflow: TextOverflow.ellipsis,)),
                  ],
                ),

              ],
            ),
          );

        });
  }
}
