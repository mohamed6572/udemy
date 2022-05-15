import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gps_tracker/models/user/facebook_.dart';
import 'package:gps_tracker/shared/components/components.dart';

class Facebook extends StatelessWidget {

  List<Facebook_model> facceI =[
    Facebook_model(name: 'ريلز', icon: Icons.ondemand_video_outlined),
    Facebook_model(name: 'غرفة', icon: Icons.video_call),
    Facebook_model(name: 'مجموعة', icon: Icons.person),
    Facebook_model(name: 'بث مباشر', icon: Icons.video_call),
  ];
  List<Stroy> story=[
    Stroy(image: 'assets/me.jpeg', imageName: 'assets/me.jpeg'),
    Stroy(image: 'assets/me.jpeg', imageName: 'assets/me.jpeg'),
    Stroy(image: 'assets/me.jpeg', imageName: 'assets/me.jpeg'),
    Stroy(image: 'assets/me.jpeg', imageName: 'assets/me.jpeg'),
    Stroy(image: 'assets/me.jpeg', imageName: 'assets/me.jpeg'),
    Stroy(image: 'assets/me.jpeg', imageName: 'assets/me.jpeg'),
  ];



  List<Widget> iconwidg =[
    defultIcon(
    icon:Icons.circle,
    ),
    defultIcon(
      icon:Icons.circle,
    ),
    defultIcon(
      icon:Icons.circle,
    ),
    defultIcon(
      icon:Icons.circle,
    ),
    defultIcon(
      icon:Icons.circle,
    ),
    defultIcon(
      icon:Icons.circle,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'faceBook',
                style: TextStyle(fontSize: 28),
              ),
            )
          ],
          title: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey,
              ),
              SizedBox(
                width: 9,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey,
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(

            children: [
              Container(
                height: 100,
                child:ListView.separated(

                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,

                    itemBuilder: (context, index) => iconwidg[index],
                    separatorBuilder: (context, index) =>  SizedBox(
                      width: 29,
                    ),
                    itemCount: iconwidg.length) ,
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  defultIcon(
                    icon:Icons.photo,
                  ),
                  Expanded(

                    child: TextField(
                        decoration: InputDecoration(
                          suffix: Text('بم تفكر',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(25),
                                  left: Radius.circular(25)
                              )
                          ),

                        )),
                  ),
                  defultIcon(
                    icon:Icons.person,
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey[300],
                child: ListView.separated(
                  shrinkWrap: true,
                    scrollDirection:Axis.horizontal ,
                    physics:NeverScrollableScrollPhysics() ,
                    itemBuilder:(context, index) => FaceStyle(facceI[index]) ,
                    separatorBuilder: (context, index) => SizedBox(width: 25,),
                    itemCount: facceI.length),
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 10,
              ),
              Row(
              

                children: [
                  Expanded(
                    child: Container(
                    height:180,
                    width: 120,
                    child: ListView.separated(

                      shrinkWrap: true ,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:(context, index) => defultStroy(story[index]) ,
                        separatorBuilder:(context, index) => SizedBox(width: 8,)
                        , itemCount: story.length),
                ),
                  ),]
              ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => defultPost(),
                    separatorBuilder: (context, index) => SizedBox(height: 10,) ,
                    itemCount: 30
                ),
            ],
          ),
        ));
  }

  Widget FaceStyle(Facebook_model model){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Row(
          children: [
            Text(model.name),
            Icon(model.icon)
          ],
        ),

      ),
    );
  }
  Widget defultStroy(Stroy stroy1) => Container(

    width: 120,
    height: 190,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: Colors.grey[200],
    ),
    child: Column(
      children: [
        Stack(


          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image(image:AssetImage( stroy1.image),
                
                height: 180,
                width: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
               start: 50,
                top: 10
              ),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 30,
                child:  CircleAvatar(

                  radius: 25,
                  backgroundImage: AssetImage( stroy1.imageName) ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 130,
                bottom: 2,
                start: 10
              ),
              child: Text('mohamed hany',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue
              ),
              maxLines: 2,),
            )



          ],

        ),
        

      ],
    ),
  );
  Widget defultPost() =>Container(
    height: 300,
    padding: EdgeInsets.all(20),
    color: Colors.blue,
    child: Column(
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.end,
          children: [
            Icon(Icons.close),
            SizedBox(
              width: 10,
            ),

            Icon(Icons.menu_outlined),
            Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Text('Flutter بالعربي'),
                Row(

                  children: [
                    Text('osama Anwar'),
                    SizedBox(
                      width: 9,
                    ),
                    Text('الان '),
                    SizedBox(
                      width: 9,
                    ),
                    Icon(Icons.format_indent_decrease),

                  ],
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),

            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                      'assets/me.jpeg'),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      end:30 ,
                      top: 3
                  ),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(
                        'assets/me.jpeg'),

                  ),
                )
              ],
            ),

          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(child: Text(
          "JIT compilation, combined with the DVM (JIT + VM in the picture), allows the dispatchof the code dynamically without considering the user’s machine architecture. In this wayit’s possible to smoothly run and debug the code everywhere without having to mess upwith the underlying architectur",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white
          ),
          maxLines: 8,
          overflow: TextOverflow.ellipsis,
        )
        )

      ],
    ),

  );
}

