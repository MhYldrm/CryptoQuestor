import 'package:crypto_questor/feature/screens/add_portfolio_page/add_portfolio_page.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';

/// [AddPortfolioPageMixin] is a mixin used with [AddPortfolioPage] to handle
/// business logic and state management for adding a cryptocurrency to a user's portfolio.
///
/// Key Responsibilities:
/// - Handles input for the current price and quantity of a cryptocurrency.
/// - Calculates the total cost based on input values.
/// - Saves the cryptocurrency to the user's portfolio using Firebase.
/// - Provides user feedback upon successful save.

mixin AddPortfolioPageMixin on State<AddPortfolioPage> {
  // Controllers for managing the input fields for current price and quantity.
  TextEditingController currentPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  // A string representing the total cost of the cryptocurrency purchase.
  String totalSpent = '0';

  @override
  void initState() {
    super.initState();
    // Initialize the input fields with default values.
    currentPriceController.text = widget.selectCoin.currentPrice.toString();
    quantityController.text = '0';
  }

  // The formatted current date and time for record-keeping.
  String formattedDate =
  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  /// Calculates the total cost based on the provided current price and quantity.
  /// - [currentPrice]: Controller holding the current price of the cryptocurrency.
  /// - [quantity]: Controller holding the quantity of the cryptocurrency.
  /// - Returns: A double representing the total cost.
  double calculateSpent(
      TextEditingController currentPrice, TextEditingController quantity) {
    double totalSpent = 0;
    totalSpent = double.parse(currentPrice.text) * double.parse(quantity.text);
    return totalSpent;
  }

  /// Saves the cryptocurrency to the user's portfolio in Firebase.
  /// - Generates a unique ID and creates a data map for the coin.
  /// - Ensures that the totalSpent value is valid before saving.
  /// - Displays a success message using a [SnackBar].
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

  /// Handles changes to the current price input field.
  /// - Updates the totalSpent value dynamically.
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

  /// Handles changes to the quantity input field.
  /// - Updates the totalSpent value dynamically.
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
