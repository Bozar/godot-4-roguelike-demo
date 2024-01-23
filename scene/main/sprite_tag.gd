class_name SpriteTag
extends Node2D


const NO_MAIN_TAG: String = "%s does not have a main tag."
const NO_SUB_TAG: String = "%s does not have a sub tag."


var _main_tags: Dictionary = {}
var _sub_tags: Dictionary = {}
var _is_valid_sprite: Callable


func add_state(sprite: Sprite2D, main_tag: StringName, sub_tag: StringName) \
        -> void:
    var id: int = _get_id(sprite)
    _main_tags[id] = main_tag
    _sub_tags[id] = sub_tag


func remove_state(sprite: Sprite2D) -> void:
    var id: int = _get_id(sprite)

    if not _main_tags.erase(id):
        push_error(NO_MAIN_TAG % sprite.name)
    if not _sub_tags.erase(id):
        push_error(NO_SUB_TAG % sprite.name)


func get_main_tag(sprite: Sprite2D) -> StringName:
    var id: int = _get_id(sprite)

    if _main_tags.has(id):
        return _main_tags[id]
    push_error(NO_MAIN_TAG % sprite.name)
    return ""


func get_sub_tag(sprite: Sprite2D) -> StringName:
    var id: int = _get_id(sprite)

    if _sub_tags.has(id):
        return _sub_tags[id]
    push_error(NO_SUB_TAG % sprite.name)
    return ""


func get_sprites_by_tag(main_tag: StringName, sub_tag: StringName) -> Array:
    var sprites: Array

    if sub_tag == "":
        if main_tag == "":
            push_error("Neither main_tag nor sub_tag is provided.")
            return []
        sprites = get_tree().get_nodes_in_group(main_tag)
    else:
        sprites = get_tree().get_nodes_in_group(sub_tag)
        sprites = ArrayHelper.filter(sprites, _has_main_tag, [main_tag])
    sprites = sprites.filter(_is_valid_sprite)
    return sprites


func _has_main_tag(sprite: Sprite2D, filter_args: Array) -> bool:
    var main_tag: StringName = filter_args[0]
    if main_tag == "":
        return true
    return sprite.is_in_group(main_tag)


func _get_id(sprite: Sprite2D) -> int:
    return sprite.get_instance_id()
