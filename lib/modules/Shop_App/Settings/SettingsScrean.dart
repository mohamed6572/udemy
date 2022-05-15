import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/cubit.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/states.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/components/constens.dart';

class SettingsScrean extends StatelessWidget{
 var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model?.data?.name??'';
        emailController.text = model?.data?.email??'';
        phoneController.text = model?.data?.phone??'';



        return  BuildCondition(
          condition: ShopCubit.get(context).userModel != null,
          builder:(context) =>  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(70),
                  //   child: Image(
                  //     width: 150,
                  //     height: 150,
                  //     image: NetworkImage(
                  //       'https://lh3.googleusercontent.com/a-/AOh14Gguw-Kru-ywdbqRVlnblTB7CBqPs-McAKKzj-ynQA=s432-p-rw-no'
                  //      //model?.data?.image.toString()??'',
                  //      // '${model?.data?.image}'
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20,),
                  if(state is ShopLoadingUpdateProfileState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defultFormField(
                      type: TextInputType.name,
                      controller: nameController,
                      label: 'name',
                      prefix: Icons.person,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'name must not be impty';
                        }
                      }
                  ),
                  SizedBox(height: 20,),
                  defultFormField(
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      label: 'email',
                      prefix: Icons.email,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'email must not be impty';
                        }
                      }
                  ),
                  SizedBox(height: 20,),
                  defultFormField(
                      type: TextInputType.phone,
                      controller: phoneController,
                      label: 'phone',
                      prefix: Icons.phone,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'phone must not be impty';
                        }
                      }
                  ),
                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Text(' your Points : ${model?.data?.points}'),
                      Spacer(),
                      Text(' your Credit : ${model?.data?.credit}'),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defultButton(text: 'Logout',
                        radius: 20,
                        width: MediaQuery.of(context).size.width*0.4,
                        Background: Colors.red,
                        function: (){
                          SignOut(context);
                        },),
                     SizedBox(width: 10,),
                      defultButton(text: 'Update',
                          radius: 20,
                          width: MediaQuery.of(context).size.width*0.4,
                        Background: Colors.blue,
                        function: (){
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).updateProfile
                            (
                              name: nameController.text,
                              email:emailController.text ,
                              phone:phoneController.text,
                          );
                        }

                        })

                    ],
                  ),


                ],
              ),
            ),
          ),
          fallback:(context) =>  Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}
