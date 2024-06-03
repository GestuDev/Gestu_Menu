# Gestu Menu

Gestu Menu es un paquete Flutter que proporciona un menú personalizable y animado con elementos principales y secundarios.

## Características

- Elementos de menú primarios y secundarios.
- Soporte para iconos prefijo y sufijo.
- Colores personalizables para elementos seleccionados.
- Expandir y contraer animado.

## Instalación

Agrega `gestu_menu` a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  gestu_menu: ^0.0.1
```

Ejecuta `flutter pub get` para instalar el paquete.

## Uso

```dart
import 'package:flutter/material.dart';
import 'package:gestu_menu/gestu_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestu Menu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo Menu Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          GestuMenuPrimaryItem<String>(
            title: 'Main Option',
            prefixIconData: Icons.space_dashboard_outlined,
            expandedIndicatorRight: true,
            onTap: (value) {
              debugPrint('action button: $value');
            },
            items: const [
              GestuMenuSecondaryItemWidget(
                prefixIconData: Icons.bubble_chart,
                title: 'Menu Item Selected',
                counter: 1,
                isSelected: true,
                index: 'hola',
                // onTap: (value) {},
              ),
              GestuMenuSecondaryItemWidget(
                prefixIconData: Icons.bar_chart_outlined,
                title: 'Menu Item',
                counter: 2,
                index: 'Adios',
                // onTap: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                GestuMenuPrimaryItem(
                  title: 'First Option',
                  prefixIconData: Icons.dashboard,
                  expandedIndicatorRight: true,
                  items: [
                    GestuMenuSecondaryItemWidget(
                      prefixIconData: Icons.bubble_chart,
                      title: 'Menu Item Selected',
                      counter: 1,
                      isSelected: true,
                      index: 1,
                      onTap: (value) {},
                    ),
                    GestuMenuSecondaryItemWidget(
                      prefixIconData: Icons.bar_chart_outlined,
                      title: 'Menu Item',
                      counter: 2,
                      index: 2,
                      onTap: (value) {},
                    ),
                  ],
                ),
                GestuMenuPrimaryItem(
                  title: 'Second Option',
                  prefixIconData: Icons.security_outlined,
                  expandedIndicatorRight: true,
                  items: [
                    GestuMenuSecondaryItemWidget(
                      prefixIconData: Icons.developer_board,
                      title: 'Menu Item',
                      suffixIconData: Icons.check_box,
                      index: 1,
                      onTap: (value) {},
                    ),
                    GestuMenuSecondaryItemWidget(
                      prefixIconData: Icons.developer_mode,
                      title: 'Menu Item',
                      suffixIconData: Icons.check_box_outline_blank,
                      index: 2,
                      onTap: (value) {},
                    ),
                  ],
                ),
                GestuMenuSecondaryItemWidget(
                  isPrimary: true,
                  prefixIconData: Icons.verified_user,
                  title: 'Third Option',
                  index: 2,
                  onTap: (value) {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
```