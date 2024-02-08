class_name ActorAction
extends Node2D


var _pc: Sprite2D
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
    var actor_coord: Vector2i = ConvertCoord.get_coord(sprite)
    var pc_coord: Vector2i = ConvertCoord.get_coord(_pc)
    var distanct_to_pc: int

    if actor_state == null:
        return

    if actor_state.hit_damage == 1:
        VisualEffect.switch_sprite(sprite, VisualTag.DEFAULT)
    actor_state.hit_damage -= 1
    if actor_state.hit_damage > 0:
        return

    # TODO: Boss can always see PC.
    distanct_to_pc = ConvertCoord.get_range(actor_coord, pc_coord)
    if distanct_to_pc == 1:
        _hit_pc()
    elif distanct_to_pc <= GameData.NPC_SIGHT_RANGE:
        _approach_pc(sprite, pc_coord)
    # TODO: Move towards gunshot location.


func _on_SpriteFactory_sprite_created(sprites: Array[TaggedSprite]) -> void:
    var id: int

    for i: TaggedSprite in sprites:
        if not i.main_tag == MainTag.ACTOR:
            continue
        if i.sub_tag == SubTag.PC:
            _pc = i.sprite
        else:
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
    if (not sprite.is_in_group(MainTag.ACTOR)) or sprite.is_in_group(SubTag.PC):
        return

    var id: int = sprite.get_instance_id()

    if _actor_states.has(id):
        return _actor_states[id]
    push_error("Actor not found: %s." % [sprite.name])
    return null


func _hit_pc() -> void:
    # TODO: End game.
    print("hit")
    pass


func _approach_pc(sprite: Sprite2D, pc_coord: Vector2i) -> void:
    print("Approach: %s, %s." % [sprite.name, pc_coord])
    pass
