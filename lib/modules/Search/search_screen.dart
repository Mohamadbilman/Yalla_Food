import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../abdulrahman/class/appLink.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component.dart';
import '../restaurants/dishes_details.dart';

class search extends StatelessWidget {
  search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Yalla_Food_Cubit, Yalla_Food_States>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController searchController = TextEditingController();
        GlobalKey<FormState> formKey = GlobalKey<FormState>();
        Yalla_Food_Cubit cubit = Yalla_Food_Cubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                defaultFormField(
                  context,
                  onSubmit: (String text) {
                    cubit.getDataSearch(searchController.text);
                  },
                  type: TextInputType.text,
                  controller: searchController,
                  hintText: 'Search',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Search';
                    }
                  },
                  prefix: Icon(Icons.search),
                  text: 'Search',
                ),
                SizedBox(
                  height: 10,
                ),
                if (state is SearchLoadingState) LinearProgressIndicator(),
                SizedBox(
                  height: 26,
                ),
                if (state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final search = cubit.searchfood[index];
                        return buildFavItem(
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => dishe_details(
                                      bigPrice: search.foodPrice,
                                      image: "${search.foodImage}",
                                      price: search.foodPrice,
                                      descreption: search.foodDes,
                                      name: search.foodName,
                                    ),
                                  ));
                            },
                            image: "${search.foodImage}",
                            name: search.foodName,
                            price: search.foodPrice);
                      },
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                          width: double.infinity,
                        ),
                      ),
                      itemCount: 5,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
