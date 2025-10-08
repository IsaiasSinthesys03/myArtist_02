// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/views/views.dart';
import '../../../shared/extensions.dart';
import '../../../shared/playback/bloc/bloc.dart';

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs({
    super.key,
    required this.playlist,
    required this.constraints,
  });

  final Playlist playlist;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTable<Song>(
      items: playlist.songs,
      breakpoint: 450,
      columns: const [
        DataColumn(
          label:
              Padding(padding: EdgeInsets.only(left: 20), child: Text('#')),
        ),
        DataColumn(label: Text('Title')),
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text('Length'),
          ),
        ),
      ],
      rowBuilder: (song, index) => DataRow.byIndex(
        index: index,
        cells: [
          DataCell(
            HoverableSongPlayButton(
              hoverMode: HoverMode.overlay,
              song: song,
              child: const Center(
                child: Text('#', textAlign: TextAlign.center),
              ),
            ),
          ),
          DataCell(
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: ClippedImage(
                    song.image.image,
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(song.title)),
              ],
            ),
          ),
          DataCell(Text(song.length.toHumanizedString())),
        ],
      ),
      itemBuilder: (song, index) {
        return ListTile(
          onTap: () => BlocProvider.of<PlaybackBloc>(
            context,
          ).add(PlaybackEvent.changeSong(song)),
          leading: ClippedImage(
            song.image.image,
            width: 50,
            height: 50,
          ),
          title: Text(song.title),
          subtitle: Text(song.length.toHumanizedString()),
        );
      },
    );
  }
}