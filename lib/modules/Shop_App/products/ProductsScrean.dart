import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/cubit.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/states.dart';
import 'package:gps_tracker/models/Shop_App/cateogries_model.dart';
import 'package:gps_tracker/models/Shop_App/home_model.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/styles/colors.dart';

class ProductsScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSucssesChangeFavoritesState){
            if(state.model?.status == false){
              showToast(text: state.model?.message??'', state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return BuildCondition(
            condition: cubit.homeModel != null &&
                ShopCubit.get(context).cateogriesmodel != null,
            builder: (context) => productsBuilder(
                cubit.homeModel, ShopCubit.get(context).cateogriesmodel,context),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget productsBuilder(HomeModel? model, CateogriesModel? cateogriemodel,context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model?.data?.banners
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: NetworkImage('${e.image}'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  height: 240.0,
                  initialPage: 0,
                  reverse: false,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cateogries',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 120,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCateogriesItem(
                            cateogriemodel?.data?.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        itemCount: cateogriemodel?.data?.data.length ?? 0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[400],
                    ),
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsetsDirectional.only(top: 3),
              color: Colors.grey[200],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                childAspectRatio: 1 / 1.58,
                children: List.generate(model?.data?.products.length ?? 0,
                    (index) => BuildGridProduct(model?.data?.products[index],context)),
              ),
            )
          ],
        ),
      );

  Widget buildCateogriesItem(DataModel? model) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${model?.image}'),
              height: 120,
              width: 150,
              fit: BoxFit.cover,
            ),
            Container(
              width: 150,
              color: Colors.black.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '${model?.name}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )
          ],
        ),
      );

  Widget BuildGridProduct(productModel? model,context) => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model?.image}'),
                    width: double.infinity,
                    height: 200,
                  ),
                  if (model?.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model?.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model?.price.round()}',
                          style: TextStyle(fontSize: 12, color: DefultColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model?.discount != 0)
                          Text(
                            '${model?.oldPrice.round()}',
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
                                backgroundColor: ShopCubit.get(context).favorits[model?.id]! ? DefultColor :Colors.grey,
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
}
