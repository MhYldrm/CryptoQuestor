import 'package:flutter/material.dart';
import '../ui/views/coin_details_page.dart';

class Item extends StatelessWidget {
  var item;
  Item({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CoinDetailPage(
                  selectCoin: item,
                )));
      },
      child: Padding(
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
                      item.image,
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
                            "${item.symbol}".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(item.name,
                              style: item.name.length < 14
                                  ? const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 15)
                                  : item.name.length < 21
                                  ? const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12)
                                  : item.name.length < 25
                                  ? const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11)
                                  : const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10)),
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
                        "\$ ${item.currentPrice.toString()}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${double.parse(item.marketCapChangePercentage24H.toString()).toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: item.marketCapChangePercentage24H > 0
                                ? Colors.green
                                : Colors.red.shade300),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
