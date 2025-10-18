
enum DeliveryType { delivery, pickup }

class Product {
	final String id;
	final String name;
	final double price; // unit price

	Product({required this.id, required this.name, required this.price});
}

class OrderItem {
	final Product product;
	final int quantity;

	OrderItem({required this.product, required this.quantity}) {
		if (quantity <= 0) throw ArgumentError('quantity must be > 0');
	}

	double subtotal() => product.price * quantity;
}

class Address {
	final String street;
	final String city;
	final String zip;

	Address({required this.street, required this.city, required this.zip});

	@override
	String toString() => '$street, $city, $zip';
}

class Order {
	final String id;
	final List<OrderItem> items;
	final DeliveryType deliveryType;
	final Address? address; // nullable: null when pickup

	// Named constructor showing required and nullable parameters
	Order({
		required this.id,
		required List<OrderItem> items,
		required this.deliveryType,
		this.address,
	}) : items = List.unmodifiable(items);

	// Compute total amount (sum of subtotals), could add delivery fee or taxes here
	double total() => items.fold(0.0, (sum, it) => sum + it.subtotal());

	@override
	String toString() {
		final buf = StringBuffer();
		buf.writeln('Order: $id');
		buf.writeln('Delivery: $deliveryType');
		if (address != null) buf.writeln('Address: $address');
		for (var it in items) {
			buf.writeln('- ${it.product.name} x ${it.quantity} = ${it.subtotal().toStringAsFixed(2)}');
		}
		buf.writeln('Total: ${total().toStringAsFixed(2)}');
		return buf.toString();
	}
}

void main() {
	// Sample products
	final apple = Product(id: 'p1', name: 'Apple', price: 0.5);
	final orange = Product(id: 'p2', name: 'Orange', price: 0.75);
	final laptop = Product(id: 'p3', name: 'Laptop', price: 999.99);

	// Sample orders
	final order1 = Order(
		id: 'o1',
		items: [
			OrderItem(product: apple, quantity: 10),
			OrderItem(product: orange, quantity: 5),
		],
		deliveryType: DeliveryType.delivery,
		address: Address(street: '123 Main St', city: 'Hometown', zip: '12345'),
	);

	final order2 = Order(
		id: 'o2',
		items: [
			OrderItem(product: laptop, quantity: 1),
		],
		deliveryType: DeliveryType.pickup,
		address: null, // pickup, no address
	);

	print(order1);
	print('---');
	print(order2);
}
