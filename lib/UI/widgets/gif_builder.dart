

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gifsearcher/UI/widgets/loading_widgets.dart';
import 'dart:async';

import 'package:gifsearcher/data/model/gif_model.dart';
import 'package:shimmer/shimmer.dart';

Widget gifGridBuilderWidget({
  required List<GifModel> gifList,
  required ScrollController controller,
  required bool loading,
  required BuildContext context
}){

  return Stack(
    children: [
      GridView.builder(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0,right: 8.0),
        controller: controller,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index){
          if(index < gifList.length){
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 50.0,
                width: 50.0,
                child: getImage(gifList[index].url,context),
              ),
            );
          }else{
            Timer(const Duration(milliseconds: 50), (){
              controller.jumpTo(controller.position.maxScrollExtent);
            });
            return const SizedBox();
          }
        },

        itemCount: gifList.length + (loading ? 2 : 0),
      ),
      loading ? loadingList(context) : SizedBox()
    ],
  );
}

Widget gifListBuilderWidget({
  required List<GifModel> gifList,
  required ScrollController controller,
  required bool loading,
  required BuildContext context
}){

  return ListView.builder(
    padding: const EdgeInsets.only(top: 8.0, left: 45.0,right: 45.0),
    controller: controller,
    itemBuilder: (context, index){
      if(index < gifList.length){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 150.0,
              width: 100.0,
              child: getImage(gifList[index].url,context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        );
      }else{
        Timer(const Duration(milliseconds: 50), (){
          controller.jumpTo(controller.position.maxScrollExtent);
        });
        return loadingWidget(context);
      }
    },
    itemCount: gifList.length + (loading ? 1 : 0),
  );
}

Widget getImage(String url, BuildContext context){
  try{
    return Image.network(
      url,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, imageEvent){
        if(imageEvent == null) return child;
        return SizedBox(
          height: 150.0,
          width: 100.0,
          child: Shimmer.fromColors(
            child: Container(
              height: 150.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.yellow
              ),
            ),
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white38,
            direction: ShimmerDirection.ltr,
            period: const Duration(milliseconds: 700),
          ),
        );
      },
      errorBuilder: (context, obj, st){
        return Placeholder();
      },
    );
  }catch(e){
    return loadingWidget(context);
  }
}
