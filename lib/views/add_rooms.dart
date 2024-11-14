import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_collage/image_collage.dart';
import 'package:images_picker/images_picker.dart';
import 'package:kasama_towers_admin/components/kalubtn.dart';
import 'package:kasama_towers_admin/components/kalutext.dart';
import 'package:kasama_towers_admin/utils/colors.dart';
import 'package:get/get.dart';

import '../helpers/methods.dart';

class AddRooms extends StatefulWidget {
  AddRooms({super.key});

  @override
  State<AddRooms> createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {
  TextEditingController _menitiesController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  var amenities = [].obs;
  List<Media>images=[];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add room'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Images (${images.length})', style: TextStyle(fontSize: 16),),
                      Spacer(),
                      Kalubtn(
                        borderRadius: 30,
                        width: 50,
                          label: 'Add',
                          onclick: ()async{

                              List<Media>? res = await ImagesPicker.pick(
                                count: 3,
                                pickType: PickType.image,
                              );
                                // Media
                                // .path
                                // .thumbPath (path for video thumb)
                                // .size (kb)

                                setState(() {
                                  images.addAll(res!);
                                });
                            }

                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            Kalutext(
              controller: _nameController,
              border: Border.all(
                  color: Karas.primary
              ),
              labelText: 'Room Name',
            ),
            SizedBox(height: 10,),
            Kalutext(
              controller: _priceController,
              border: Border.all(
                  color: Karas.primary
              ),
              labelText: 'Price per night (ZMK)',
              isNumber: true,
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Karas.secondary),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Kalutext(
                    controller: _menitiesController,
                    border: Border.all(
                      color: Karas.primary
                    ),
                    labelText: 'Amenity',
                  ),
                  SizedBox(height: 10,),
                  Kalubtn(
                    width: 100,
                      backgroundColor: Karas.secondary,
                      borderRadius: 30,
                      label: 'Add',
                      onclick: (){
                        setState(() {
                          amenities.value.add(_menitiesController.text);
                          _menitiesController.clear();
                        });
                      },
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Obx(
                      ()=> Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${amenities.length} Added', style: TextStyle(fontSize: 11),),
                          SizedBox(height: 10,),
                          ...amenities.map((a)=>Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${a}'),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    amenities.removeWhere((e)=>e==a);
                                  });
                                },
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  )
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 60,),
            Kalubtn(
              height: 40,
                borderRadius: 40,
                label: 'Save Room',
                onclick: ()async{
                  Get.defaultDialog(
                    title: 'Uploading...',
                    titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    content: Container(
                    child: Center(
                      child: CircularProgressIndicator()),
                    ),

                  );
                  await Methods().uploadImageToFirebase(
                      images.map((img)=>img.path).toList(),
                      name: _nameController.text,
                      price: _menitiesController.text,
                      amenities: amenities.value
                  );

                  Get.back();
                  Get.back();
                }
            )
          ],
        ),
      ),
    );
  }
}
