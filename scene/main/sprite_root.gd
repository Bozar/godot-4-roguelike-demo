class_name SpriteRoot
extends Node2D


func _on_InitWorld_sprite_created(sprites: Array[TaggedSprite]) -> void:
    for i: TaggedSprite in sprites:
        add_child(i.sprite)
