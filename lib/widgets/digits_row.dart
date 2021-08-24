import 'package:digit_recognizer/models/prediction_model.dart';
import 'package:digit_recognizer/provider/drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DigitsRow extends StatelessWidget {
  final int start, end;
  double getAccurecy(int index, List<Predection> list) {
    double accurecy = 0;
    list.forEach((element) {
      if (element.index == index) {
        accurecy = element.confidence;
      }
    });
    return accurecy;
  }

  const DigitsRow({
    Key? key,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DrawerProvider _provider = Provider.of<DrawerProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = start; i < end; i++)
            Column(
              children: [
                Text(
                  '$i',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(getAccurecy(i, _provider.predection) * 2),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  getAccurecy(i, _provider.predection) == 0
                      ? ''
                      : (getAccurecy(i, _provider.predection) * 100)
                              .toStringAsFixed(1) +
                          '%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
