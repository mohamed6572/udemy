

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Shop_App/shop_layout.dart';
import 'package:gps_tracker/modules/Shop_App/Register/cubit/Cubit.dart';
import 'package:gps_tracker/modules/Shop_App/Register/cubit/States.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/components/constens.dart';
import 'package:gps_tracker/shared/network/local/casheHelper.dart';

class ShopRegisterScrean extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSucseslState){
            if(state.registermodel.stutes){
              print(state.registermodel.message);
              print(state.registermodel.data?.token);
              casheHelper.SavaData(key: 'token', value: state.registermodel.data?.token).then((value) {
                token = state.registermodel.data?.token??'${state.registermodel.data?.token}';
                navigateToAndFinish(context, Shop_Layout());
              });
            }else {
              showToast(
                  text: state.registermodel.message!,
                  state: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register'.toUpperCase() ,
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers' ,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(height: 30,),
                        defultFormField(
                          type: TextInputType.name,
                          controller: nameController,
                          label: 'name',
                          prefix: Icons.person,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'name must not be empty';
                            }
                          },
                        ),
                        SizedBox(height: 15,),
                        defultFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email',
                          prefix: Icons.email_outlined,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Email must not be empty';
                            }
                          },
                        ),
                        SizedBox(height: 15,),
                        defultFormField(
                          type: TextInputType.phone,
                          controller: phoneController,
                          label: 'phone',
                          prefix: Icons.phone,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'phone must not be empty';
                            }
                          },
                        ),
                        SizedBox(height: 15,),

                        defultFormField(
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            label: 'Password',
                            suffix:ShopRegisterCubit.get(context).suffix,
                            isPassword: ShopRegisterCubit.get(context).isPassword,

                            passwordShow: (){
                              ShopRegisterCubit.get(context).ChangePasswordVisibilty();
                            },
                            prefix: Icons.lock_outline,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Password must not be empty';
                              }
                            }),
                        SizedBox(height: 30,),
                        BuildCondition(
                          condition: state is !ShopRegisterLodingState,
                          builder: (context) => defultButton(
                            text: 'Register',
                            isUpperCase: true,
                            function: (){
                              print( emailController.text);
                              print( passwordController.text);
                              print( phoneController.text);
                              if(formkey.currentState!.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text
                                );


                              }
                            },

                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(height: 15,),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
