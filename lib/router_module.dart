import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/clients/presentation/pages/clients_page.dart';
import 'features/login/presentation/pages/login_page.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => <Bind<Object>>[];

  @override
  List<ModularRoute> get routes => <ModularRoute>[
        ChildRoute<dynamic>(LoginPage.routeName,
            child: (BuildContext context, dynamic args) => const LoginPage()),
        ChildRoute<dynamic>(
          ClientsPage.routeName,
          child: (BuildContext context, dynamic args) => const ClientsPage(),
        ),
      ];
}
