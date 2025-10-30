import 'dart:io';

void main() {
  List<Map<String, dynamic>> products = [];
  Map<String, Map<String, dynamic>> invoices = {};
  int invoiceCounter = 1;

  print("Welcome to Smart Grocery System");

  while (true) {
    displayOptions();

    int choice = handleInput((s) {
      int? value = int.tryParse(s);
      return (value != null &&
              value >= 1 &&
              value <= 6)
          ? value
          : null;
    });

    // 1. إضافة منتج جديد
    if (choice == 1) {
      stdout.write("Enter product name: ");
      String name = handleInput();

      stdout.write("Enter price: ");
      double price = handleInput((s) {
        double? v = double.tryParse(s);
        return (v != null && v > 0) ? v : null;
      });

      stdout.write("Enter quantity: ");
      int qty = handleInput((s) {
        int? v = int.tryParse(s);
        return (v != null && v >= 0) ? v : null;
      });

      products.add({
        'name': name,
        'price': price,
        'qty': qty,
      });
      print("Product added successfully!");
    }
    // 2. عرض المنتجات
    else if (choice == 2) {
      print("\nProducts List:");
      if (products.isEmpty) {
        print("No products available.");
      } else {
        for (int i = 0; i < products.length; i++) {
          print(
            "${i + 1}. ${products[i]['name']} - Price: ${products[i]['price']} - Qty: ${products[i]['qty']}",
          );
        }
      }
    }
    // 3. تحديث كمية منتج
    else if (choice == 3) {
      stdout.write("Enter product name to update: ");
      String name = handleInput();

      var product = products.firstWhere(
        (p) =>
            p['name'].toLowerCase() ==
            name.toLowerCase(),
        orElse: () => {},
      );

      if (product.isEmpty) {
        print("Product not found.");
      } else {
        stdout.write("Enter new quantity: ");
        int newQty = handleInput((s) {
          int? v = int.tryParse(s);
          return (v != null && v >= 0) ? v : null;
        });
        product['qty'] = newQty;
        print("Quantity updated successfully!");
      }
    }
    // 4. شراء منتجات
    else if (choice == 4) {
      if (products.isEmpty) {
        print("No products to buy.");
        continue;
      }

      stdout.write("Enter your name: ");
      String customer = handleInput();

      List<Map<String, dynamic>> cart = [];
      double total = 0;

      while (true) {
        stdout.write(
          "Enter product name (or 'done' to finish): ",
        );
        String name = handleInput();
        if (name.toLowerCase() == 'done') break;

        var product = products.firstWhere(
          (p) =>
              p['name'].toLowerCase() ==
              name.toLowerCase(),
          orElse: () => {},
        );

        if (product.isEmpty) {
          print("Product not found.");
          continue;
        }

        stdout.write("Enter quantity: ");
        int qty = handleInput((s) {
          int? v = int.tryParse(s);
          return (v != null && v > 0) ? v : null;
        });

        if (qty > product['qty']) {
          print("Not enough stock!");
        } else {
          num itemTotal = qty * product['price'];
          product['qty'] -= qty;
          cart.add({
            'name': product['name'],
            'qty': qty,
            'price': product['price'],
            'total': itemTotal,
          });
          total += itemTotal;
          print(
            "Added $qty x ${product['name']} to your cart",
          );
        }
      }

      if (cart.isEmpty) {
        print("No items purchased.");
        continue;
      }

      invoices["Invoice #$invoiceCounter"] = {
        customer: cart,
        "final_total": total,
      };

      print("\nYour total = $total");
      print("Invoice saved successfully!");
      invoiceCounter++;
    }
    // 5. عرض جميع الفواتير
    else if (choice == 5) {
      print("\nAll Invoices:");
      if (invoices.isEmpty) {
        print("No invoices found.");
      } else {
        invoices.forEach((inv, data) {
          data.forEach((key, value) {
            if (key == "final_total") return;
            print("\n$inv:");
            print("Customer: $key");
            print("Items:");
            for (var item in value) {
              print(
                "- ${item['name']} x${item['qty']} = ${item['total']}",
              );
            }
            print("Total = ${data['final_total']}");
          });
        });
      }
    }
    // 6. الخروج
    else if (choice == 6) {
      print("Thank you for shopping with us!");
      break;
    }
  }
}

// القائمة
void displayOptions() {
  print('''
--- Inventory Management System ---
1. Add New Product
2. Show Products
3. Update Product
4. Purchase Products
5. Show Invoices
6. Exit
''');
}

// إدخال عام قابل لإعادة الاستخدام
dynamic handleInput([
  dynamic Function(String)? casting,
]) {
  print("Enter a value: ");
  while (true) {
    String input = stdin.readLineSync() ?? '';
    if (input.isEmpty) {
      print('Invalid input. Please try again.');
    } else {
      var value = casting == null
          ? input
          : casting(input);
      if (value == null) {
        print('Invalid input. Please try again.');
      } else {
        return value;
      }
    }
  }
}
