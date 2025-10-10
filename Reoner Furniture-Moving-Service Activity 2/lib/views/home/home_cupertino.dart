import 'package:flutter/cupertino.dart';

import '../../services/fake_services.dart';
import '../../widgets/primary_button.dart';
import '../screens/counter_page.dart';
import '../screens/hello_page.dart';
import '../screens/second_activity_page.dart';

class HomeCupertino extends StatefulWidget {
  final VoidCallback onTogglePlatform;
  const HomeCupertino({super.key, required this.onTogglePlatform});

  @override
  State<HomeCupertino> createState() => _HomeCupertinoState();
}

class _HomeCupertinoState extends State<HomeCupertino> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final services = const MovingServicesRepository().fetchAll();
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.hand_thumbsup), label: 'Hello'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.plus), label: 'Counter'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_grid_2x2), label: 'Moving Service'),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: const Text('Furniture Moving'),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: widget.onTogglePlatform,
                    child: const Icon(CupertinoIcons.device_phone_portrait),
                  ),
                ),
                child: SafeArea(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, i) {
                      final s = services[i];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${s.iconEmoji}  ${s.name}'),
                            PrimaryButton(label: 'Book', onPressed: () {}, cupertino: true),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemCount: services.length,
                  ),
                ),
              );
            case 1:
              return const HelloPage(cupertino: true);
            case 2:
              return const CounterPage(cupertino: true);
            default:
              return const SecondActivityPage(cupertino: true);
          }
        },
      ),
    );
  }
}