import '../../model/items.dart';
import '../../model/user.dart';
import 'package:barterit/myconfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: Column(
        children: [
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
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.useritems.itemsName.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(6),
                },
                children: [
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        widget.useritems.itemsDesc.toString(),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Quantity Available",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        widget.useritems.itemsQty.toString(),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        "${widget.useritems.itemsLocality}/${widget.useritems.itemsState}",
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        df.format(
                            DateTime.parse(widget.useritems.date.toString())),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(7.5),
          ),
        ],
      ),
    );
  }
}
