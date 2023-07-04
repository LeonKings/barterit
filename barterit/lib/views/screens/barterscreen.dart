import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/items.dart';
import '../../model/user.dart';
import '../../myconfig.dart';
import 'itemdetailscreen.dart';
import 'package:http/http.dart' as http;

class BarterScreen extends StatefulWidget {
  final User user;
  const BarterScreen({super.key, required this.user});

  @override
  State<BarterScreen> createState() => _BarterScreenState();
}

class _BarterScreenState extends State<BarterScreen> {
  String maintitle = "Barter";
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  List<Items> itemList = <Items>[];
  int numofpage = 1, curpage = 1;
  int numofresult = 0;
  bool _searchBoolean = false;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadItems(1);
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
      appBar: AppBar(
        title: Text(maintitle),
        actions: _searchBoolean
            ? [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = false;
                    });
                  },
                )
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = true;
                    });
                  },
                )
              ],
      ),
      body: itemList.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : Column(children: [
              Container(
                height: 24,
                color: Colors.blueGrey,
                alignment: Alignment.center,
                child: Text(
                  "${itemList.length} Items Found",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: axiscount,
                      children: List.generate(
                        itemList.length,
                        (index) {
                          return Card(
                              child: InkWell(
                                  onTap: () async {
                                    Items useritem = Items.fromJson(
                                        itemList[index].toJson());
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (content) =>
                                                ItemDetailScreen(
                                                  user: widget.user,
                                                  useritems: useritem,
                                                )));
                                    loadItems(1);
                                  },
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
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
                      )))
            ]),
    );
  }

  void loadItems(int pg) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/load_items.php"),
        body: {"pageno": pg.toString()}).then((response) {
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          numofpage = int.parse(jsondata['numofpage']);
          numofresult = int.parse(jsondata['numofresult']);
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Items.fromJson(v));
          });
        }
        setState(() {});
      }
    });
  }

  Widget _searchTextField() {
    return TextField(
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (search) => searchItems(search),
      decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  void searchItems(String search) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/load_items.php"),
        body: {"search": search}).then((response) {
      print(response.body);
      itemList.clear();
      print("wakamoli dfjdkf");
      print(response.body);
      print("haloha");
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
