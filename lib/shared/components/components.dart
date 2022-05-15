import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/cubit.dart';
import 'package:gps_tracker/modules/News_App/web_view/web_view.dart';
import 'package:gps_tracker/shared/Cubit/cubit.dart';
import 'package:gps_tracker/shared/styles/colors.dart';
import 'package:gps_tracker/shared/styles/icon_broken.dart';

Widget defultButton({
  double width = double.infinity,
  Color Background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required String text,
  required VoidCallback function,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Background,
      ),
    );

PreferredSizeWidget defultAppBar ({required BuildContext context , String? title , List<Widget>? actions})=>  AppBar(
  title: Text(title!),
  actions: actions,
  titleSpacing: 5.0,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon:Icon( IconBroken.Arrow___Left_2),

  ),

);

Widget defultFormField ({
 required TextInputType type,
 required TextEditingController controller,
 required String label,
 required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  required String? Function(String? val)? validator,
   void Function(String val)? onChanged,
  VoidCallback? passwordShow,
  VoidCallback? onTap,
  void Function (String)? onSubmeted,


})=> TextFormField(
  onTap: onTap,
  onFieldSubmitted: onSubmeted,
  onChanged: onChanged,
  obscureText: isPassword,
  validator: validator,
  keyboardType: type,
  controller: controller,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    border: OutlineInputBorder(),
    suffixIcon:  suffix != null ? IconButton(icon: Icon(suffix) , onPressed: passwordShow,) : null,




  ),

);



//////////////////////////////////////facebook Screan

Widget defultIcon (
{
  required IconData icon,
  Color? color = Colors.blue ,
}
    )=>Icon(
  icon,
  size: 40,
  color: color,
);

Widget defultTextButtton({
  required String text,
  required void  Function()? function
}) => TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget BuildTaskItem({required Map model , context}) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text('${model['time']}'),

        ),

        SizedBox(width: 20,),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                    fontSize: 20,

                    fontWeight: FontWeight.bold

                ),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                    color: Colors.grey

                ),

              )

            ],

          ),

        ),

        SizedBox(width: 20,),

        IconButton(onPressed: (){

          AppCubit.get(context).UpdateData(

              status: 'done',

              id: model['id']

          );

        },

            icon: Icon(Icons.check_box),

          color: Colors.green,

        ),

        IconButton(onPressed: (){

          AppCubit.get(context).UpdateData(

              status: 'archive',

              id: model['id']

          );

        },

            icon: Icon(Icons.archive),

          color: Colors.black45,

        ),

      ],

    ),

  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget taskBuilder({
  required List<Map> tasks,
  required String text,
})=>  tasks.length> 0 ? ListView.separated(
    itemBuilder:(context, index) => BuildTaskItem(
        model: tasks[index],
        context: context
    ) ,
    separatorBuilder: (context, index) => myDivider(),
    itemCount:tasks.length
)  : Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.menu,
        size: 100,
        color: Colors.grey,
      ),
      Text(text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,

        ),
      )
    ],
  ),
);

Widget myDivider()=> Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[400],
  ),
);

Widget BuildArticaleItem(articale , context)=>  InkWell(
  onTap: (){
    navigateTo(context, web_view(
      url: articale['url'],
    ));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(



      children: [

        Container(

          width: 130.0,

          height: 130.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              image: DecorationImage(

                  image: NetworkImage('${articale['urlToImage']}'),

                  fit: BoxFit.cover

              )

          ),

        ),

        SizedBox(width: 20,),

        Expanded(

          child: Container(

            height: 130,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${articale['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines:4,

                    overflow: TextOverflow.ellipsis,



                  ),

                ),



                Text('${articale['publishedAt']}',

                  style: TextStyle(



                      color: Colors.grey

                  ),),

              ],

            ),

          ),

        )



      ],

    ),

  ),
);
Widget articaleBuilder(list, context,{isSearch = false})=> list.length > 0
    ? ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder:(context, index) {
      return BuildArticaleItem(list[index] , context);
    } ,
    separatorBuilder: (context, index) => myDivider(),

    itemCount: list.length,
) :   Center(child:  CircularProgressIndicator(),);

void navigateTo(context , widget)=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ));

void navigateToAndFinish(context , widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    ),
    (route)=> false
);

void showToast({
  required String text,
  required ToastStates state
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCSSES ,ERROR, WARNING}

Color chooseToastColor(ToastStates state){
 late Color color;
 switch(state){
   case ToastStates.SUCSSES:
     color = Colors.green;
         break;
         case ToastStates.ERROR:
     color = Colors.red;
         break;
         case ToastStates.WARNING:
     color = Colors.yellow;
         break;
 }

  return color;
}


Widget BuildListProduct( model,context,{bool isOldPrice =true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    color: Colors.white,
    child: Row(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model?.image}'),
                width:120,
                height: 120,
              ),
              if (model?.discount != 0 && isOldPrice)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                )
            ],
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model?.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.3),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model?.price}',
                    style: TextStyle(fontSize: 12, color: DefultColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model?.discount != 0 && isOldPrice)
                    Text(
                      '${model?.oldPrice}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        ShopCubit.get(context).ChangeFavorites(model?.id??0);
                      },
                      icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          ShopCubit.get(context).favorits[model?.id]!
                              ? DefultColor :Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 16,
                            color: Colors.white,
                          )))
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);