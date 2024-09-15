import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/artist/artist.dart';

final favoriteArtistsProvider = StateProvider<List<Artist>>((ref) => []);
