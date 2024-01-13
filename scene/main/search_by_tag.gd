class_name SearchByTag
extends Node2D


func get_sprites_by_tag(main_tag: StringName, sub_tag: StringName) -> Array:
    var sprites: Array

    if sub_tag == "":
        if main_tag == "":
            push_error("Neither main_tag nor sub_tag is provided.")
            return []
        sprites = get_tree().get_nodes_in_group(main_tag)
    else:
        sprites = get_tree().get_nodes_in_group(sub_tag)
        sprites = ArrayHelper.map(sprites, _has_main_tag, [main_tag])
    sprites = sprites.filter(_is_not_queued_for_deletion)
    return sprites


func _has_main_tag(sprite: Sprite2D, filter_args: Array) -> bool:
    var main_tag: StringName = filter_args[0]
    if main_tag == "":
        return true
    return sprite.is_in_group(main_tag)


func _is_not_queued_for_deletion(sprite: Sprite2D) -> bool:
    return not sprite.is_queued_for_deletion()
