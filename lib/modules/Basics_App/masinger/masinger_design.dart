import 'package:flutter/material.dart';

class masinger_design extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/a-/AOh14Gguw-Kru-ywdbqRVlnblTB7CBqPs-McAKKzj-ynQA=s432-p-rw-no'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Chat',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 16,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 17,
                  ))),
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 16,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 17,
                  ))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Text('Search'),

                  ],
                ),
              ),
              SizedBox(height: 10,),
            Container(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 10,),
                itemBuilder: (context, index) => buildStoryItem(),
                itemCount: 8,
              ),
            ),
              SizedBox(height: 20,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                // shrinkwrap علشان تبلد الايتم كلو مره واحده
                itemBuilder: (context, index) => buildchatItem(),
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: 15
                ,),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildchatItem()=>  Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/a-/AOh14Gguw-Kru-ywdbqRVlnblTB7CBqPs-McAKKzj-ynQA=s432-p-rw-no'),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                bottom: 3,
                end: 3
            ),
            child: CircleAvatar(
              radius: 7,
              backgroundColor: Colors.red,
            ),
          )
        ],
      ),
      SizedBox(width: 10,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mohamed hany  ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: Text
                    ('hello my name is mohamed hany welcome in',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(7)
                    ),
                  ),
                ),
                Text('2:00 pm')
              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget buildStoryItem()=>  Container(
    width: 60,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/a-/AOh14Gguw-Kru-ywdbqRVlnblTB7CBqPs-McAKKzj-ynQA=s432-p-rw-no'),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  bottom: 3,
                  end: 3
              ),
              child: CircleAvatar(
                radius: 7,
                backgroundColor: Colors.red,
              ),
            )
          ],
        ),
        SizedBox(height: 5,),
        Text('mohamed hany abdelraof',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ),
  );
}
