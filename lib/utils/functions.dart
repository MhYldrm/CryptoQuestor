class MyFunctions{

  //converted the data from firebase
  List<Map<String, dynamic>> summarizeData(List data) {
    Map<String, Map<String, dynamic>> summary = {};
    for (var item in data) {
      String name = item['name'];
      String symbol = item['symbol'];
      String imageUrl = item['imageUrl'];
      double quantity =
      double.parse(item['quantity']);
      double totalSpent = double.parse(item['totalSpent']);

      if (summary.containsKey(name)) {
        summary[name]!['quantity'] =
            (summary[name]!['quantity'] ?? 0) + quantity;
        summary[name]!['totalSpent'] =
            (summary[name]!['totalSpent'] ?? 0) + totalSpent;
      } else {
        summary[name] = {
          'quantity': quantity,
          'totalSpent': totalSpent,
          'symbol': symbol,
          'imageUrl': imageUrl,
        };
      }
    }

    return summary.entries.map((entry) {
      return {
        'name': entry.key,
        'quantity': entry.value['quantity'],
        'totalSpent': entry.value['totalSpent'],
        'symbol': entry.value['symbol'],
        'imageUrl': entry.value['imageUrl']
      };
    }).toList();
  }






}