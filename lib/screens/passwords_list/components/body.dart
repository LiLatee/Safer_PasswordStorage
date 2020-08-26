import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/account_data.dart';
import 'account_tile/account_tile.dart';

class Body extends StatefulWidget {
  final List<AccountData> testAccounts;

  Body({@required this.testAccounts});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedTileIndex = 0;
  callback(newIndex) {
    setState(() {
      log("3", name: "LOL");
      log("BYŁO:${selectedTileIndex.toString()}", name: "LOL");
      selectedTileIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("HALO", name: "LOL");
    log("JEST:${selectedTileIndex.toString()}", name: "LOL");
    return ListView.builder(
      itemCount: widget.testAccounts.length,
      itemBuilder: (var context, var index) => AccountTile(
          accountData: widget.testAccounts[index],
          selectedTileIndex: selectedTileIndex,
          index: index,
          callback: callback),
    );

    // return Column(children: <Widget>[
    //   ExpansionPanelList(
    //     expansionCallback: (int index, bool isExpanded) {},
    //     children: [
    //       ExpansionPanel(
    //         headerBuilder: (BuildContext context, bool isExpanded) {
    //           return ListTile(
    //             title: Text('Item 1'),
    //           );
    //         },
    //         body: ListTile(
    //           title: Text('Item 1 child'),
    //           subtitle: Text('Details goes here'),
    //         ),
    //         isExpanded: true,
    //       ),
    //       ExpansionPanel(
    //         headerBuilder: (BuildContext context, bool isExpanded) {
    //           return ListTile(
    //             title: Text('Item 2'),
    //           );
    //         },
    //         body: ListTile(
    //           title: Text('Item 2 child'),
    //           subtitle: Text('Details goes here'),
    //         ),
    //         isExpanded: false,
    //       ),
    //     ],
    //   ),
    // ]);
  }
}
