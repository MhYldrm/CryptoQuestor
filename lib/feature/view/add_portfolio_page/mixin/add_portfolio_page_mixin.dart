/// [AddPortfolioPageMixin] is a mixin used with [AddPortfolioPage] to handle
/// business logic and state management for adding a cryptocurrency to a user's portfolio.
///
/// Key Responsibilities:
/// - Handles input for the current price and quantity of a cryptocurrency.
/// - Calculates the total cost based on input values.
/// - Saves the cryptocurrency to the user's portfolio using Firebase.
/// - Provides user feedback upon successful save.
///
part of '../add_portfolio_page.dart';

mixin AddPortfolioPageMixin on State<AddPortfolioPage> {
  // Controllers for managing the input fields for current price and quantity.
  final TextEditingController _currentPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // A string representing the total cost of the cryptocurrency purchase.
  String _totalSpent = ProjectConstants.zeroNumString;

  @override
  void initState() {
    super.initState();
    // Initialize the input fields with default values.
    _currentPriceController.text = widget.selectCoin.currentPrice.toString();
    _quantityController.text = ProjectConstants.zeroNumString;
  }

  @override
  void dispose() {
    super.dispose();
    _currentPriceController.dispose();
    _quantityController.dispose();
  }

  // The formatted current date and time for record-keeping.
  String formattedDate =
      DateFormat(ProjectConstants.dateFormatToConvert).format(DateTime.now());

  /// Saves the cryptocurrency to the user's portfolio in Firebase.
  /// - Generates a unique ID and creates a data map for the coin.
  /// - Ensures that the totalSpent value is valid before saving.
  /// - Displays a success message using a [SnackBar].
  ///
  Future<void> saveCoinToPortfolio() async {
    String uid = randomAlphaNumeric(10);
    Map<String, dynamic> upToInfo = {
      'dateTime': formattedDate,
      'imageUrl': widget.selectCoin.image,
      'name': widget.selectCoin.name,
      'symbol': widget.selectCoin.symbol,
      'quantity': _quantityController.text,
      'totalSpent': _totalSpent,
      'uid': uid,
    };

    if (upToInfo['totalSpent'] != null && _totalSpent != ProjectConstants.zeroNumString) {
      await FirebaseService().upToPortfolioCoin(upToInfo, uid);
    }

    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ProjectCustomColors.mYellow,
          duration: const Duration(milliseconds: 800),
          content: Text(
            '${widget.selectCoin.symbol.toString().toUpperCase()} ${context.mLocalizations.addedPortfolioCoin}',
            style: const TextStyle(color: ProjectCustomColors.bgColor),
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
        _currentPriceController.text = value;
        _totalSpent = calculateSpent(_currentPriceController, _quantityController).toString();
      });
    } else {
      setState(() {
        _currentPriceController.text = ProjectConstants.zeroNumString;
      });
    }
  }

  /// Handles changes to the quantity input field.
  /// - Updates the totalSpent value dynamically.
  void handleQuantityChange(String value) {
    if (value.isNotEmpty) {
      setState(() {
        _quantityController.text = value;
        _totalSpent = calculateSpent(_currentPriceController, _quantityController).toString();
      });
    } else {
      setState(() {
        _quantityController.text = ProjectConstants.zeroNumString;
      });
    }
  }

  /// Calculates the total cost based on the provided current price and quantity.
  /// - [currentPrice]: Controller holding the current price of the cryptocurrency.
  /// - [quantity]: Controller holding the quantity of the cryptocurrency.
  /// - Returns: A double representing the total cost.
  double calculateSpent(
      TextEditingController currentPrice, TextEditingController quantity) {
    double totalSpent = ProjectConstants.zeroNumDouble;
    totalSpent = double.parse(currentPrice.text) * double.parse(quantity.text);
    return totalSpent;
  }
}
