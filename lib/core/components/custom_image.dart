import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:testador/features/quiz/data/datasources/image_data_source.dart';

// class CustomImageWidget extends StatelessWidget {
//   final String id;
//   const CustomImageWidget(this.id, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: ImageDataSource().getImageById(id),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return Center(child: CircularProgressIndicator());
//           case ConnectionState.none:
//             return Center(child: CircularProgressIndicator());
//           default:
//             final file = snapshot.data;
//             if (file == null) {
//               return Center(child: Text("no image"));
//             }
//             return Image.file(file);
//         }
//       },
//     );
//   }
// }

class CustomImageProvider extends ImageProvider<CustomImageProvider> {
  final String tag; //the cache id use to get cache

  CustomImageProvider(this.tag);

  @override
  ImageStreamCompleter load(CustomImageProvider key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(decode),
      scale: 1.0,
      debugLabel: tag,
      informationCollector: () sync* {
        yield ErrorDescription('Tag: $tag');
      },
    );
  }

  Future<Codec> _loadAsync(DecoderCallback decode) async {
    // the DefaultCacheManager() encapsulation, it get cache from local
    // storage.
    final file = await ImageDataSource().getImageById(tag);

    final Uint8List? bytes = file?.readAsBytesSync();
    if ((bytes?.lengthInBytes ?? 0) == 0) {
      // The file may become available later.
      PaintingBinding.instance.imageCache.evict(this);
      throw StateError('Could not find the image based on the tag $tag');
    }

    return await decode(bytes!);
  }

  @override
  Future<CustomImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CustomImageProvider>(this);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    bool res = other is CustomImageProvider && other.tag == tag;
    return res;
  }

  @override
  int get hashCode => tag.hashCode;

  @override
  String toString() =>
      '${objectRuntimeType(this, 'CacheImageProvider')}("$tag")';
}
