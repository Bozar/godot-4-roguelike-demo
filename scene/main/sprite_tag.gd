class_name SpriteTag
extends Node2D


const NO_MAIN_TAG: String = "%s does not have a main tag."
const NO_SUB_TAG: String = "%s does not have a sub tag."


var _main_tags: Dictionary = {}
var _sub_tags: Dictionary = {}


func add_state(sprite: Sprite2D, main_tag: StringName, sub_tag: StringName) \
        -> void:
    var id: int = sprite.get_instance_id()

    _main_tags[id] = main_tag
    _sub_tags[id] = sub_tag


func remove_state(sprite: Sprite2D) -> void:
    var id: int = sprite.get_instance_id()

    if not _main_tags.erase(id):
        push_error(NO_MAIN_TAG % sprite.name)
    if not _sub_tags.erase(id):
        push_error(NO_SUB_TAG % sprite.name)


func get_main_tag(sprite: Sprite2D) -> StringName:
    var id: int = sprite.get_instance_id()

    if _main_tags.has(id):
        return _main_tags[id]
    push_error(NO_MAIN_TAG % sprite.name)
    return ""


func get_sub_tag(sprite: Sprite2D) -> StringName:
    var id: int = sprite.get_instance_id()

    if _sub_tags.has(id):
        return _sub_tags[id]
    push_error(NO_SUB_TAG % sprite.name)
    return ""
