import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1.0, 2.0),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          )
        ],
      ),
      child: SizedBox(
        height: 48,
        child: Stack(
          children: [
            Row(
              children: [
                // Container(
                //   width: 48.0,
                //   height: 48.0,
                //   alignment: Alignment.centerLeft,
                //   decoration: BoxDecoration(
                //     color: Colors.deepPurple,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: const Center(
                //     child: Icon(Icons.settings, color: Colors.white),
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
