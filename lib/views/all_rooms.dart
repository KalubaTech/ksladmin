import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kasama_towers_admin/models/room_model.dart';

class AllRooms extends StatelessWidget {
  const AllRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Rooms'),
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
            builder: (c,s){
              if (s.hasData && s.data!.docs.isNotEmpty) {

                return ListView.builder(
                  itemCount: s.data!.docs.length,
                  itemBuilder: (c,i){
                    var room = RoomModel(name: s.data!.docs[i].get('name'), price: s.data!.docs[i].get('price'), id: s.data!.docs[i].id, amenities: s.data!.docs[i].get('amenities'));

                    return ListTile(
                      onTap: (){
                        
                      },
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                          borderRadius: BorderRadius.circular(6)
                        ),
                      ),
                      title: Text(room.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      subtitle: Text("ZMK ${room.price}", style: TextStyle(fontSize: 12, color: Colors.grey),),
                      trailing: InkWell(
                        onTap: (){
                          FirebaseFirestore.instance.collection('rooms').doc(room.id).delete();
                        },
                        child: Icon(Icons.delete_outline, color: Colors.red,),
                      ),
                    );
                  }
              );
              } else {
                return Container();
              }}
        ),
      ),
    );
  }
}
