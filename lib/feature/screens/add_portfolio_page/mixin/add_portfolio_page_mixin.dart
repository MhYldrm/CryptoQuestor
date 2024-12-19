import 'package:crypto_questor/feature/screens/add_portfolio_page/add_portfolio_page.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';

mixin AddPortfolioPageMixin on State<AddPortfolioPage> {
  TextEditingController currentPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String totalSpent = '0';

  @override
  void initState() {
    super.initState();
    currentPriceController.text = widget.selectCoin.currentPrice.toString();
    quantityController.text = '0';
  }

  String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  double calculateSpent(
      TextEditingController currentPrice, TextEditingController quantity) {
    double totalSpent = 0;
    totalSpent = double.parse(currentPrice.text) * double.parse(quantity.text);
    return totalSpent;
  }

  Future<void> saveCoinToPortfolio() async {
    String uid = randomAlphaNumeric(10);
    Map<String, dynamic> upToInfo = {
      'dateTime': formattedDate,
      'imageUrl': widget.selectCoin.image,
      'name': widget.selectCoin.name,
      'symbol': widget.selectCoin.symbol,
      'quantity': quantityController.text,
      'totalSpent': totalSpent,
      'uid': uid,
    };

    if (upToInfo['totalSpent'] != null && totalSpent != '0') {
      await FirebaseService().upToPortfolioCoin(upToInfo, uid);
    }
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.mYellow,
          duration: const Duration(milliseconds: 800),
          content: Text(
            '${widget.selectCoin.symbol.toString().toUpperCase()} ${context.mLocalizations.addedPortfolioCoin}',
            style: const TextStyle(color: CustomColors.bgcolor),
          ),
        ),
      );
    });
  }

  // Current Price değişikliklerini ele alan fonksiyon
  void handleCurrentPriceChange(String value) {
    if (value.isNotEmpty) {
      setState(() {
        currentPriceController.text = value;
        totalSpent = calculateSpent(currentPriceController, quantityController)
            .toString();
      });
    } else {
      setState(() {
        currentPriceController.text = '0';
      });
    }
  }

  // Quantity değişikliklerini ele alan fonksiyon
  void handleQuantityChange(String value) {
    if (value.isNotEmpty) {
      setState(() {
        quantityController.text = value;
        totalSpent = calculateSpent(currentPriceController, quantityController)
            .toString();
      });
    } else {
      setState(() {
        quantityController.text = '0';
      });
    }
  }
}
