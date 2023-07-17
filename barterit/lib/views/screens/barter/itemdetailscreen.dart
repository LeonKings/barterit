import '../../../model/items.dart';
import '../../../model/user.dart';
import 'package:barterit/myconfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'barteritem.dart';

class ItemDetailScreen extends StatefulWidget {
  final Items useritems;
  final User user;
  const ItemDetailScreen(
      {super.key, required this.useritems, required this.user});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int qty = 0;
  int userqty = 1;

  @override
  void initState() {
    super.initState();
    qty = int.parse(widget.useritems.itemsQty.toString());
  }

  final df = DateFormat('dd-MM-yyyy hh:mm a');

  late double screenHeight, screenWidth, cardwitdh;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Item Details")),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(7.5),
          child: SizedBox(
            height: screenWidth * 0.65,
            child: PageView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.5),
                  child: Card(
                    child: CachedNetworkImage(
                      width: screenWidth,
                      fit: BoxFit.cover,
                      imageUrl:
                          "${MyConfig().SERVER}/barterit/assets/items/1/${widget.useritems.itemsId}.png",
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.5),
                  child: Card(
                    child: CachedNetworkImage(
                      width: screenWidth,
                      fit: BoxFit.cover,
                      imageUrl:
                          "${MyConfig().SERVER}/barterit/assets/items/2/${widget.useritems.itemsId}.png",
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.5),
                  child: Card(
                    child: CachedNetworkImage(
                      width: screenWidth,
                      fit: BoxFit.cover,
                      imageUrl:
                          "${MyConfig().SERVER}/barterit/assets/items/3/${widget.useritems.itemsId}.png",
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        buildTable(),
        const SizedBox(height: 8.0),
        Center(
          child: ElevatedButton(
            onPressed: () {
              itemCheck();
            },
            child: const Text("Barter", style: TextStyle(color: Colors.white)),
          ),
        )
      ]),
    );
  }

  Widget buildTable() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(6),
        },
        children: [
          buildTableRow("Description", widget.useritems.itemsDesc.toString()),
          buildTableRow(
              "Quantity Available", widget.useritems.itemsQty.toString()),
          buildTableRow(
            "Location",
            "${widget.useritems.itemsLocality}/${widget.useritems.itemsState}",
          ),
          buildTableRow(
            "Date",
            df.format(DateTime.parse(widget.useritems.date.toString())),
          ),
        ],
      ),
    );
  }

  TableRow buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(value),
        ),
      ],
    );
  }

  void itemCheck() {
    if (widget.useritems.userId == widget.user.id) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Can't Barter with your own item")));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BarterItem(user: widget.user, selecteditems: widget.useritems)),
      );
    }
  }
}
