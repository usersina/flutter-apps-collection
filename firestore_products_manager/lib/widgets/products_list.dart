import 'package:firestore_products_manager/models/product.dart';
import 'package:firestore_products_manager/services/firestore_db_service.dart';
import 'package:firestore_products_manager/widgets/product_dialog.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  // -- This widget will be re-rendered when the parent stream updates
  final List<Product> products;
  const ProductsList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = products[index];
        return ListTile(
          title: Text(
            product.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('Costs: ${product.price}'),
          onTap: () {},
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ProductDialog(
                      product: product,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  FireStoreDbService.deleteProduct(product.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
