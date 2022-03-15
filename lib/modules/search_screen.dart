import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/models/search_model.dart';
import 'package:my_test_shop/shared/components/custom_textfield.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_cubit.dart';
import 'package:my_test_shop/shared/cubit/search_cubit/search_cubit.dart';
import 'package:my_test_shop/shared/cubit/search_cubit/search_srates.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Searchcubit(),
      child: BlocConsumer<Searchcubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon:
                          Icon(Icons.search, color: Colors.lightBlueAccent),
                      filled: true,
                      fillColor: Colors.grey[350],
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey[350])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey[350])),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey[350])),
                    ),
                    onChanged: (String text) {
                      Searchcubit.get(context).search(text: text);
                      
                    },
                  ),
                ),
                if(state is SearchSuccessState)
                Expanded(child: productsBuilder(Searchcubit.get(context).searchModel,context))
              ],
            ),
          );
        },
      ),
    );
  }
   Widget productsBuilder(
      SearchModel model,context) {
    return Container(
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
                gridItemBuilder(model.data.data[index],context)),
      ),
    );
  }

  Widget gridItemBuilder(Product model,BuildContext context) {
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
              // if (model.discount != 0)
              //   Container(
              //     color: Colors.red,
              //     child: Text(
              //       '  DISCOUNT  ',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   )
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
                    // if (model.discount != 0)
                    //   Text(
                    //     '${model.oldPrice}',
                    //     style: TextStyle(
                    //         color: Colors.grey,
                    //         fontSize: 13,
                    //         decoration: TextDecoration.lineThrough),
                    //   ),
                    Spacer(),
                    // IconButton(
                    //     onPressed: () {
                    //       HomeCubit.get(context).changeFavorites(model.id);
                    //     },
                    //     icon: CircleAvatar(
                    //         radius: 15,
                    //         backgroundColor:
                    //             HomeCubit.get(context).favorites[model.id]
                    //                 ? Colors.blue
                    //                 : Colors.grey,
                    //         child: Icon(
                    //           Icons.favorite_outline_sharp,
                    //           size: 16,
                    //           color: Colors.white,
                    //         )))
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
