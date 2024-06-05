// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class FormHeader extends StatelessWidget {
//   const FormHeader({super.key,
//   this.imageColor,
//   this.heightBetween,
//   required this.image,
//   required this.title,
//   required this.subtital,
//   this.imageHeight=0.2,
//   this.crossAxisAlignment=CrossAxisAlignment.start,
  
//   });
//   final Color? imageColor;
//   final double imageHeight;
//   final double? heightBetween;
//   final String image,title,subtital;
//   final CrossAxisAlignment crossAxisAlignment;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: crossAxisAlignment,
//       children: [
//         Image(image: AssetImage(image),color: imageColor,height:imageHeight,)
//         ,Text(title,style: Theme.of(context).textTheme.headline1,),
//         Text(subtital,style: Theme.of(context).textTheme.bodyText1,)
//       ],
//     );
//   }
// }