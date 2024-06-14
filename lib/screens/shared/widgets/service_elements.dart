import 'package:flutter/material.dart';

class ServiceElements extends StatelessWidget {
  String name;
  Image image;
  ServiceElements({required this.name,required this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: 16.69,
        height: 116.69,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   imagePath,
            //   width: MediaQuery.of(context).size.width * 0.7,
            //   height: MediaQuery.of(context).size.height * 0.7,
            // ),
            Container(
              height: 34,
              width: 34,
              child: image,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

