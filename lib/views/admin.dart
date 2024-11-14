import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasama_towers_admin/views/add_rooms.dart';
import 'package:kasama_towers_admin/views/all_rooms.dart';
import 'package:kasama_towers_admin/views/clients.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADMIN Dashboard', style: TextStyle(fontWeight: FontWeight.bold,),),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Get.to(()=>AddRooms());
              },
              trailing: Icon(Icons.add, color: Colors.green,),
              title: Text('Add Rooms'),
            ),
            ListTile(
              onTap: (){
                Get.to(()=>AllRooms());
              },
              trailing: Icon(Icons.room_service_sharp, color: Colors.deepOrange,),
              title: Text('All Rooms'),
            ),
            ListTile(
              onTap: (){
                Get.to(()=>Clients());
              },
              trailing: Icon(Icons.supervised_user_circle_sharp, color: Colors.blue,),
              title: Text('Clients'),
            ),
          ],
        ),
      ),
    );
  }
}
