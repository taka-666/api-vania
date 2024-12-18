import 'dart:io';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'create_product_table.dart';
import 'customers.dart';
import 'orderitem.dart';
import 'orders.dart';
import 'productnotes.dart';
import 'activity_user.dart';
import 'token.dart';
import 'users.dart';
import 'vendors.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
    await CreateUsersTable().up();
    await CreateProductsTable().up();
    await Customers().up();
    await Orderitem().up();
    await Orders().up();
    await Productnotes().up();
    await ActivityUser().up();
    await Token().up();
    await Users().up();
    await CreateProductsTable().up();
  }

  dropTables() async {
    await CreateProductsTable().down();
    await Users().down();
    await Token().down();
    await ActivityUser().down();
    await Productnotes().down();
    await Orders().down();
    await Orderitem().down();
    await Customers().down();
    await CreateUsersTable().down();
    await CreateProductsTable().down();
    await CreateUsersTable().down();
  }
}
