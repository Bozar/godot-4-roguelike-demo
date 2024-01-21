class_name Schedule
extends Node2D


var _linked_sprites: Dictionary = {}
var _next_id: int
var _global_timer: Sprite2D


func init_schedule() -> void:
    var tagged_timer: TaggedSprite = CreateSprite.create(MainTag.INDICATOR,
            SubTag.TIMER, Vector2i(0, 0))
    var id: int = tagged_timer.sprite.get_instance_id()

    _global_timer = tagged_timer.sprite
    _linked_sprites[id] = LinkedSprite.new(_global_timer, id, id)
    SpriteFactory.create_sprites([tagged_timer])


func start_first_turn() -> void:
    var pc_sprite: Sprite2D = SearchHelper.get_sprites_by_tag("", SubTag.PC)[0]
    _next_id = pc_sprite.get_instance_id()
    #TODO: Emit a signal.


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
                if (i.sprite == _global_timer):
                    continue
                elif i.sub_tag == SubTag.TIMER:
                    _insert_linked_sprite(i.sprite)


func _on_SpriteFactory_sprite_removed(sprites: Array[Sprite2D]) -> void:
    for i: Sprite2D in sprites:
        if _has_sprite(i):
            _remove_linked_sprite(i)
    print_linked_sprites()


func _insert_linked_sprite(new_sprite: Sprite2D, before_this: Sprite2D = null) \
        -> void:
    if _has_sprite(new_sprite):
        push_error("Duplicated linked sprite: %s." % [new_sprite.name])
        return

    var next_sprite: Sprite2D = _get_valid_sprite(before_this)
    var next_linked: LinkedSprite = _get_linked_sprite(next_sprite)
    var previous_linked: LinkedSprite = _linked_sprites[next_linked.previous_id]
    var new_linked: LinkedSprite = LinkedSprite.new(new_sprite,
            next_linked.previous_id, previous_linked.next_id)

    _linked_sprites[new_linked.self_id] = new_linked
    previous_linked.next_id = new_linked.self_id
    next_linked.previous_id = new_linked.self_id


func _append_linked_sprite(new_sprite: Sprite2D, after_this: Sprite2D = null) \
        -> void:
    var previous_sprite: Sprite2D = _get_valid_sprite(after_this)
    var previous_linked: LinkedSprite = _get_linked_sprite(previous_sprite)
    var next_linked: LinkedSprite = _linked_sprites[previous_linked.next_id]
    _insert_linked_sprite(new_sprite, next_linked.sprite)


func _remove_linked_sprite(sprite: Sprite2D) -> void:
    var linked: LinkedSprite = _get_linked_sprite(sprite)
    var previous_linked: LinkedSprite = _linked_sprites[linked.previous_id]
    var next_linked: LinkedSprite = _linked_sprites[linked.next_id]
    var __: int

    if _next_id == linked.self_id:
        _next_id = linked.next_id
    previous_linked.next_id = linked.next_id
    next_linked.previous_id = linked.previous_id
    __ = _linked_sprites.erase(linked.self_id)


func _get_linked_sprite(sprite: Sprite2D) -> LinkedSprite:
    var linked: LinkedSprite = _linked_sprites.get(sprite.get_instance_id(),
            null)
    if linked == null:
        push_error("Sprite not found: %s." % [sprite.name])
    return linked


func _get_valid_sprite(sprite: Sprite2D) -> Sprite2D:
    return _global_timer if (sprite == null) else sprite


func _has_sprite(sprite: Sprite2D) -> bool:
    return _linked_sprites.has(sprite.get_instance_id())


func _point_to_next_sprite() -> Sprite2D:
    var linked: LinkedSprite = _linked_sprites[_next_id]
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
