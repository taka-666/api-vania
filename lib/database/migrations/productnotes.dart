import 'package:vania/vania.dart';

class Productnotes extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('productnotes', () {
      primary('note_id');
      bigIncrements('note_id');
      bigInt('prod_id', unsigned: true);
      dateTime('note_date');
      text('note_text');
      timeStamps();

      foreign('prod_id', 'products', 'prod_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('productnotes');
  }
}
