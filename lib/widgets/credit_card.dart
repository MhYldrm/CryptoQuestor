import 'package:flutter/material.dart';
import '../ui/views/portfolio_page.dart';

class CreditCard extends StatelessWidget {
  CreditCard({super.key, this.balance});
  String? balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            const CreditCardBackground(),
            balanceText(balance),
            profitPercent(context),
          ],
        ),
      ),
    );
  }

  Widget profitPercent(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 75,
      child: Container(
          padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 138, 124, 54)),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PortfolioPage()));
              },
              icon: const Icon(
                Icons.chevron_right_rounded,
                size: 30,
              ))),
    );
  }

  Widget balanceText(String? balance) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Spent',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          Text(
            "${balance} \$",
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 80,
            width: 140,
            child: Image.asset(
              "assets/blockchain.png",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardBackground extends StatelessWidget {
  const CreditCardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Color.fromARGB(255, 7, 6, 6),
                Color.fromARGB(255, 6, 51, 93),
              ],
            ),
          ),
          child: Stack(
            children: [
              circleTopRight(),
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }

  Widget circleTopRight() {
    return Positioned(
      right: -120,
      top: -40,
      child: Container(
        width: 265,
        height: 265,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(-1.8, -1.2),
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(35, 24, 6, 75),
              Color.fromARGB(153, 30, 71, 112),
            ],
          ),
        ),
      ),
    );
  }

  Widget circleBottomLeft() {
    return Positioned(
      left: -15,
      bottom: -150,
      child: Container(
        width: 280,
        height: 280,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(5.9, -0.2),
            colors: [
              Color.fromARGB(36, 169, 20, 20),
              Color.fromARGB(153, 48, 9, 166),
            ],
          ),
        ),
      ),
    );
  }
}
