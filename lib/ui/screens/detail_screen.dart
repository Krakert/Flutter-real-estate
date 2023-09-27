import 'package:flutter/cupertino.dart';
import 'package:flutter_real_estate/models/house_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.selectedItem}) : super(key: key);

  final HouseData selectedItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("DetailScreen"),
    );
  }
}
