class_name PcAction
extends Node2D


var ammo: int:
    set(value):
        ammo = max(min(value, GameData.MAX_AMMO), GameData.MIN_AMMO)


var _pc: Sprite2D


func _ready() -> void:
    ammo = GameData.MIN_AMMO


func _on_SpriteFactory_sprite_created(sprites: Array[TaggedSprite]) -> void:
    for i:TaggedSprite in sprites:
        if i.sub_tag == SubTag.PC:
            _pc = i.sprite
            break


func _on_PcActionHelper_searching_pc_action(search: SearchKeyword) -> void:
    search.pc_action = self
    search.search_is_completed()


func _on_PlayerInput_pc_moved(direction: StringName) -> void:
    var coord: Vector2i = ConvertCoord.get_coord(_pc)

    match direction:
        InputTag.MOVE_LEFT:
            coord += Vector2i.LEFT
        InputTag.MOVE_RIGHT:
            coord += Vector2i.RIGHT
        InputTag.MOVE_UP:
            coord += Vector2i.UP
        InputTag.MOVE_DOWN:
            coord += Vector2i.DOWN

    if not _is_reachable(coord):
        return
    elif SearchHelper.has_building_at_coord(coord):
        return
    elif SearchHelper.has_trap_at_coord(coord):
        _pick_ammo(coord)
        return
    elif SearchHelper.has_actor_at_coord(coord):
        _hit_grunt(coord)
        return

    MoveSprite.move(_pc, coord)
    ammo -= 1
    ScheduleHelper.end_turn()


func _is_reachable(coord: Vector2i) -> bool:
    if DungeonSize.is_insided_dungeon(coord):
        return true
    return false


func _pick_ammo(coord: Vector2i) -> void:
    SpriteFactory.remove_sprite(SearchHelper.get_trap_by_coord(coord))
    ammo += GameData.MAX_AMMO
    MoveSprite.move(_pc, coord)
    ScheduleHelper.end_turn()


func _hit_grunt(coord: Vector2i) -> void:
    print("Grunt: %d, %d" % [coord.x, coord.y])
