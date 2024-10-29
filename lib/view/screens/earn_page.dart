import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:flutter/material.dart';
import '../../core/models/earn_model.dart';
import '../../core/services/coin_services.dart';
import '../../core/services/firebase_service.dart';
import '../../view/widgets/earn_card.dart';
import '../../view/screens/earn_details_page.dart';


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
    _service.getEarnProjectsFromGithub().then((value) {
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
          backgroundColor: CustomColors.bgcolor,
          body: Column(
            children: [
              const Expanded(
                flex: 1,
                child: TopPart(),
              ),
              Expanded(
                flex: 7,
                child: isLoading == null
                    ? showCircularProgressIndicator()
                    : isLoading == true
                    ? showEarnsWidget()
                    : isApiRequestErrorWidget(context),
              ),
            ],
          ),
      ),
    );
  }

  // Widget to be displayed when API many request error
  Padding isApiRequestErrorWidget(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      context.mLocalizations.isApiRequestFailed,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: CustomColors.mWhitePrimary
                      ),),
                  ),
                );
  }

  ListView showEarnsWidget() {
    return ListView.builder(
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
                    });
  }

  Center showCircularProgressIndicator() {
    return const Center(
                  child: CircularProgressIndicator(),
                );
  }
}

class TopPart extends StatelessWidget {
  const TopPart({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseService = FirebaseService().firebaseAuth;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    context.mLocalizations.cryptoLover,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mGreyPrimary,fontWeight: FontWeight.w400),
              ),
               Text(
                context.mLocalizations.cryptoRewards,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
