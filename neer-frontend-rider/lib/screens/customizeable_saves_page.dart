import 'package:login/theme/global.dart';
import 'package:flutter/material.dart';
import '../theme/global.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'set_pickup_destination.dart';
import 'package:toast/toast.dart';
import 'add_customed_place.dart';

class Saved {
  String name;
  String address;
  Icon icon;

  Saved(this.name, this.address, this.icon);
}

List<Saved> labeled = new List<Saved>.generate(
    15, (i) => new Saved("labeled$i", "Address$i", Icon(Icons.home)));

List<Saved> wantToGo = new List<Saved>.generate(
    15, (i) => new Saved("wantToGo$i", "Address$i", Icon(Icons.star_border)));

class CustomizeableSaves extends StatefulWidget {
  @override
  _CustomizeableSavesState createState() => _CustomizeableSavesState();
}

class _CustomizeableSavesState extends State<CustomizeableSaves> {
  @override

  Future onRefresh() {
    return Future.delayed(Duration(seconds: 1), () {
      Toast.show('Already updated', context);
    });
  }

  final screenTitle = 'Saved';
  Widget build(BuildContext context) {
    return MaterialApp(
//      home: DefaultTabController(
//        length: 2,
//        child:
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: blueColor,
//            bottom: TabBar(
//              labelColor: Colors.black,
//              tabs: [
//                Tab(text: "Labeled",),
//                Tab(text: "Want to go"),
//              ],
//            ),
          title: Text(
            screenTitle,
            style: primaryText,
          ),
          centerTitle: true,
          leading: new IconTheme(
            data: new IconThemeData(
              color: Colors.black,
            ),
            child: new IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetPickupDestination(),
                  ),
                );
              },
            ),
          ),
        ),
        body:
//          TabBarView(
//            children: <Widget>[
        RefreshIndicator(
          onRefresh: this.onRefresh,
          child: ListView.separated(
            itemCount: labeled.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              return ListTile(
                onTap: (){},  //Go to set pick up and destination page and automatically fill the search destination text field
                title: Text("${labeled[index].name}"),
                subtitle: Text('${labeled[index].address}'),
                leading: labeled[index].icon,
              );
            },
            separatorBuilder: (context, index){
              return Divider(
                height: .5,
//                      indent: 75,
                color: Color(0xFFDDDDDD),
              );
            },
          ),
        ),

//              ListView.separated(
//                  itemCount: wantToGo.length,
//                  scrollDirection: Axis.vertical,
//                  itemBuilder: (context, index){
//                    return ListTile(
//                      onTap: (){},  //Go to set pick up and destination page and automatically fill the search destination text field
//                      title: Text("${wantToGo[index].name}"),
//                      subtitle: Text('${wantToGo[index].address}'),
//                      leading: wantToGo[index].icon,
//                    );
//                  },
//                  separatorBuilder: (context, index){
//                    return Divider(
//                      height: .5,
////                      indent: 75,
//                      color: Color(0xFFDDDDDD),
//                    );
//                  },
//                ),

//              ListView.builder(
//                itemCount: wantToGo.length,
//                scrollDirection: Axis.vertical,
//                itemBuilder: (context, index){
//                  return Card(
//                    child: ListTile(
//                      onTap: (){},
//                      title: Text("${wantToGo[index].name}"),
//                      subtitle: Text('${wantToGo[index].address}'),
//                      leading: Icon(
//                        MdiIcons.map,
//                      ),
//                    ),
//                  );
//                },
//              ),
//            ],
//          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCustomedPlace(),
              ),
            );
          },
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: blueColor,
        ),

//          body: ListView.builder(
//            itemCount: 10,
//            scrollDirection: Axis.vertical,
//            itemBuilder: (context, index){
//              return Card(
//                child: ListTile(
//                  onTap: (){},
//                  title: Text('aa'),
//                  leading: Icon(
//                    MdiIcons.map,
//                  ),
//                ),
//              );
//            },
//          ),

      ),

    );
  }
}