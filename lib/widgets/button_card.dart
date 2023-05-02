import 'dart:async';

import 'package:alisthelper/provider/alist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MultiButtonCard extends ConsumerWidget {
  const MultiButtonCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alistState = ref.watch(alistProvider);
    final alistNotifier = ref.read(alistProvider.notifier);

    Future<void> openAList() async {
      final Uri url = Uri.parse(alistState.url);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch the $url');
      }
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        children: [
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 10.0,
              spacing: 10.0,
              children: [
                ElevatedButton(
                    onPressed: alistState.isRunning
                        ? null
                        : () => alistNotifier.startAlist(),
                    child: const Text('Run')),
                ElevatedButton(
                    onPressed: alistState.isRunning
                        ? () => alistNotifier.endAlist()
                        : null,
                    child: const Text('End')),
                ElevatedButton(
                    onPressed: alistState.isRunning ? openAList : null,
                    child: const Text('Open GUI')),
                ElevatedButton(
                    onPressed: () => alistNotifier.getAlistAdmin(),
                    child: const Text('Admin')),
                ElevatedButton(
                    onPressed: () => alistNotifier.getAlistCurrentVersion(addToOutput:true),
                    child: const Text('Version')),
              ],
            ),
          ),
          Container(height: 10),
        ],
      ),
    );
  }
}
