import 'package:Yalla_Food/shared/style/style.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import '../model/onBoardModel.dart';

Widget defaultButton(context,
        {required double width,
        required Color color,
        required Color textColor,
        required void Function()? function,
        required String text}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.0)),
        width: width,
        child: MaterialButton(
          height: MediaQuery.of(context).size.height / 17,
          splashColor: Colors.white,
          color: color,
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: boldText, color: textColor, fontSize: mediumText),
          ),
        ),
      ),
    );

Widget cardButton(context,
        {required double width,
        required Color color,
        required void Function()? function,
        required String text}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.0)),
        width: width,
        child: MaterialButton(
          height: MediaQuery.of(context).size.height / 17,
          splashColor: Colors.white,
          elevation: 0.0,
          color: color,
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: boldText,
                color: Colors.white,
                fontSize: mediumText),
          ),
        ),
      ),
    );

Widget buildGridProduct(context,
    {required imageUrl,
    required name,
    required price,
    required descreption,
    required function}) {
  return Container(
    padding: const EdgeInsets.only(left: 5, right: 5),
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
    child: InkWell(
      onTap: function,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: shimmerImage(imageUrl: imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$name',
                  maxLines: 2,
                  textAlign: my_textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$descreption',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$price',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget MySheetContainer(
  context, {
  required double height,
  required String image,
  required price,
  required String title,
  required void Function() function,
  String? description,
  String? cardText,
}) =>
    Container(
      color: cardColor,
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(
        20.0,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 400, child: Image(image: NetworkImage(image))),
            Text(
              title,
              textAlign: my_textAlign,
              style: TextStyle(fontSize: maxText, fontWeight: boldText),
            ),
            Text(
              description!,
              textAlign: my_textAlign,
              style: TextStyle(fontSize: mediumText),
            ),
            Row(
              children: [
                Text(
                  "Price:",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  "\$ $price",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: mediumText,
                      fontWeight: boldText),
                ),
              ],
            ),
            cardButton(context,
                width: cardButtonWidth,
                color: cardButtonColor,
                function: function,
                text: cardText.toString())
          ],
        ),
      ),
    );

Widget defaultFormField(context,
        {required TextEditingController? controller,
        required String text,
        TextInputType? type,
        Function(String)? onSubmit,
        Widget? prefix,
        required String hintText,
        required String? Function(String?) validator}) =>
    TextFormField(
      textDirection: TextDirection.rtl,
      onFieldSubmitted: onSubmit,
      keyboardType: type,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        hintText: hintText,
        hintTextDirection: TextDirection.rtl,
        prefix: prefix,
        label: Container(
            width: double.infinity,
            child: Text(
              text,
              style: const TextStyle(color: Colors.black),
              textDirection: TextDirection.rtl,
            )),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.black),
            borderRadius: BorderRadius.circular(30)),
        errorStyle: const TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Theme.of(context).errorColor),
            borderRadius: BorderRadius.circular(30)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Theme.of(context).errorColor),
            borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: mainColor),
            borderRadius: BorderRadius.circular(30)),
      ),
    );

Widget detailsText({
  required String text,
  required TextStyle? style,
}) =>
    Text(
      text,
      style: style,
      textDirection: TextDirection.rtl,
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

Widget dafaultTextButton({
  required void Function()? function,
  required String text,
}) =>
    TextButton(onPressed: function, child: Text("$text"));

Widget onBoardBuilder(OnBoardModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(fit: BoxFit.cover, image: AssetImage('${model.image}')),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "${model.title}",
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "${model.body}",
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
      ],
    );

Widget buildFavItem(
        {required String image,
        required String? name,
        required String? price,
        required void Function()? function}) =>
    InkWell(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(image),
                width: 120,
                height: 120,
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.2),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          price!,
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 15,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border,
                              size: 14,
                            ),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

Widget shimmerImage({required imageUrl}) => CachedNetworkImage(
      width: double.infinity,
      fit: BoxFit.fitWidth,
      imageUrl: imageUrl,
      placeholder: (context, url) => Shimmer.fromColors(
          period: Duration(milliseconds: 1500),
          child: Container(
            color: Colors.grey,
            height: 100,
            width: double.infinity,
          ),
          baseColor: HexColor('242222'),
          highlightColor: Colors.grey),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
