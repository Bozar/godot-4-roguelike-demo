class_name InitWorld
extends Node2D


signal sprites_created(sprites: Array[TaggedSprite])


const INDICATOR_OFFSET: int = 32


var _tagged_sprites: Array[TaggedSprite] = []


func create_world() -> void:
    var pc_coord: Vector2i

    pc_coord = _create_pc()
    _create_floor()
    _create_indicator(pc_coord)

    sprites_created.emit(_tagged_sprites)
    _tagged_sprites.clear()


func _create_pc() -> Vector2i:
    var pc_coord: Vector2i = Vector2i(0, 0)
    _tagged_sprites.push_back(CreateSprite.create_actor(SubTag.PC, pc_coord))
    return pc_coord


func _create_floor() -> void:
    for x: int in range(0, DungeonSize.MAX_X):
        for y: int in range(0, DungeonSize.MAX_Y):
            _tagged_sprites.push_back(CreateSprite.create_ground(
                    SubTag.DUNGEON_FLOOR, Vector2i(x, y)))


func _create_indicator(coord: Vector2i) -> void:
    var indicators: Dictionary = {
        SubTag.INDICATOR_TOP: [
            Vector2i(coord.x, 0), Vector2i(0, -INDICATOR_OFFSET)
        ],
        SubTag.INDICATOR_BOTTOM: [
            Vector2i(coord.x, DungeonSize.MAX_Y - 1),
            Vector2i(0, INDICATOR_OFFSET)
        ],
        SubTag.INDICATOR_LEFT: [
            Vector2i(0, coord.y), Vector2i(-INDICATOR_OFFSET, 0)
        ],
    }
    var new_coord: Vector2i
    var new_offset: Vector2i

    for i: StringName in indicators:
        new_coord = indicators[i][0]
        new_offset = indicators[i][1]
        _tagged_sprites.push_back(CreateSprite.create(MainTag.INDICATOR,
                i, new_coord, new_offset))
