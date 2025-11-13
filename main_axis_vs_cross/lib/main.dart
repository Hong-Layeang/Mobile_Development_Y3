// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Main vs Cross Axis Demo',
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: const AlignmentDemoPage(),
//     );
//   }
// }

// /// A small interactive demo that shows differences between
// /// Column.mainAxisAlignment (controls vertical spacing) and
// /// Column.crossAxisAlignment (controls horizontal alignment).
// class AlignmentDemoPage extends StatefulWidget {
//   const AlignmentDemoPage({super.key});

//   @override
//   State<AlignmentDemoPage> createState() => _AlignmentDemoPageState();
// }

// class _AlignmentDemoPageState extends State<AlignmentDemoPage> {
//   MainAxisAlignment _main = MainAxisAlignment.start;
//   CrossAxisAlignment _cross = CrossAxisAlignment.start;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Column: mainAxis vs crossAxis'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Controls
//             Wrap(
//               spacing: 12,
//               runSpacing: 8,
//               crossAxisAlignment: WrapCrossAlignment.center,
//               children: [
//                 const Text('Main Axis (vertical):'),
//                 DropdownButton<MainAxisAlignment>(
//                   value: _main,
//                   items: const [
//                     DropdownMenuItem(value: MainAxisAlignment.start, child: Text('start')),
//                     DropdownMenuItem(value: MainAxisAlignment.center, child: Text('center')),
//                     DropdownMenuItem(value: MainAxisAlignment.end, child: Text('end')),
//                     DropdownMenuItem(value: MainAxisAlignment.spaceBetween, child: Text('spaceBetween')),
//                     DropdownMenuItem(value: MainAxisAlignment.spaceAround, child: Text('spaceAround')),
//                     DropdownMenuItem(value: MainAxisAlignment.spaceEvenly, child: Text('spaceEvenly')),
//                   ],
//                   onChanged: (v) => setState(() => _main = v!),
//                 ),

//                 const SizedBox(width: 24),

//                 const Text('Cross Axis (horizontal):'),
//                 DropdownButton<CrossAxisAlignment>(
//                   value: _cross,
//                   items: const [
//                     DropdownMenuItem(value: CrossAxisAlignment.start, child: Text('start')),
//                     DropdownMenuItem(value: CrossAxisAlignment.center, child: Text('center')),
//                     DropdownMenuItem(value: CrossAxisAlignment.end, child: Text('end')),
//                     DropdownMenuItem(value: CrossAxisAlignment.stretch, child: Text('stretch')),
//                   ],
//                   onChanged: (v) => setState(() => _cross = v!),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             // Short explanation
//             Text(
//               'Column: mainAxis is vertical (so mainAxisAlignment controls vertical spacing).\n'
//               'Cross axis is horizontal (so crossAxisAlignment controls horizontal alignment).',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),

//             const SizedBox(height: 16),

//             // Demo area with a fixed height so spacing is visible
//             Container(
//               padding: const EdgeInsets.all(8),
//               color: Colors.indigo.shade50,
//               width: double.infinity,
//               height: 320,
//               child: Column(
//                 // Apply the selected alignments here
//                 mainAxisAlignment: _main,
//                 crossAxisAlignment: _cross,
//                 children: _buildDemoChildren(_cross),
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Show the currently-selected enumerations
//             Text('Selected mainAxisAlignment: $_main'),
//             Text('Selected crossAxisAlignment: $_cross'),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildDemoChildren(CrossAxisAlignment cross) {
//     // We build three colored boxes. When crossAxisAlignment == stretch
//     // we let the boxes take the available width (width: double.infinity).
//     // Otherwise we give them fixed widths so you can see left/center/right alignment.
//     final bool stretch = cross == CrossAxisAlignment.stretch;

//     Widget box(Color color, {double? width}) {
//       return Container(
//         width: stretch ? double.infinity : width,
//         height: 48,
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           stretch ? 'stretched' : (width != null ? '${width.toInt()} px' : 'box'),
//           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       );
//     }

//     return [
//       box(Colors.red, width: 80),
//       box(Colors.green, width: 120),
//       box(Colors.blue, width: 60),
//     ];
//   }
// }

import 'package:flutter/material.dart';

void main() => runApp(const AlignmentDemo());

class AlignmentDemo extends StatefulWidget {
  const AlignmentDemo({super.key});
  @override
  State<AlignmentDemo> createState() => _AlignmentDemoState();
}

class _AlignmentDemoState extends State<AlignmentDemo> {
  bool isRow = true;
  MainAxisAlignment mainAxis = MainAxisAlignment.center;
  CrossAxisAlignment crossAxis = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Axis Alignment Demo')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(isRow ? 'Row layout' : 'Column layout'),
                value: isRow,
                onChanged: (v) => setState(() => isRow = v),
              ),
              Expanded(
                child: Container(
                  color: Colors.indigo.shade50,
                  child: isRow
                      ? Row(
                          mainAxisAlignment: mainAxis,
                          crossAxisAlignment: crossAxis,
                          children: _demoBoxes(isRow),
                        )
                      : Column(
                          mainAxisAlignment: mainAxis,
                          crossAxisAlignment: crossAxis,
                          children: _demoBoxes(isRow),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Text('mainAxisAlignment: $mainAxis'),
              Text('crossAxisAlignment: $crossAxis'),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _demoBoxes(bool isRow) => [
        _box(Colors.red),
        _box(Colors.green),
        _box(Colors.blue),
      ];

  Widget _box(Color color) => Container(
        width: 70,
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      );
}