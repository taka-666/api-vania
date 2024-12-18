import 'package:vania/vania.dart';

class Orders extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orders', () {
      primary('order_num');
      bigIncrements('order_num');
      bigInt('cust_id', unsigned: true);
      dateTime('order_date');
      timeStamps();
      foreign('cust_id', 'customers', 'cust_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orders');
  }
}
