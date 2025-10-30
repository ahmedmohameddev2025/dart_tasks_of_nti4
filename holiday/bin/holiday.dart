
void main() {
 String x = 'friday';
 switch (x) {
 case 'sunday':
 case 'monday':
 case 'tuesday':
 case 'wednesday':
 case 'thursday':
 print('Not a holiday');
 case 'friday':
 case 'saturday':
 print('holiday');
 default:
 print('Invalid day');
 }
}
