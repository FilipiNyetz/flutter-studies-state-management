import 'package:flutter/material.dart';
import 'package:mini_cart_setstate/quantity_cell.dart';

class Product {
  final int id;
  final String nome;
  final double valor;
  final String imagem;

  const Product({
    required this.id,
    required this.nome,
    required this.valor,
    required this.imagem,
  });
}

class ProductsCard extends StatefulWidget {
  static const products = [
    Product(
      id: 1,
      nome: "Arroz Branco Tipo 1",
      valor: 25.0,
      imagem: "https://images.unsplash.com/photo-1586201375761-83865001e31c",
    ),
    Product(
      id: 2,
      nome: "Feijão Carioca",
      valor: 10.0,
      imagem: "https://images.unsplash.com/photo-1515543904379-3d757afe72e4",
    ),
  ];
  final ValueChanged<double> onChanged;
  const ProductsCard({super.key, required this.onChanged});

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  Map<int, int> quantity = {};

  double get _totalValue {
    double total = 0;
    for (var product in ProductsCard.products) {
      total += product.valor * (quantity[product.id] ?? 0);
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    quantity = {for (var product in ProductsCard.products) product.id: 0};
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: ProductsCard.products.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F0EB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      ProductsCard.products[index].imagem,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_outlined,
                        color: Color(0xFFCCCCCC),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${ProductsCard.products[index].nome}",
                        style: const TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "R\$ ${ProductsCard.products[index].valor * quantity[ProductsCard.products[index].id]!}",
                            style: const TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          QuantityCell(
                            quantity:
                                quantity[ProductsCard.products[index].id] ?? 0,
                            onChanged: (newQuantity) => _onQuantityChanged(
                              ProductsCard.products[index].id,
                              newQuantity,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onQuantityChanged(int productId, int newQuantity) {
    setState(() {
      quantity[productId] = newQuantity;
    });
    widget.onChanged(_totalValue);
  }
}
