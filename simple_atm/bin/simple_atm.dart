import 'dart:io';

void main() {
  int balance = 1000;
  bool isRunning = true;

  print("\nWelcome to Simple ATM\nYour stating balance is $balance\n");

  while (isRunning) {
    print(
      "Choose an option: \n1. Check Balance \n2. Withdraw \n3. Deposit \n4. Exit\n",
    );

    stdout.write("Enter choice: ");
    String? choiceInput = stdin.readLineSync();
    int? choice = int.tryParse(choiceInput!);

    if (choice == 1) {
      print("Your balance is $balance\n");
    } else if (choice == 2) {
      stdout.write("Enter amount to withdraw: ");
      String? withdrawInput = stdin.readLineSync();
      int? withdraw = int.tryParse(withdrawInput!);

      if (withdraw == null || withdraw <= 0) {
        print("Invalid withdraw amount. Please try again.\n");
        continue;
      }

      if (withdraw <= balance) {
        balance -= withdraw;
        print("Withdraw successful! Your current balance is $balance\n");
      } else {
        print("Insufficient balance! Your current balance is $balance\n");
      }
    } else if (choice == 3) {
      stdout.write("Enter amount to deposit: ");
      String? depositInput = stdin.readLineSync();
      int? deposit = int.tryParse(depositInput!);

      if (deposit == null || deposit <= 0) {
        print("Invalid deposit amount. Please try again.\n");
      } else {
        balance += deposit;
        print("Deposit successful! Your current balance is $balance\n");
      }
    } else if (choice == 4) {
      print("Thank you for using the ATM!");
      isRunning = false;
    } else {
      print("Invalid choice. Please try again.\n");
    }
  }
}
