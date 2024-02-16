class_name GameProgress
extends Node2D


signal game_over(player_win: bool)


var _ref_RandomNumber: RandomNumber

var _respawn_duration: int = GameData.MAX_RESPAWN_DURATION
var _grounds: Array = []
var _ground_index: int = 0


func try_respawn_npc(pc: Sprite2D) -> void:
    var index: int
    var coord: Vector2i

    _respawn_duration -= 1
    if _respawn_duration >= 0:
        return

    _respawn_duration = GameData.MAX_RESPAWN_DURATION
    if _count_npc() >= GameData.MAX_ENEMY_COUNT:
        return

    _init_grids(_grounds, _ref_RandomNumber)
    index = _get_grid_index(_grounds, _ground_index, ConvertCoord.get_coord(pc))
    coord = _grounds[index]
    _ground_index = index + 1
    SpriteFactory.create_actor(SubTag.GRUNT, coord)


func _count_npc() -> int:
    var actors: Array = SpriteStateHelper.get_sprites_by_tag(MainTag.ACTOR, "")
    var count: int = 0

    for i: Sprite2D in actors:
        if i.is_in_group(SubTag.PC):
            continue
        count += 1
    return count


func _init_grids(grids: Array, random: RandomNumber) -> void:
    if grids.size() > 0:
        return

    var coord: Vector2i = Vector2i(0, 0)

    for x: int in range(0, DungeonSize.MAX_X):
        for y: int in range(0, DungeonSize.MAX_Y):
            coord.x = x
            coord.y = y
            if SpriteStateHelper.has_building_at_coord(coord):
                continue
            grids.push_back(coord)
    ArrayHelper.shuffle(grids, random)


func _get_grid_index(grids: Array, index: int, pc_coord: Vector2i) -> int:
    var coord: Vector2i
    var new_index: int = index

    while true:
        if new_index > grids.size():
            ArrayHelper.shuffle(grids, _ref_RandomNumber)
            new_index = 0

        coord = grids[new_index]
        if ConvertCoord.is_in_range(pc_coord, coord,
                GameData.MIN_DISTANCE_TO_PC) or \
                SpriteStateHelper.has_actor_at_coord(coord):
            new_index += 1
        else:
            break
    return new_index
