// import 'package:flutter/material.dart';
// import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
// import 'package:implicitly_animated_reorderable_list/transitions.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
//       home: SimpleAnimatedList(),
//     );
//   }
// }
//
// class SimpleAnimatedList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var items = [
//       Container(
//         height: 100,
//         color: Colors.red,
//       ),
//       Container(
//         height: 100,
//         color: Colors.blue,
//       ),
//       Container(
//         height: 100,
//         color: Colors.yellow,
//       ),
//     ];
//
//     return Scaffold(
//       body: SliceAnimatedList(items: items),
//     );
//   }
// }
//
// class SliceAnimatedList extends StatefulWidget {
//   final List<Widget> items;
//
//   const SliceAnimatedList({Key? key, required this.items}) : super(key: key);
//   @override
//   _SliceAnimatedListState createState() => _SliceAnimatedListState();
// }
//
// class _SliceAnimatedListState extends State<SliceAnimatedList> {
//   late List<Widget> items;
//
//   @override
//   void initState() {
//     super.initState();
//     items = widget.items;
//   }
//
//   Widget _buildBox(Widget item) {
//     return item;
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
//       items
//         ..clear()
//         ..addAll(newItems);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ImplicitlyAnimatedReorderableList(
//         items: items,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: 0),
//         areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
//         onReorderStarted: (item, index) => setState(() => inReorder = true),
//         onReorderFinished: (movedLanguage, from, to, newItems) {
//           // Update the underlying data when the item has been reordered!
//           onReorderFinished(newItems);
//         },
//         itemBuilder: (context, itemAnimation, item, index) {
//           return buildReorderable(item, (tile) {
//             return SizeFadeTransition(
//               sizeFraction: 0.7,
//               curve: Curves.easeInOut,
//               animation: itemAnimation,
//               child: tile,
//             );
//           });
//         },
//       ),
//     );
//   }
// }
