import 'package:easy_localization/easy_localization.dart';

import '../../../generated/local_keys.g.dart';
import '../../style/app_emotes.dart';

class TagMap {
  static final Map<String, String> tagObjects = {
    LocaleKeys.emotes_Action.tr(): AppEmotes.helicopter,
    LocaleKeys.emotes_Adventure.tr(): AppEmotes.worldMap,
    LocaleKeys.emotes_Animation.tr(): AppEmotes.personJuggling,
    LocaleKeys.emotes_Comedy.tr(): AppEmotes.faceWithTearsOfJoy,
    LocaleKeys.emotes_Crime.tr(): AppEmotes.kitchenKnife,
    LocaleKeys.emotes_Documentary.tr(): AppEmotes.filmProjector,
    LocaleKeys.emotes_Drama.tr(): AppEmotes.loudlyCryingFace,
    LocaleKeys.emotes_Family.tr(): AppEmotes.family,
    LocaleKeys.emotes_Fantasy.tr(): AppEmotes.crystalBall,
    LocaleKeys.emotes_History.tr(): AppEmotes.hourglassDone,
    LocaleKeys.emotes_Horror.tr(): AppEmotes.faceScreamingInFear,
    LocaleKeys.emotes_Music.tr(): AppEmotes.saxophone,
    LocaleKeys.emotes_Romance.tr(): AppEmotes.sparklingHeart,
    LocaleKeys.emotes_ScienceFiction.tr(): AppEmotes.alien,
    LocaleKeys.emotes_TVMovie.tr(): AppEmotes.popcorn,
    LocaleKeys.emotes_Thriller.tr(): AppEmotes.detective,
    LocaleKeys.emotes_War.tr(): AppEmotes.dropOfBlood,
    LocaleKeys.emotes_Western.tr(): AppEmotes.cowboyHatFace,
  };
}
