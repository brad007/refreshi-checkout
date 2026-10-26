/// Fixed reference data served by the in-app backend.
abstract final class SeedData {
  /// Surplus-food "rescue bags" from partner stores. Prices are what the
  /// customer pays; `originalPriceCents` is the shelf value of the contents.
  static const services = <Map<String, Object>>[
    {
      '__typename': 'Service',
      'id': 'bag_bakery',
      'name': 'Bakery rescue bag',
      'storeName': 'Knead Bakery, Kloof St',
      'category': 'BAKERY',
      'description': 'Today\'s unsold loaves, croissants and pastries.',
      'priceCents': 6500,
      'originalPriceCents': 19500,
    },
    {
      '__typename': 'Service',
      'id': 'bag_grocer',
      'name': 'Fresh produce box',
      'storeName': 'Harvest Grocer, Gardens',
      'category': 'GROCERY',
      'description': 'Seasonal fruit and veg that is perfect to eat, just not perfect to look at.',
      'priceCents': 8900,
      'originalPriceCents': 26000,
    },
    {
      '__typename': 'Service',
      'id': 'bag_cafe',
      'name': 'Café surprise bag',
      'storeName': 'Origin Coffee, De Waterkant',
      'category': 'CAFE',
      'description': 'Sandwiches, wraps and a sweet treat from the day\'s counter.',
      'priceCents': 5500,
      'originalPriceCents': 16000,
    },
    {
      '__typename': 'Service',
      'id': 'bag_meals',
      'name': 'Ready-meal bundle',
      'storeName': 'The Daily Kitchen, Sea Point',
      'category': 'MEALS',
      'description': 'Two to three chilled ready meals made fresh this morning.',
      'priceCents': 9900,
      'originalPriceCents': 28500,
    },
  ];

  /// Saved cards, stored with Peach Payments as registration tokens: the app
  /// only ever sees the token and the last four digits. The first two are
  /// Peach's published test cards (Visa 4200 0000 0000 0000, Mastercard
  /// 5454 5454 5454 5454); the third simulates an "Insufficient Funds" decline.
  static const paymentMethods = <Map<String, Object>>[
    {'__typename': 'PaymentMethod', 'id': '8ac7a4a28a5f1e3c018a6b2e0d7f4a01', 'brand': 'Visa', 'last4': '0000'},
    {'__typename': 'PaymentMethod', 'id': '8ac7a4a28a5f1e3c018a6b2e0d7f4b07', 'brand': 'Mastercard', 'last4': '5454'},
    {'__typename': 'PaymentMethod', 'id': declinedPaymentMethodId, 'brand': 'Visa', 'last4': '8079'},
  ];

  static const declinedPaymentMethodId = '8ac7a4a28a5f1e3c018a6b2e0d7f4c19';

  /// Pickup windows: stores hand over the day's surplus from midday on.
  static const slotStartHours = [12, 15, 17, 19];
  static const slotDuration = Duration(hours: 1);

  /// A slot must start at least this far in the future to be bookable.
  static const slotLeadTime = Duration(hours: 1);

  static const maxServicesPerOrder = 2;
  static const currency = 'ZAR';
}
