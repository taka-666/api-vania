import 'package:vania/vania.dart';

class Orderitem extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orderitems', () {
      primary('order_item');
      bigIncrements('order_item');
      bigInt('order_num', unsigned: true);
      bigInt('prod_id', unsigned: true);
      integer('quantity');
      integer('size');
      timeStamps();

      foreign('order_num', 'orders', 'order_num');
      foreign('prod_id', 'products', 'prod_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orderitems');
  }
}
