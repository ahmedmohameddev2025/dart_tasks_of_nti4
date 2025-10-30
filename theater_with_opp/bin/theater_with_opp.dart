import 'dart:io'; // لإدخال المستخدم من الكونسول

// ===============================
// كلاس لحفظ بيانات المستخدم الذي حجز مقعد
// ===============================
class User {
  String name; // اسم المستخدم
  String phone; // رقم الهاتف

  User(this.name, this.phone); // Constructor لإنشاء كائن جديد من المستخدم
}

// ===============================
// الكلاس الرئيسي لإدارة المسرح
// ===============================
class Theater {
  // مصفوفة ثنائية الأبعاد (5x5) تمثل المقاعد
  // كل مقعد إما 'E' (فارغ) أو 'B' (محجوز)
  List<List<String>> seats = List.generate(5, (_) => List.filled(5, 'E'));

  // خريطة لتخزين بيانات كل حجز
  // المفتاح: "row,col" ، والقيمة: بيانات المستخدم (User)
  Map<String, User> bookings = {};

  // --------------------------------
  // دالة لعرض المقاعد الحالية
  // --------------------------------
  void showSeats() {
    print('Theater Seats:');
    for (var row in seats) {
      // نطبع كل صف من المقاعد
      print(row.join(' '));
    }
  }

  // --------------------------------
  // دالة لحجز مقعد جديد
  // --------------------------------
  void bookSeat() {
    // نطلب رقم الصف من المستخدم
    stdout.write("Enter row (1-5) or 'exit' to quit: ");
    String input = stdin.readLineSync()!;
    if (input.toLowerCase() == 'exit') return; // خروج من الحجز

    int row = int.parse(input) - 1; // تحويل إلى index (0-4)
    stdout.write("Enter column (1-5): ");
    int col = int.parse(stdin.readLineSync()!) - 1; // أيضًا إلى index

    // التحقق من صحة الرقم المدخل
    if (row < 0 || row >= 5 || col < 0 || col >= 5) {
      print("Invalid seat position.");
      return;
    }

    // التحقق إن كان المقعد محجوز
    if (seats[row][col] == 'B') {
      print("Seat already booked!");
      return;
    }

    // طلب بيانات المستخدم
    stdout.write("Enter your name: ");
    String name = stdin.readLineSync()!;
    stdout.write("Enter your phone number: ");
    String phone = stdin.readLineSync()!;

    // حجز المقعد
    seats[row][col] = 'B';

    // تخزين بيانات الحجز في الماب
    bookings["${row + 1},${col + 1}"] = User(name, phone);

    print("Seat booked successfully!");
  }

  // --------------------------------
  // دالة لعرض جميع بيانات المستخدمين الذين حجزوا
  // --------------------------------
  void showUsers() {
    if (bookings.isEmpty) {
      print("No bookings yet.");
      return;
    }

    print("\nUsers Booking Details:");
    bookings.forEach((seat, user) {
      print("Seat $seat: ${user.name} - ${user.phone}");
    });
  }
}

// ===============================
// دالة التشغيل الرئيسية main()
// ===============================
void main() {
  // إنشاء كائن من الكلاس Theater
  Theater theater = Theater();

  print("Welcome To Our Theater");

  // حلقة مستمرة حتى يختار المستخدم الخروج
  while (true) {
    print("\npress 1 to book new seat");
    print("press 2 to show the theater seats");
    print("press 3 to show users data");
    print("press 4 to exit");

    stdout.write("input => ");
    String choice = stdin.readLineSync()!;

    // تنفيذ حسب اختيار المستخدم
    switch (choice) {
      case '1':
        theater.bookSeat(); // حجز مقعد
        break;
      case '2':
        theater.showSeats(); // عرض المقاعد
        break;
      case '3':
        theater.showUsers(); // عرض بيانات المستخدمين
        break;
      case '4':
        print("See You Back");
        return; // خروج من البرنامج
      default:
        print("Invalid choice. Try again."); // إدخال خاطئ
    }
  }
}