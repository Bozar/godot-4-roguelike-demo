class_name PcAction
extends Node2D


var ammo: int:
    set(value):
        ammo = max(min(value, GameData.MAX_AMMO), GameData.MIN_AMMO)


var _pc: Sprite2D
var _is_aiming: bool = false


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


func _on_PlayerInput_action_pressed(input_tag: StringName) -> void:
    var coord: Vector2i = ConvertCoord.get_coord(_pc)

    match input_tag:
        InputTag.AIM:
            _aim(_pc)
            return
        InputTag.MOVE_LEFT:
            coord += Vector2i.LEFT
        InputTag.MOVE_RIGHT:
            coord += Vector2i.RIGHT
        InputTag.MOVE_UP:
            coord += Vector2i.UP
        InputTag.MOVE_DOWN:
            coord += Vector2i.DOWN

    if _is_aiming:
        _shoot(_pc, coord)
    elif not _is_reachable(coord):
        return
    elif SearchHelper.has_building_at_coord(coord):
        return
    elif SearchHelper.has_trap_at_coord(coord):
        _pick_ammo(coord)
    elif SearchHelper.has_actor_at_coord(coord):
        _hit_grunt(coord)
    else:
        _move(_pc, coord)


func _is_reachable(coord: Vector2i) -> bool:
    if DungeonSize.is_insided_dungeon(coord):
        return true
    return false


func _pick_ammo(coord: Vector2i) -> void:
    SpriteFactory.remove_sprite(SearchHelper.get_trap_by_coord(coord))
    ammo += GameData.MAGAZINE
    MoveSprite.move(_pc, coord)
    ScheduleHelper.end_turn()


func _hit_grunt(coord: Vector2i) -> void:
    print("Grunt: %d, %d" % [coord.x, coord.y])


func _move(pc: Sprite2D, coord: Vector2i) -> void:
    MoveSprite.move(pc, coord)
    ScheduleHelper.end_turn()


func _aim(pc: Sprite2D) -> void:
    if _is_aiming:
        VisualEffect.switch_sprite(pc, VisualTag.DEFAULT)
        _is_aiming = false
    elif ammo > GameData.MIN_AMMO:
        VisualEffect.switch_sprite(pc, VisualTag.ACTIVE)
        _is_aiming = true


func _shoot(pc: Sprite2D, coord: Vector2i) -> void:
    print(coord)
    ammo -= 1
    _aim(pc)
    ScheduleHelper.end_turn()
