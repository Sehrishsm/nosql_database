import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nosql_database/model/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes/boxes.dart';
class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Database'),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _){
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
                itemBuilder: (context, index){
                  return Container(
                    height: 100,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(data[index].title.toString(), style: TextStyle(fontSize:20,fontWeight: FontWeight.w500),),
                                Spacer(),
                                InkWell(
                                    onTap: (){
                                          delete(data[index]);
                                    },
                                    child: Icon(Icons.delete, color: Colors.red,)),
                               SizedBox(width: 15,),
                                InkWell(
                                    onTap: (){
                                      _editDialog(data[index], data[index].title.toString(), data[index].description.toString());
                                    },
                                    child: Icon(Icons.edit)),
                              ],
                            ),

                            Text(data[index].description.toString(), style: TextStyle(fontSize:18,fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          _showMyDialogue();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotesModel notesModel)async{
    await notesModel.delete();
  }

  Future<void> _editDialog(NotesModel notesModel,String title, String description)async{
    titleController.text = title;
    descriptionController.text = description;
    
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Edit notes'),
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
              TextButton(onPressed: ()async{
          notesModel.title= titleController.text.toString();
          notesModel.description= descriptionController.text.toString();

            await notesModel.save();

            titleController.clear();
            descriptionController.clear();

                Navigator.pop(context);
              }, child: Text('Edit')),
            ],
          );
        }
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

                // data.save();
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
