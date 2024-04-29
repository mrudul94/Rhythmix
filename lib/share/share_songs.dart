import 'package:share/share.dart';

void shareSongs(String audioPath){
  Share.shareFiles([audioPath]);
}