class_name PcFov
extends Node2D


const NO_FOV: bool = false
const MEMORY_TAGS: Array = [
    MainTag.GROUND,
    MainTag.BUILDING,
    MainTag.TRAP,
]


var _fov_map: Dictionary
var _memory_map: Dictionary
var _pc: Sprite2D
var _cross_fov_data: CrossFov.FovData
var _shadow_cast_fov_data: ShadowCastFov.FovData


func _ready() -> void:
    _fov_map = Map2D.init_map(false)
    _memory_map = Map2D.init_map(false)
    _cross_fov_data = CrossFov.FovData.new(
        GameData.CROSS_FOV_WIDTH,
        GameData.PC_AIM_RANGE,
        GameData.PC_AIM_RANGE,
        GameData.PC_AIM_RANGE,
        GameData.PC_AIM_RANGE
    )
    _shadow_cast_fov_data = ShadowCastFov.FovData.new()
    _shadow_cast_fov_data.octatnt_0 = true
    _shadow_cast_fov_data.octatnt_1 = true
    _shadow_cast_fov_data.octatnt_2 = true
    _shadow_cast_fov_data.octatnt_3 = true
    _shadow_cast_fov_data.octatnt_4 = true
    _shadow_cast_fov_data.octatnt_5 = true
    _shadow_cast_fov_data.octatnt_6 = true
    _shadow_cast_fov_data.octatnt_7 = true


func render_fov(is_aiming: bool) -> void:
    if NO_FOV:
        return

    var pc_coord: Vector2i = ConvertCoord.get_coord(_pc)

    if is_aiming:
        CrossFov.get_fov_map(pc_coord, GameData.PC_AIM_RANGE,
                GameData.CROSS_FOV_WIDTH, _block_cross_fov_ray, [], _fov_map,
                _cross_fov_data)
    else:
        ShadowCastFov.get_fov_map(pc_coord, GameData.PC_SIGHT_RANGE,
                _block_cross_fov_ray, [], _fov_map, _shadow_cast_fov_data)
        # DiamondFov.get_fov_map(pc_coord, GameData.PC_SIGHT_RANGE, _fov_map)
    DungeonSize.iterate_dungeon(_set_color, [_fov_map])
    # DungeonSize.iterate_dungeon(_set_visibility, [_fov_map, _memory_map,
            # MEMORY_TAGS])


func _set_color(coord: Vector2i, args: Array) -> void:
    var fov_map: Dictionary = args[0]
    FovHelper.set_color(coord, fov_map)


func _set_visibility(coord: Vector2i, args: Array) -> void:
    var fov_map: Dictionary = args[0]
    var memory_map: Dictionary = args[1]
    var memory_tags: Array = args[2]

    FovHelper.set_visibility(coord, fov_map, memory_map, memory_tags)


func _block_cross_fov_ray(_pc_coord: Vector2i, coord: Vector2i, _args: Array) \
        -> bool:
    if DungeonSize.is_in_dungeon(coord):
        return SpriteStateHelper.has_building_at_coord(coord) \
                or SpriteStateHelper.has_actor_at_coord(coord)
    return true
