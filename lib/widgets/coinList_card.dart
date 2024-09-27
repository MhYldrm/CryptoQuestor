import 'package:flutter/material.dart';

class CoinListCard extends StatelessWidget {
  CoinListCard(
      {super.key,
        required this.name,
        required this.symbol,
        required this.price,
        required this.change,
        required this.url});

  String name, symbol, price, change, url;

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 80,
        width: widht * 0.9,
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
                    url,
                    fit: BoxFit.fill,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          symbol,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        )
                      ],
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
                      "\$$price",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$change%",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: double.parse(change) > 0
                              ? Colors.green.shade300
                              : Colors.red.shade300),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
