class_name ActorAction
extends Node2D


var _actor_states: Dictionary = {}


func hit_actor(sprite: Sprite2D) -> void:
    var actor_state: ActorState = _get_actor_state(sprite)

    if actor_state == null:
        return
    actor_state.hit_damage = GameData.HIT_DAMAGE
    VisualEffect.switch_sprite(sprite, VisualTag.PASSIVE)


func _on_ActorActionHelper_searching_actor_action(search: SearchKeyword) \
        -> void:
    search.actor_action = self
    search.search_is_completed()


func _on_Schedule_turn_started(sprite: Sprite2D) -> void:
    var actor_state: ActorState = _get_actor_state(sprite)

    if actor_state == null:
        return

    if actor_state.hit_damage == 1:
        VisualEffect.switch_sprite(sprite, VisualTag.DEFAULT)
    actor_state.hit_damage -= 1
    if actor_state.hit_damage > 0:
        return


func _on_SpriteFactory_sprite_created(sprites: Array[TaggedSprite]) -> void:
    var id: int

    for i: TaggedSprite in sprites:
        id = i.sprite.get_instance_id()
        _actor_states[id] = ActorState.new()


func _on_SpriteFactory_sprite_removed(sprites: Array[Sprite2D]) -> void:
    var id: int

    for i: Sprite2D in sprites:
        if not i.is_in_group(MainTag.ACTOR):
            continue
        id = i.get_instance_id()
        if not _actor_states.erase(id):
            push_error("Actor not found: %s." % [i.name])


func _get_actor_state(sprite: Sprite2D) -> ActorState:
    var id: int = sprite.get_instance_id()

    if _actor_states.has(id):
        return _actor_states[id]
    push_error("Actor not found: %s." % [sprite.name])
    return null
