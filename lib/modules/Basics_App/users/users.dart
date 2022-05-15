import 'package:flutter/material.dart';
import 'package:gps_tracker/models/user/user_moel.dart';


class User_Screan extends StatelessWidget {
  List<Usermodel> user =[
    Usermodel(id: 1 ,name: "Mohamed hany" , Phone: "01029187667"),
    Usermodel(id: 2 ,name: "ahmed hany" , Phone: "01029187667"),
    Usermodel(id: 3 ,name: "hello hany" , Phone: "01029187667"),
    Usermodel(id: 4 ,name: "Mahmoud hany" , Phone: "01029187667"),
    Usermodel(id: 5 ,name: "Mohamed hany" , Phone: "01029187667"),
    Usermodel(id: 6 ,name: "Mohamed hany" , Phone: "01029187667"),
    Usermodel(id: 7 ,name: "Mohamed hany" , Phone: "01029187667"),
    Usermodel(id: 8 ,name: "Mohamed hany" , Phone: "01029187667"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.separated(itemBuilder:(context, index) =>  UserItem(user[index]),
          separatorBuilder:(context, index) =>  Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[400],
            ),
          ), itemCount: user.length) ,
    );
  }

  Widget UserItem(Usermodel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Text('${model.id}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            Text('${model.Phone}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.grey[400]),),
          ],
        )
      ],
    ),
  );
}
