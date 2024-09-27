import 'package:flutter/material.dart';

class PortCoinsCard extends StatefulWidget {
  String imageUrl, symbol, name;
  double quantity, totalSpent;
  PortCoinsCard({
    super.key,
    required this.imageUrl,
    required this.symbol,
    required this.name,
    required this.quantity,
    required this.totalSpent,
  });

  @override
  State<PortCoinsCard> createState() => _PortCoinsCardState();
}

class _PortCoinsCardState extends State<PortCoinsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff0B255B).withOpacity(0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fill,
                  height: 35,
                  width: 35,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.symbol.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.quantity.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$ ${widget.totalSpent.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
