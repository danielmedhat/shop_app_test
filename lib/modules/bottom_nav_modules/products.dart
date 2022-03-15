import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/models/categories_model.dart';
import 'package:my_test_shop/models/home_model.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_states.dart';

class ProductsScreen extends StatelessWidget {
  // const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
              HomeCubit.get(context).homeModel,
              HomeCubit.get(context).categoriesModel,
              context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
      HomeModel model, CategoriesModel cat, BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model.data.banners.map((e) {
                return Image(
                  image: NetworkImage('${e.image}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  viewportFraction: 1.0,
                  autoPlayInterval: Duration(seconds: 3))),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 130,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  radius: 50,
                                  child: Image(
                                    image: NetworkImage(HomeCubit.get(context)
                                        .categoriesModel
                                        .data
                                        .data[index]
                                        .image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          HomeCubit.get(context)
                                              .categoriesModel
                                              .data
                                              .data[index]
                                              .name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: cat.data.data.length),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              childAspectRatio: 1 / 1.48,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 2,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      gridItemBuilder(model.data.products[index], context)),
            ),
          )
        ],
      ),
    );
  }

  Widget gridItemBuilder(ProductsModel model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image(
                  image: NetworkImage('${model.image}'),
                ),
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  child: Text(
                    '  DISCOUNT  ',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(color: Colors.blue, fontSize: 17),
                    ),
                    SizedBox(
                      width: 29,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          HomeCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                HomeCubit.get(context).favorites[model.id]
                                    ? Colors.blue
                                    : Colors.grey,
                            child: Icon(
                              Icons.favorite_outline_sharp,
                              size: 16,
                              color: Colors.white,
                            )))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget productsBuilder(HomeModel model) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         CarouselSlider(
  //             items: model.data.banners
  //                 .map((e) => Image(
  //                       image: NetworkImage('${e.image}'),
  //                       fit: BoxFit.cover,
  //                     ))
  //                 .toList(),
  //             options: CarouselOptions(
  //                 autoPlay: true,
  //                 autoPlayAnimationDuration: Duration(seconds: 1),
  //                 autoPlayCurve: Curves.fastLinearToSlowEaseIn,
  //                 viewportFraction: 1.0,
  //                 autoPlayInterval: Duration(seconds: 3))),
  //                 Container(
  //                   color: Colors.grey[300],
  //                   child: GridView.count(childAspectRatio: 1/1.4,crossAxisCount: 2,
  //                   mainAxisSpacing: 5,
  //                   crossAxisSpacing: 5,
  //                shrinkWrap: true,
  //                   physics: NeverScrollableScrollPhysics(),
  //                   children: List.generate(model.data.products.length, (index) => productGridItem(model.data.products[index]))),
  //                 )
  //       ],
  //     ),
  //   );
  // }

  // Widget productGridItem(ProductsModel model) {
  //   return Container(
  //     color: Colors.white,
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: Column(
  //             children: [
  //               Stack(
  //                 alignment:AlignmentDirectional.bottomStart,
  //                 children: [
  //                   Container(

  //                     width: 200,
  //                     height: 200,
  //                     child: Image(image: NetworkImage('${model.image}'),),
  //                   ),Padding(
  //                     padding:  EdgeInsets.symmetric(vertical: 7),
  //                     child: Container(padding: EdgeInsets.symmetric(horizontal: 5),
  //                       color:Colors.red,child: Text('DISCOUNT',style: TextStyle(color: Colors.white,),)),
  //                   )
  //                 ],
  //               ),
  //               Text('${model.name}',style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //               ),
  //               maxLines: 2,
  //               overflow:TextOverflow.ellipsis
  //               ),
  //               Padding(
  //                 padding:  EdgeInsets.symmetric(vertical: 5),
  //                 child: Row(
  //                   children: [
  //                     Text('${model.price}',style: TextStyle(
  //                       color: Colors.blue
  //                     ),),
  //                     SizedBox(
  //                       width:23
  //                     ),
  //                     Text('${model.oldPrice}',style: TextStyle(color:Colors.grey,
  //                       decoration: TextDecoration.lineThrough

  //                     ),),

  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget productsBuilder(HomeModel model) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         CarouselSlider(
  //             items: model.data.banners
  //                 .map((e) => Image(
  //                       image: NetworkImage('${e.image}'),
  //                       fit: BoxFit.cover,
  //                       width: double.infinity,
  //                     ))
  //                 .toList(),
  //             options: CarouselOptions(
  //                 autoPlay: true,
  //                 autoPlayInterval: Duration(seconds: 3),
  //                 viewportFraction: 1.0,
  //                 autoPlayAnimationDuration: Duration(seconds: 1),
  //                 autoPlayCurve: Curves.fastLinearToSlowEaseIn)),
  //         Container(
  //           color: Colors.grey[300],
  //           child: GridView.count(
  //             crossAxisSpacing: 5,
  //             mainAxisSpacing: 5,
  //             childAspectRatio: 1/1.85,
  //             physics: NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             crossAxisCount: 2,
  //             children: List.generate(model.data.products.length,
  //                 (index) => gridItem(model.data.products[index])),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget gridItem(ProductsModel model) {
  //   return  Stack(
  //     alignment: AlignmentDirectional.topEnd,
  //     children: [
  //       Container(
  //         color: Colors.white,
  //         child: Column(
  //           children: [
  //              Stack(
  //                alignment: AlignmentDirectional.bottomStart,
  //                children: [

  //                  Image(image: NetworkImage(model.image),width:double.infinity,height: 320,),
  //                  if(model.discount!=0)
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(vertical: 9.0),
  //                     child: Container(color: Colors.green
  //                  ,padding: EdgeInsets.symmetric(horizontal: 5),
  //                  child: Text('DISCOUNT',style: TextStyle(
  //                      color: Colors.white
  //                  ),),
  //                  ),
  //                   ),
  //                ],
  //              ),
  //              Padding(
  //                padding: const EdgeInsets.symmetric(horizontal: 6),
  //                child: Column(
  //                  children: [
  //                    Text(model.name,style: TextStyle(

  //                    ),maxLines: 2,overflow: TextOverflow.ellipsis,),
  //                    Row(
  //                      children: [
  //                        Text('${model.price}',style: TextStyle(fontSize: 17,
  //                          color: Colors.blue
  //                        ),),
  //                       SizedBox(width: 10,),
  //                       if(model.discount!=0)
  //                        Text('${model.oldPrice}',style: TextStyle(fontSize: 13,
  //                          color: Colors.grey,decoration: TextDecoration.lineThrough
  //                        ),),
  //                      ],
  //                    )
  //                  ],
  //                ),
  //              )
  //           ],
  //         ),
  //       ),IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline_outlined))
  //     ],
  //   );
  // }
}
