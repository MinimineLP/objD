

import 'package:meta/meta.dart';
import 'package:objd/basic/command.dart';
import 'package:objd/basic/entity.dart';
import 'package:objd/basic/widget.dart';
import 'package:objd/build/context.dart';

class Effect extends Widget {

  EffectType effect;
  Entity entity;
  int duration;
  int amplifier;
  bool showParticles;
  String _type;
  /// This command is used to give an entity a specific effect and affect their gameplay.
  /// ```dart
/// Effect(
/// 	EffectType.jump_boost,
/// 	entity: Entity.Player(),
/// 	duration: 20,
/// 	amplifier: 3,
/// 	showParticles: false
/// )
/// ⇒ effect give @p minecraft:jump_boost 20 3 true
/// ```
  Effect(this.effect,{@required this.entity,this.duration = 30,this.amplifier = 1,this.showParticles = true}){
    _type = "give";
  }
/// You can clear an effect again.
/// ```dart
/// Effect.clear(Entity.Player(),EffectType.jump_boost)
/// ⇒ effect clear @p minecraft:jump_boost
/// ```
  Effect.clear(this.entity,[this.effect]){
    _type = "clear";
  }

  @override
  Widget generate(Context context) {
    if(_type == "clear"){
      return Command("effect clear ${entity}" + (effect != null ? " minecraft:" + effect.toString().split(".")[1] : ""));
    } else {
      return Command("effect give ${entity} minecraft:" + effect.toString().split(".")[1] + " ${duration} ${amplifier} ${!showParticles}");
    }
  }
}

enum EffectType {
  absorption,
  unluck,
  luck,
  blindness,
  conduit_power,
  dolphins_grace,
  fire_resistance,
  glowing,
  haste,
  health_boost,
  hunger,
  instant_damage,
  instant_health,
  jump_boost,
  levitation,
  mining_fatigue,
  nausea,
  night_vision,
  poison,
  regeneration,
  resistance,
  saturation,
  slow_falling,
  slowness,
  speed,
  strength,
  water_breathing,
  weakness,
  wither
}