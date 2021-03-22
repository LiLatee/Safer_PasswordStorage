// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
// import 'package:implicitly_animated_reorderable_list/transitions.dart';
//
// class AnimatedReorderableList extends StatefulWidget {
//   final List<Widget> items;
//
//   const AnimatedReorderableList({Key? key, required this.items})
//       : super(key: key);
//
//   @override
//   _AnimatedReorderableListState createState() =>
//       _AnimatedReorderableListState();
// }
//
// class _AnimatedReorderableListState extends State<AnimatedReorderableList> {
//   late List<Widget> items = widget.items;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   items = widget.items;
//   // }
//
//   Widget _buildBox(Widget item) {
//     // return Row(
//     //   children: [
//     //     Expanded(child: item),
//     //     Handle(
//     //       delay: Duration(milliseconds: 100),
//     //       child: item,
//     //     )
//     //   ],
//     // );
//     return item;
//     // return Handle(
//     //   delay: Duration(milliseconds: 100),
//     //   child: item,
//     // );
//   }
//
//   Widget buildReorderable(
//     Widget item,
//     Widget Function(Widget tile) transitionBuilder,
//   ) {
//     return Reorderable(
//       key: ValueKey(item),
//       builder: (context, dragAnimation, inDrag) {
//         // final t = dragAnimation.value;
//         final tile = _buildBox(item);
//
//         // If the item is in drag, only return the tile as the
//         // SizeFadeTransition would clip the shadow.
//         // if (t > 0.0) {
//         //   return tile;
//         // }
//
//         return transitionBuilder(
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               tile,
//               const Divider(height: 0),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   bool inReorder = false;
//
//   void onReorderFinished(List<Widget> newItems) {
//     setState(() {
//       inReorder = false;
//       widget.items
//         ..clear()
//         ..addAll(newItems);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ImplicitlyAnimatedReorderableList(
//         items: widget.items,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: 0),
//         areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
//         onReorderStarted: (item, index) => setState(() => inReorder = true),
//         onReorderFinished: (movedLanguage, from, to, List<Widget> newItems) {
//           // Update the underlying data when the item has been reordered!
//           onReorderFinished(newItems);
//         },
//         itemBuilder: (context, itemAnimation, item, index) {
//           log("itemBuilder", name: "LOL");
//           return buildReorderable(
//             item,
//             (tile) {
//               return SizeFadeTransition(
//                 sizeFraction: 0.7,
//                 curve: Curves.easeInOut,
//                 animation: itemAnimation,
//                 child: SizeTransition(
//                   sizeFactor: CurvedAnimation(
//                       parent: kAlwaysCompleteAnimation,
//                       curve: Curves.easeInOutBack,
//                       reverseCurve: Curves.easeInOutBack),
//                   child: tile,
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
