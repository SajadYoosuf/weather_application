import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget dataContainer(BuildContext context,String title,String content,String image){
  return Container(
    height: 150,
    width: 100,
   decoration:BoxDecoration(borderRadius: BorderRadius.circular(22), color: Colors.blueGrey,),
    
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(image,width: 40,height: 40,color: Colors.white,),
                                     Text(title,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.white),),
                                    Text(content,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white))
                                  ],
                                ),
  );
}