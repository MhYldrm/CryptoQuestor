import 'package:flutter/material.dart';

class EarnCard extends StatelessWidget {
  EarnCard(
      {required this.imageUrl,
        required this.title,
        required this.exchangeName,
        super.key});
  String imageUrl, title, exchangeName;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double widht = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Container(
          height: height / 6,
          width: widht/1.05,
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                        height: height / 8,
                        width: widht / 3,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: title.length < 24
                                    ? 14
                                    : title.length < 27
                                    ? 13
                                    : 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.pin_drop,
                              size: 23,
                              color: Color(0xffFFD400),
                            ),
                            Text(
                              " - Exchange: $exchangeName",
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                          child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: const Color(0xffFFD400),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: const Center(
                              child: Text(
                                "Go to Details",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
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
    );
  }
}
