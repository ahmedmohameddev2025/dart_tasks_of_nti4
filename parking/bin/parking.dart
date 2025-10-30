import 'dart:io';

void main() {
  print("Multi-Tier Parking Fee Calculator");
  stdout.write("Enter number of hours: ");
  int hours = int.parse(stdin.readLineSync()!);

  stdout.write("Is it weekend? (y/n): ");
  String? ans = stdin.readLineSync();
  bool isWeekend = (ans?.toLowerCase() == 'y');

  int cost = 0;

  if (hours <= 2) {
    print("Parking is Free");
  } else if (hours >= 3 && hours <= 5) {
    cost = (hours - 2) * 10;
  } else if (hours > 5) {
    cost = (3 * 10) + ((hours - 5) * 20);
  }

  if (isWeekend && hours > 2) {
    cost += 50;
  }

  if (hours > 2) {
    print("Total parking cost: \$$cost");
  }
}
