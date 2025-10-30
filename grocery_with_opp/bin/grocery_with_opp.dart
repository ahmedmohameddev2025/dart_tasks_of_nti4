import 'dart:io'; // مكتبة لإدخال وإخراج البيانات من وإلى الكونسول

// ===============================
// تعريف كلاس المنتج Product
// ===============================
class Product {
  String name; // اسم المنتج
  double price; // سعر المنتج
  int quantity; // الكمية المتوفرة من المنتج

  // Constructor: يُستخدم لإنشاء كائن جديد من المنتج
  Product(this.name, this.price, this.quantity);

  // دالة لعرض بيانات المنتج بطريقة منظمة
  void showInfo() {
    print('$name - Price: $price - Qty: $quantity');
  }
}

// ===============================
// كلاس النظام الرئيسي GrocerySystem
// ===============================
class GrocerySystem {
  // قائمة تحتوي على كل المنتجات الموجودة في النظام
  List<Product> products = [];

  // خريطة (Map) لتخزين كل الفواتير باسم العميل والإجمالي
  Map<String, Map<String, dynamic>> invoices = {};

  // متغير لحساب رقم الفاتورة الحالي (يزيد كل مرة)
  int invoiceCounter = 1;

  // --------------------------------
  // دالة لإضافة منتج جديد للنظام
  // --------------------------------
  void addProduct() {
    stdout.write('Enter product name: '); // طلب اسم المنتج
    String name = stdin.readLineSync()!; // قراءة الاسم من المستخدم

    stdout.write('Enter price: '); // طلب السعر
    double price = double.parse(
      stdin.readLineSync()!,
    ); // تحويل السعر من نص إلى رقم عشري

    stdout.write('Enter quantity: '); // طلب الكمية
    int qty = int.parse(
      stdin.readLineSync()!,
    ); // تحويل الكمية من نص إلى رقم صحيح

    // إنشاء كائن جديد من نوع Product وإضافته إلى القائمة
    products.add(Product(name, price, qty));

    print('Product added successfully!'); // تأكيد الإضافة
  }

  // --------------------------------
  // دالة لعرض جميع المنتجات في القائمة
  // --------------------------------
  void showProducts() {
    // إذا كانت القائمة فارغة
    if (products.isEmpty) {
      print('No products available.');
      return; // نخرج من الدالة
    }

    print('Products List:');
    // نمر على كل منتج في القائمة ونطبع تفاصيله
    for (int i = 0; i < products.length; i++) {
      print(
        '${i + 1}. ${products[i].name} - Price: ${products[i].price} - Qty: ${products[i].quantity}',
      );
    }
  }

  // --------------------------------
  // دالة لتحديث كمية منتج معين
  // --------------------------------
  void updateProductQuantity() {
    stdout.write('Enter product name to update: ');
    String name = stdin.readLineSync()!;

    // البحث عن المنتج في القائمة حسب الاسم
    Product? p = products.firstWhere(
      (prod) => prod.name.toLowerCase() == name.toLowerCase(),
      orElse: () => Product('', 0, 0),
    ); // إذا لم يوجد، يرجع منتج فارغ

    // إذا لم يُعثر على المنتج
    if (p.name == '') {
      print('Product not found.');
      return;
    }

    // إذا وُجد المنتج، نطلب الكمية الجديدة
    stdout.write('Enter new quantity: ');
    int newQty = int.parse(stdin.readLineSync()!);
    p.quantity = newQty; // تحديث الكمية
    print('Quantity updated successfully!');
  }

