/// [exchangeName] Name of the exchange where the Earn campaign is located
/// [exchangeIconUrl] Icon-Image Url of the exchange where the Earn campaign is located
/// [dateTime] Validity date of the Earn campaign
/// [mYellow] Pin and Date range Icon  Yellow Color
/// [mWhitePrimary] Exchange name and date time text white color
///
part of '../earn_details_page.dart';

class MarketDetailsPartWidget extends StatelessWidget {
  const MarketDetailsPartWidget(
      {super.key,
      required this.exchangeName,
      required this.exchangeIconUrl,
      required this.dateTime});

  final String exchangeName;
  final String exchangeIconUrl;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.location_pin,
                  size: ApplicationSize.xSmall.value,
                  color: context.isDarkMode
                      ? CustomColors.mYellow
                      : CustomColors.mRedPrimary,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: CustomColors.mWhitePrimary.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: SizedBox(
                      height: ApplicationSize.xxsLarge.value,
                      width: ApplicationSize.xxxxLarge.value,
                      child: Image.network(
                        exchangeIconUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                ApplicationConstants.exchangeList.contains(exchangeName)
                    ? const Text(ApplicationConstants.emptyString)
                    : Text(
                        exchangeName,
                        style: context.textThemeTitleMedium?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mWhitePrimary
                              : CustomColors.mPurple,
                        ),
                      ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.date_range_rounded,
                  size: ApplicationSize.xSmall.value,
                  color: context.isDarkMode
                      ? CustomColors.mYellow
                      : CustomColors.mRedPrimary,
                ),
                Text(
                  dateTime,
                  style: context.textThemeBodyMedium?.copyWith(
                    color: context.isDarkMode
                        ? CustomColors.mWhitePrimary
                        : CustomColors.mPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
