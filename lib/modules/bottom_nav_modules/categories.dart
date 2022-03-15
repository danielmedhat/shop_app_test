import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categories=HomeCubit.get(context).categoriesModel.data.data;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          
          child: ListView.separated(physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=>Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: Image(image: NetworkImage(categories[index].image),),
                  ),SizedBox(
                    width: 30,
                  ),
                  Text(categories[index].name,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ), separatorBuilder:(context,index)=> Container(height: 1,color: Colors.grey,), itemCount: categories .length),
        );
        
      },
    );
  }
}
