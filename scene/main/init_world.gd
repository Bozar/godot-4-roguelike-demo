class_name InitWorld
extends Node2D


signal sprites_created(sprites: Array[TaggedSprite])


var _tagged_sprites: Array[TaggedSprite] = []


func create_world() -> void:
    _create_pc()
    _create_floor()

    sprites_created.emit(_tagged_sprites)
    _tagged_sprites.clear()


func _create_pc() -> void:
    _tagged_sprites.push_back(CreateSprite.create_actor(SubTag.PC,
            Vector2i(0, 0)))


func _create_floor() -> void:
    for x: int in range(0, DungeonSize.MAX_X):
        for y: int in range(0, DungeonSize.MAX_Y):
            _tagged_sprites.push_back(CreateSprite.create_ground(
                    SubTag.DUNGEON_FLOOR, Vector2i(x, y)))
