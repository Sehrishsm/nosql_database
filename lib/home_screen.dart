import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive DataBase'),
      ),
      body: Column(
        children: [
FutureBuilder(
  future: Hive.openBox('sm'),
    builder: (context, snapshot){
      return Column(
        children: [
          ListTile(
            title: Text(snapshot.data!.get('name').toString()),
            subtitle:Text(snapshot.data!.get('age').toString()) ,
            trailing: IconButton(onPressed: (){
           // snapshot.data!.put('name', 'kilo');
           // snapshot.data!.put('age', '50');
              snapshot.data!.delete('name');

           setState(() {

           });
            },
            icon: Icon(Icons.delete),),
          )
          // Text(snapshot.data!.get('name').toString()),
          // Text(snapshot.data!.get('age').toString()),
          // Text(snapshot.data!.get('details').toString()),
        ],
      );
    }
),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{

            var box = await Hive.openBox('Sm');
            box.put('name', 'sm graphics');
            box.put('age', 25);
            box.put('details', {
            'pro': 'developer',
              'cash':'asdff'
            });
            print(box.get('name'));
            print(box.get('age'));
            print(box.get('details'));
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
