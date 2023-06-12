import 'package:flutter/material.dart';
import '../../model/user.dart';

//for buyer screen

class BarterScreen extends StatefulWidget {
  final User user;
  const BarterScreen({super.key, required this.user});

  @override
  State<BarterScreen> createState() => _BarterScreenState();
}

class _BarterScreenState extends State<BarterScreen> {
  String maintitle = "Buyer";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(maintitle),
    );
  }
}
