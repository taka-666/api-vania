import 'package:vania/vania.dart';

class Customers extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('customers', () {
      char('cust_id', unique: true);
      primary('customer_id');
      string('customer_name', length: 50);
      string('customer_address', length: 50);
      string('customer_city', length: 20);
      string('customer_state', length: 5);
      string('customer_zip', length: 7);
      string('customer_country', length: 25);
      string('customer_telp', length: 15);
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('customers');
  }
}
