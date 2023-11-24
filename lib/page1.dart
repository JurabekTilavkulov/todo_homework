import 'package:flutter/material.dart';
import 'package:swipe/swipe.dart';
import 'package:todo_homework/service/todo_service.dart';

import 'modal/todo_modal.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}




class _Page1State extends State<Page1> {

  bool isLoading=true;
  ToDoService dataBaseService=ToDoService();
  // listga dataBase dan kelgan malumotni joylaymiz
  List<ToDoModal>listInfor=[];
  int tabBarIndex=0;

  @override
  void initState() {
    dataBaseService.initialDataBase().then((value){
      // value bunda null qiymat qabul qib database yaratadi
      setState(() {
        isLoading=false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text("                  TO DO ",style: TextStyle(color: Colors.white),),
          ),
      body: Stack(children: [
        Container(    //orqa fon
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset("assets/download.png"),
        ),  //orqa fon
        Container(
          child: Column(
            children: [
              Container(      //TabBar qismi
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreenAccent,
                  boxShadow: [BoxShadow(blurRadius: 10)]
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                    boxShadow: [BoxShadow(blurRadius: 10)]
                  ),
                  indicatorWeight: 10,
                  onTap: (index){
                    tabBarIndex=index;
                  },
                  tabs: [
                    Tab(icon: Icon(Icons.accessibility),text: "TO DO",),
                    Tab(icon: Icon(Icons.access_time_rounded),text: "DOING",),
                    Tab(icon: Icon(Icons.accessible_outlined),text: "DONE",),
                  ],
                ),
              ), //TabBar qismi
              Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                //isLoading true bolsa body qismida cir..bolsin, yoqsa build bolsin
                child:isLoading?CircularProgressIndicator():
                StreamBuilder(
                  stream: dataBaseService.findAllInforByStream(),
                  // xar doim o'zgarib turish uchun
                  builder: (BuildContext buildContext, AsyncSnapshot<List<ToDoModal>> snapshot){
                    //ikkkalasi builderni ichidagi standart sozlar
                    listInfor=snapshot.data??[];
                    return TabBarView(children:[
                      
                      builtItemList([...listInfor.where((element) => element.status=="todo").toList()]),
                      // builtItemList bu yerda funksiya orqali widjet yasaydi
                      builtItemList([...listInfor.where((element) => element.status=="doing").toList()]),
                      //har bir yasalajak widgetga listni statusiga qarab jonatiladi
                      builtItemList([...listInfor.where((element) => element.status=="done").toList()]),

                    ]);
                  }
                  ),
                ),  //TabBarView qismi
            ],
          ),
        )   //App bar

      ],),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              dataBaseService.insertInformation(ToDoModal("textAny", tabBarIndex==1?"doing":tabBarIndex==0?"todo":"done", "dataTime"));
            },
            child: Icon(Icons.add),
          ),

    ));
  }
  ListView builtItemList(List<ToDoModal> list){
    return ListView.builder(itemBuilder: (context, index){ // bu index har bir item indexi

      return Swipe(
          onSwipeRight: (){
          dataBaseService.updateInformation(ToDoModal(list[index].textAny, tabBarIndex==0?"doing":"done", list[index].dataTime,id: list[index].id));
          },
          onSwipeLeft: (){
          dataBaseService.updateInformation(ToDoModal(list[index].textAny, tabBarIndex==2?"doing":"todo", list[index].dataTime,id: list[index].id));
          },

          child:Row(children: [
            Container(
              padding: EdgeInsets.only(left: 20,top: 10),
              height: 30,
              width: 200,
              child: Text("${list[index].id}     ${list[index].textAny}     ${list[index].dataTime}"),
            ),
            Container(
              height: 30,
              width: 160,
              child: IconButton(
              icon: Icon(Icons.delete,color: Colors.red,),
              onPressed: (){
                dataBaseService.deleteInformation(list[index]);
              },
            ),),
          ],) );
    },
      itemCount: list.length,
    );
  }
}
