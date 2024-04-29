// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideohiveAdapter extends TypeAdapter<Videohive> {
  @override
  final int typeId = 1;

  @override
  Videohive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Videohive(
      videoFile: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Videohive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.videoFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideohiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoPlaylistAdapter extends TypeAdapter<VideoPlaylist> {
  @override
  final int typeId = 2;

  @override
  VideoPlaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoPlaylist(
      name: fields[0] as String,
      videos: (fields[1] as List?)?.cast<dynamic>(),
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, VideoPlaylist obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.videos)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoPlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideofavoriteAdapter extends TypeAdapter<Videofavorite> {
  @override
  final int typeId = 3;

  @override
  Videofavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Videofavorite(
      favoritevideo: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Videofavorite obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.favoritevideo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideofavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SongHiveAdapter extends TypeAdapter<SongHive> {
  @override
  final int typeId = 4;

  @override
  SongHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongHive(
      songfile: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SongHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavoriteSongAdapter extends TypeAdapter<FavoriteSong> {
  @override
  final int typeId = 5;

  @override
  FavoriteSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteSong(
      favoritesong: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteSong obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.favoritesong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SongplaylistAdapter extends TypeAdapter<Songplaylist> {
  @override
  final int typeId = 6;

  @override
  Songplaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Songplaylist(
      songpath: fields[0] as String,
      songs: (fields[1] as List?)?.cast<dynamic>(),
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Songplaylist obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.songpath)
      ..writeByte(1)
      ..write(obj.songs)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongplaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentlyplayedvideoAdapter extends TypeAdapter<Recentlyplayedvideo> {
  @override
  final int typeId = 7;

  @override
  Recentlyplayedvideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recentlyplayedvideo(
      videoPath: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Recentlyplayedvideo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.videoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyplayedvideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentlyplayedSongAdapter extends TypeAdapter<RecentlyplayedSong> {
  @override
  final int typeId = 8;

  @override
  RecentlyplayedSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyplayedSong(
      SongPath: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyplayedSong obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.SongPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyplayedSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
