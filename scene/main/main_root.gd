class_name MainRoot
extends Node2D


func _ready() -> void:
    @warning_ignore("unsafe_method_access")
    get_node("%InitWorld")["sprites_created"].connect(
            get_node("%SpriteRoot")["_on_InitWorld_sprites_created"])

    (%InitWorld as InitWorld).create_world()
    (%PlayerInput as PlayerInput).set_process_unhandled_input(true)
