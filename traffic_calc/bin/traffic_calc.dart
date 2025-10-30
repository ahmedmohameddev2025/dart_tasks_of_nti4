import 'dart:io';

void main() {
  while (true) {
    stdout.write('Enter speed limit (or 0 to exit): ');
    int speedLimit = int.parse(stdin.readLineSync()!);
    if (speedLimit == 0) break;

    stdout.write('Enter actual speed: ');
    int actualSpeed = int.parse(stdin.readLineSync()!);

    stdout.write('Do you have a license? (yes/no): ');
    String licenseInput = stdin.readLineSync()!.toLowerCase();
    bool hasLicense = licenseInput == 'yes';

    int fine = 0;
    int overSpeed = actualSpeed - speedLimit;

    if (overSpeed > 20) {
      fine = 1000;
    } else if (overSpeed > 0 && overSpeed <= 20) {
      fine = 500;
    }

    if (!hasLicense) {
      fine += 2000;
    }

    print('Total fine: \$$fine\n');
  }

  print('Program ended.');
}
