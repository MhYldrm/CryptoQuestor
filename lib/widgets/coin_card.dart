import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  CoinCard({
    super.key,
    required this.symbol,
    this.url,
    required this.price,
    required this.name,
    this.balance,
  });
  String symbol, price, name;
  String? url;
  String? balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 165,
          width: 215,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.25, 0.75, 1],
              colors: [
                Color(0x99FFFFFF),
                Color(0x00FFFFFF),
                Color(0x00FFFFFF),
                Color(0x99FFFFFF),
              ],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 5, 8, 28),
                    Color.fromARGB(255, 17, 53, 87),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          url!,
                          fit: BoxFit.fill,
                          height: 45,
                          width: 45,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              symbol.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                            Text(name,
                                style: name.length < 14
                                    ? const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17)
                                    : name.length < 21
                                    ? const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)
                                    : name.length < 25
                                    ? const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10)
                                    : const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 7)),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "\$ $price",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "$balance ${symbol.toUpperCase()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
