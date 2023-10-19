import 'package:flutter/material.dart';
import 'package:nosql_database/model/notes_model.dart';

import 'boxes/boxes.dart';
class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Database'),
      ),
      body: Column(
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
 _showMyDialogue();
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> _showMyDialogue()async{
return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Add notes'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
          TextButton(onPressed: (){
            final data = NotesModel(title: titleController.text,
                description: descriptionController.text);

            final box = Boxes.getData();
            box.add(data);

            data.save();
          print(box);
            titleController.clear();
            descriptionController.clear();

            Navigator.pop(context);
          }, child: Text('Add')),
        ],
      );
    }
);

  }
}
