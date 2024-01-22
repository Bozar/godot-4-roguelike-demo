class_name Schedule
extends Node2D


signal turn_started(sprite: Sprite2D)


var _linked_sprites: Dictionary = {}
var _anchor_id: int
var _next_id: int


func start_first_turn() -> void:
    var pc_sprite: Sprite2D = SearchHelper.get_sprites_by_tag("", SubTag.PC)[0]
    var pc_id: int = pc_sprite.get_instance_id()
    _next_id = pc_id
    _anchor_id = pc_id
    turn_started.emit(_point_to_next_sprite())


func print_linked_sprites() -> void:
    print(_linked_sprites[_next_id].sprite.name)
    for i: LinkedSprite in _linked_sprites.values():
        print("%s -> %s" % [i.sprite.name,
                _linked_sprites[i.next_id].sprite.name])


func _on_SpriteFactory_sprite_created(sprites: Array[TaggedSprite]) -> void:
    for i: TaggedSprite in sprites:
        match i.main_tag:
            MainTag.ACTOR:
                _insert_linked_sprite(i.sprite)
            MainTag.INDICATOR:
                if i.sub_tag == SubTag.TIMER:
                    _insert_linked_sprite(i.sprite)


func _on_SpriteFactory_sprite_removed(sprites: Array[Sprite2D]) -> void:
    for i: Sprite2D in sprites:
        _remove_linked_sprite(i)


func _on_ScheduleHelper_turn_ended() -> void:
    turn_started.emit(_point_to_next_sprite())


func _insert_linked_sprite(new_sprite: Sprite2D, before_this: Sprite2D = null) \
        -> void:
    if _has_sprite(new_sprite):
        push_error("Duplicated linked sprite: %s." % [new_sprite.name])
        return
    elif _linked_sprites.is_empty():
        _init_linked_list(new_sprite)
        return

    var next_sprite: Sprite2D = _get_anchor_sprite(before_this)
    var next_linked: LinkedSprite = _get_linked_by_sprite(next_sprite)
    var previous_linked: LinkedSprite = _get_linked_by_id(
            next_linked.previous_id)
    var new_linked: LinkedSprite = LinkedSprite.new(new_sprite,
            next_linked.previous_id, previous_linked.next_id)

    _linked_sprites[new_linked.self_id] = new_linked
    previous_linked.next_id = new_linked.self_id
    next_linked.previous_id = new_linked.self_id


func _append_linked_sprite(new_sprite: Sprite2D, after_this: Sprite2D = null) \
        -> void:
    var previous_sprite: Sprite2D = _get_anchor_sprite(after_this)
    var previous_linked: LinkedSprite = _get_linked_by_sprite(previous_sprite)
    var next_linked: LinkedSprite = _get_linked_by_id(previous_linked.next_id)
    _insert_linked_sprite(new_sprite, next_linked.sprite)


func _remove_linked_sprite(sprite: Sprite2D) -> void:
    var linked: LinkedSprite = _get_linked_by_sprite(sprite)
    if linked == null:
        return

    var previous_linked: LinkedSprite = _get_linked_by_id(linked.previous_id)
    var next_linked: LinkedSprite = _get_linked_by_id(linked.next_id)
    var __: int

    if _next_id == linked.self_id:
        _next_id = linked.next_id
    if _anchor_id == linked.self_id:
        _anchor_id = linked.next_id
    previous_linked.next_id = linked.next_id
    next_linked.previous_id = linked.previous_id
    __ = _linked_sprites.erase(linked.self_id)


func _init_linked_list(sprite: Sprite2D) -> void:
    var id: int = sprite.get_instance_id()
    _linked_sprites[id] = LinkedSprite.new(sprite, id, id)
    _anchor_id = id


func _get_linked_by_id(id: int) -> LinkedSprite:
    return _linked_sprites.get(id, null)


func _get_linked_by_sprite(sprite: Sprite2D) -> LinkedSprite:
    if sprite == null:
        return null
    return _get_linked_by_id(sprite.get_instance_id())


func _has_sprite(sprite: Sprite2D) -> bool:
    return _get_linked_by_sprite(sprite) != null


func _get_anchor_sprite(sprite: Sprite2D) -> Sprite2D:
    if _has_sprite(sprite):
        return sprite

    var linked: LinkedSprite = _get_linked_by_id(_anchor_id)
    if linked == null:
        return null
    return linked.sprite


func _point_to_next_sprite() -> Sprite2D:
    var linked: LinkedSprite = _get_linked_by_id(_next_id)
    _next_id = linked.next_id
    return linked.sprite


class LinkedSprite:
    var sprite: Sprite2D
    var previous_id: int
    var next_id: int
    var self_id: int:
        get:
            return _self_id

    var _self_id: int


    func _init(sprite_: Sprite2D, previous_id_: int, next_id_: int) -> void:
        sprite = sprite_
        previous_id = previous_id_
        next_id = next_id_
        _self_id = sprite_.get_instance_id()
