import 'dart:io';

void main() {
  // مصفوفة المقاعد (5 صفوف × 5 أعمدة)
  List<List<String>> seats = List.generate(
    5,
    (_) => List.filled(5, 'E'),
  );

  // خريطة لتخزين بيانات المستخدمين
  Map<String, String> users = {};

  print("Welcome To Our Theater");

  while (true) {
    print("\n1. Book a new seat");
    print("2. Show theater seats");
    print("3. Show users data");
    print("4. Exit");
    stdout.write("Enter your choice: ");
    String? choice = stdin.readLineSync();

    // 1. حجز مقعد
    if (choice == '1') {
      stdout.write("Enter row (1-5): ");
      int row = int.parse(stdin.readLineSync()!);
      stdout.write("Enter column (1-5): ");
      int col = int.parse(stdin.readLineSync()!);

      // التحقق من المقعد
      if (seats[row - 1][col - 1] == 'B') {
        print("This seat is already booked!");
      } else {
        stdout.write("Enter your name: ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter your phone number: ");
        String phone = stdin.readLineSync()!;

        seats[row - 1][col - 1] =
            'B'; // نغير حالة المقعد
        users["Seat $row,$col"] =
            "$name - $phone"; // نحفظ البيانات
        print("Seat booked successfully!");
      }
    }
    // 2. عرض المقاعد
    else if (choice == '2') {
      print("\nTheater Seats:");
      for (var row in seats) {
        print(row.join(' '));
      }
    }
    // 3. عرض بيانات المستخدمين
    else if (choice == '3') {
      print("\nUsers Booking Details:");
      if (users.isEmpty) {
        print("No bookings yet.");
      } else {
        users.forEach((seat, data) {
          print("$seat: $data");
        });
      }
    }
    // 4. خروج
    else if (choice == '4') {
      print("See You Back");
      break;
    }
    // خيار غير صحيح
    else {
      print("Invalid choice, try again.");
    }
  }
}
