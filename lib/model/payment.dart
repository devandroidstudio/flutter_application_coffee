class Payment {
  final String name;
  final String images;
  bool? isSelected;

  Payment({required this.name, required this.images, this.isSelected = false});
}

final listPayments = [
  Payment(
      name: 'Monney',
      images: 'assets/images_payment/monney.png',
      isSelected: true),
  Payment(name: 'Paypal', images: 'assets/images_payment/paypal.png'),
  Payment(name: 'Momo', images: 'assets/images_payment/momo2.png'),
];
