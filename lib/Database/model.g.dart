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

class videoplaylistAdapter extends TypeAdapter<videoplaylist> {
  @override
  final int typeId = 2;

  @override
  videoplaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return videoplaylist(
      name: fields[0] as String,
      videos: (fields[1] as List?)?.cast<dynamic>(),
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, videoplaylist obj) {
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
      other is videoplaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class videofavoriteAdapter extends TypeAdapter<videofavorite> {
  @override
  final int typeId = 3;

  @override
  videofavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return videofavorite(
      Favoritevideo: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, videofavorite obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.Favoritevideo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is videofavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
