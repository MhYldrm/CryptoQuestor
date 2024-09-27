import 'package:flutter/material.dart';
import '../../models/earn_model.dart';
import '../../services/coin_services.dart';
import '../../services/firebase_service.dart';
import '../../widgets/earn_card.dart';
import 'earn_details_page.dart';


class EarnPage extends StatefulWidget {
  const EarnPage({super.key});

  @override
  State<EarnPage> createState() => _EarnPageState();
}

class _EarnPageState extends State<EarnPage> {
  final CoinService _service = CoinService();
  List<EarnModel>? earnList = [];
  bool? isLoading;
  @override
  void initState() {
    super.initState();
    _service.getEarnProjectsfromGithub().then((value) {
      if (value != null) {
        setState(() {
          earnList = value;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xff001E34),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const _welcomePart(),
                SizedBox(
                  height: 650,
                  width: double.infinity,
                  child: isLoading == null
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : isLoading == true
                      ? ListView.builder(
                      itemCount: earnList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, indeks) {
                        final earns = earnList![indeks];
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EarnDetailsPage(earnModel: earns)));
                              },
                              child: EarnCard(
                                  imageUrl: earns.imageUrl,
                                  title: earns.title,
                                  exchangeName: earns.exchangeName),
                            ));
                      })
                      : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                          "Attention this APİ is free, so you cannot send multiple requests per second, please wait and try again later"),
                    ),
                  ),
                ),


              ],
            ),
          )),
    );
  }
}

class _welcomePart extends StatelessWidget {
  const _welcomePart();

  @override
  Widget build(BuildContext context) {
    var firebaseService = FirebaseService().firebaseAuth;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    'Crypto Lover',
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Here Your Crypto Rewards 🎁",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
