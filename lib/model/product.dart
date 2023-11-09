class Product {
  final String title, image, price;

  Product({required this.price, required this.title, required this.image});
}

List<Product> productsList = [
  Product(
      title: "Zapatilla prd", image: "assets/images/img_1.png", price: "43"),
  Product(
      title: "Zapatilla dev", image: "assets/images/img_2.webp", price: "39"),
  Product(
      title: "Zapatilla nike", image: "assets/images/img_2.webp", price: "63"),
  Product(
      title: "Zapatilla test", image: "assets/images/img_3.png", price: "27"),
  Product(title: "Zapatilla qa", image: "assets/images/img_4.png", price: "59"),
];
