import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/models/favorites_model.dart';
import 'package:my_test_shop/models/home_model.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! HomeLoadingFavorites,
          builder: (context) => productsBuilder(
            HomeCubit.get(context).favoritesModel,
            context,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(FavoritesModel model, BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.grey[300],
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 1 / 1.48,
        physics: BouncingScrollPhysics(),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 2,
        children: List.generate(
            model.data.data.length,
            (index) =>
                gridItemBuilder(model.data.data[index].product, context)),
      ),
    );
  }

  Widget gridItemBuilder(Product model, context) {
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
}