  // --------------------------------
  // دالة لإتمام عملية شراء من المستخدم
  // --------------------------------
  void buyProducts() {
    // إذا لم يكن هناك منتجات
    if (products.isEmpty) {
      print('No products available for purchase.');
      return;
    }

    // أخذ اسم العميل
    stdout.write('Enter your name: ');
    String customerName = stdin.readLineSync()!;

    // إنشاء سلة المشتريات (List of Maps)
    List<Map<String, dynamic>> cart = [];
    double total = 0; // الإجمالي النهائي

    // تكرار حتى يكتب المستخدم "done"
    while (true) {
      stdout.write("Enter product name (or 'done' to finish): ");
      String productName = stdin.readLineSync()!;

      // إذا كتب المستخدم "done" نخرج من الحلقة
      if (productName.toLowerCase() == 'done') break;

      // البحث عن المنتج المطلوب
      Product? selected = products.firstWhere(
        (p) => p.name.toLowerCase() == productName.toLowerCase(),
        orElse: () => Product('', 0, 0),
      );

      // إذا لم يُعثر على المنتج
      if (selected.name == '') {
        print('Product not found.');
        continue;
      }

      // طلب الكمية المراد شراؤها
      stdout.write('Enter quantity: ');
      int qty = int.parse(stdin.readLineSync()!);

      // التحقق من توفر الكمية
      if (qty > selected.quantity) {
        print('Not enough stock!');
        continue;
      }

      // خصم الكمية من المخزون
      selected.quantity -= qty;

      // حساب السعر الكلي لهذا المنتج
      double itemTotal = selected.price * qty;
      total += itemTotal; // جمع السعر للإجمالي

      // إضافة تفاصيل المنتج للسلة
      cart.add({
        'name': selected.name,
        'qty': qty,
        'price': selected.price,
        'total': itemTotal,
      });

      print('Added $qty x ${selected.name} to your cart');
    }

    // بعد الانتهاء من الشراء، نحفظ الفاتورة في الماب
    invoices['Invoice #$invoiceCounter'] = {
      customerName: cart, // اسم العميل وسلة المشتريات
      'final_total': total, // الإجمالي الكلي
    };

    print('Your total = $total');
    print('Invoice saved successfully!');

    // زيادة رقم الفاتورة للعميل التالي
    invoiceCounter++;
  }

  // --------------------------------
  // دالة لعرض جميع الفواتير المحفوظة
  // --------------------------------
  void showInvoices() {
    // إذا لم يكن هناك فواتير
    if (invoices.isEmpty) {
      print('No invoices found.');
      return;
    }

    // المرور على كل فاتورة وطباعة تفاصيلها
    invoices.forEach((invoiceNum, data) {
      print('\n$invoiceNum:');
      data.forEach((key, value) {
        if (key == 'final_total') return; // تخطي الإجمالي هنا
        print('Customer: $key');
        print('Items:');
        // طباعة تفاصيل كل منتج تم شراؤه
        for (var item in value) {
          print('- ${item['name']} x${item['qty']} = ${item['total']}');
        }
      });
      print('Total = ${data['final_total']}');
    });
  }
}

// ===============================
// دالة التشغيل الرئيسية main()
// ===============================
void main() {
  // إنشاء كائن من النظام
  GrocerySystem system = GrocerySystem();

  print('Welcome to Smart Grocery System');

  // حلقة لا نهائية حتى يختار المستخدم الخروج
  while (true) {
    // عرض القائمة الرئيسية
    print('\nPress 1 to add new product');
    print('Press 2 to show all products');
    print('Press 3 to update product quantity');
    print('Press 4 to buy products');
    print('Press 5 to show all invoices');
    print('Press 6 to exit');

    stdout.write('input => ');
    String choice = stdin.readLineSync()!;

    // تنفيذ الأمر بناءً على اختيار المستخدم
    switch (choice) {
      case '1':
        system.addProduct(); // إضافة منتج
        break;
      case '2':
        system.showProducts(); // عرض المنتجات
        break;
      case '3':
        system.updateProductQuantity(); // تعديل الكمية
        break;
      case '4':
        system.buyProducts(); // عملية شراء
        break;
      case '5':
        system.showInvoices(); // عرض الفواتير
        break;
      case '6':
        print('Thank you for shopping with us!');
        return; // الخروج من البرنامج
      default:
        print('Invalid choice. Try again.'); // في حالة إدخال خاطئ
    }
  }
}
