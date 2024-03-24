import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/datamodel.dart';
import 'package:coffee_masters/pages/menupage.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final DataManager dataManager;
  const OrderPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final dataManager = DataManager();
  @override
  Widget build(BuildContext context) {
    if (widget.dataManager.cart.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Cart is Empty",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage(dataManager: dataManager)), 
                );
              },
              child: const Text("Explore Menu"),
            ),
          ],
        ),
      );
    } else {
      var total = widget.dataManager.cart.fold<double>(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.dataManager.cart.length,
              itemBuilder: (context, index) {
                var item = widget.dataManager.cart[index];
                return OrderItem(
                  item: item,
                  onRemove: (product) {
                    setState(() {
                      widget.dataManager.cartRemove(product);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${product.name} removed from the cart"),
                      duration: const Duration(seconds: 1),
                    ));
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "\$${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}

class OrderItem extends StatelessWidget {
  final ItemInCart item;
  final Function(Product) onRemove;
  const OrderItem({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "${item.quantity}x",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 6,
              child: Text(
                item.product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Text(
                "\$${(item.product.price * item.quantity).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                onRemove(item.product);
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
