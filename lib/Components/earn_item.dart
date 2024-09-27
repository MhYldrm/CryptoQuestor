import 'package:flutter/material.dart';

class EarnItem extends StatelessWidget {
  var item;
  EarnItem({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double widht = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: height / 5,
            width: widht,
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
                  child: Row(
                    children: [
                      Image.network(
                        item.imageUrl,
                        fit: BoxFit.fill,
                        height: height / 6,
                        width: widht / 2.5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: VerticalDivider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              item.title,
                              style: TextStyle(
                                  fontSize: item.title.length < 24
                                      ? 17
                                      : item.title.length < 27
                                      ? 16
                                      : 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                size: 25,
                                color: Color(0xffFFD400),
                              ),
                              Text(
                                " - Exchange: ${item.exchangeName}",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 50,
                            width: 180,
                            child: ElevatedButton(
                              onPressed: () {
                                // burdan diğer sayfaya bilgileri aktaracağız
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFFD400),
                                  shadowColor: Colors.red,
                                  elevation: 5),
                              child: const Text(
                                "Go to Details",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
