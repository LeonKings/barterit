import 'package:flutter/material.dart';
import '../../../model/items.dart';
import '../../../model/user.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:barterit/myconfig.dart';

import 'newitemscreen.dart';

class AddItemScreen extends StatefulWidget {
  final User user;
  const AddItemScreen({super.key, required this.user});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "My Item";
  List<Items> itemList = <Items>[];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> _refreshItems() async {
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(title: Text(maintitle)),
      body: itemList.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : Column(children: [
              Container(
                height: 24,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  "${itemList.length} Items Found",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: _refreshItems,
                      child: GridView.count(
                          crossAxisCount: axiscount,
                          children: List.generate(
                            itemList.length,
                            (index) {
                              return Card(
                                  child: InkWell(
                                      child: Column(children: [
                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, imageIndex) {
                                      return Column(children: [
                                        CachedNetworkImage(
                                          width: screenWidth,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${MyConfig().SERVER}/barterit/assets/items/1/${itemList[index].itemsId}.png",
                                          placeholder: (context, url) =>
                                              const LinearProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        CachedNetworkImage(
                                          width: screenWidth,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${MyConfig().SERVER}/barterit/assets/items/2/${itemList[index].itemsId}.png",
                                          placeholder: (context, url) =>
                                              const LinearProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        CachedNetworkImage(
                                          width: screenWidth,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${MyConfig().SERVER}/barterit/assets/items/3/${itemList[index].itemsId}.png",
                                          placeholder: (context, url) =>
                                              const LinearProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      ]);
                                    },
                                  ),
                                ),
                                Text(
                                  itemList[index].itemsName.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "${itemList[index].itemsQty} items",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "At ${itemList[index].itemsState} ",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ])));
                            },
                          ))))
            ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (content) => NewItemScreen(
                          user: widget.user,
                        )));
            loadItems();
          },
          child: const Text(
            "+",
            style: TextStyle(fontSize: 32, color: Colors.white),
          )),
    );
  }

  void loadItems() {
    http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/load_items.php"),
        body: {"user_id": widget.user.id}).then((response) {
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Items.fromJson(v));
          });
        }
        setState(() {});
      }
    });
  }
}
