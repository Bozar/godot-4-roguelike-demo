class_name PcAction
extends Node2D


var ammo: int:
    get:
        return _ammo


var enemy_count: int:
    get:
        return _enemy_count


var progress_bar: int:
    get:
        return _progress_bar


var alert_duration: int:
    get:
        return _alert_duration


var alert_coord: Vector2i:
    get:
        return _alert_coord


var _ref_ActorAction: ActorAction
var _ref_Schedule: Schedule
var _ref_SpriteState: SpriteState

var _pc: Sprite2D
var _is_aiming: bool = false
var _ammo: int = GameData.MIN_AMMO
var _enemy_count: int = GameData.MIN_ENEMY_COUNT
var _progress_bar: int = GameData.MIN_PROGRESS_BAR
var _alert_duration: int = 0
var _alert_coord: Vector2i

@onready var _ref_PcFov: PcFov = $PcFov


func _on_SpriteFactory_sprite_created(sprites: Array[TaggedSprite]) -> void:
    for i:TaggedSprite in sprites:
        if i.sub_tag == SubTag.PC:
            _pc = i.sprite
            _ref_PcFov._pc = _pc
            break


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
    elif not DungeonSize.is_in_dungeon(coord):
        return
    elif SpriteStateHelper.has_building_at_coord(coord):
        return
    # If there is a trap under an actor, hit back the actor rather than pick up
    # the ammo.
    elif SpriteStateHelper.has_actor_at_coord(coord):
        _hit_back(_pc, coord)
    elif SpriteStateHelper.has_trap_at_coord(coord):
        _pick_ammo(coord)
    else:
        _move(_pc, coord)


func _on_Schedule_turn_started(sprite: Sprite2D) -> void:
    if not sprite.is_in_group(SubTag.PC):
        return
    _ref_PcFov.render_fov(_is_aiming)
    _alert_duration = max(0, _alert_duration - 1)


func _pick_ammo(coord: Vector2i) -> void:
    SpriteFactory.remove_sprite(SpriteStateHelper.get_trap_by_coord(coord))
    _ammo = _get_valid_ammo(_ammo + GameData.MAGAZINE)
    _ref_SpriteState.move_sprite(_pc, coord)
    _end_turn()


func _hit_back(pc: Sprite2D, coord: Vector2i) -> void:
    var coords: Array = CastRay.get_coords(ConvertCoord.get_coord(pc), coord,
            _block_hit_ray, [], true, false)
    var target: Vector2i = coords.back()
    var actor: Sprite2D = SpriteStateHelper.get_actor_by_coord(coord)

    if _is_impassable(target):
        target = coords[-2]
        _kill_grunt(actor, target)
    else:
        _ref_SpriteState.move_sprite(actor, target)
        _ref_ActorAction.hit_actor(actor)
    _end_turn()


func _move(pc: Sprite2D, coord: Vector2i) -> void:
    _ref_SpriteState.move_sprite(pc, coord)
    _end_turn()


func _aim(pc: Sprite2D) -> void:
    var render_fov: bool = true

    if _is_aiming:
        VisualEffect.switch_sprite(pc, VisualTag.DEFAULT)
        _is_aiming = false
    elif ammo > GameData.MIN_AMMO:
        VisualEffect.switch_sprite(pc, VisualTag.ACTIVE)
        _is_aiming = true
    else:
        render_fov = false

    if render_fov:
        _ref_PcFov.render_fov(_is_aiming)


func _shoot(pc: Sprite2D, coord: Vector2i) -> void:
    var coords: Array = CastRay.get_coords(ConvertCoord.get_coord(pc), coord,
            _block_shoot_ray, [], true, true)
    var target: Vector2i
    var actor: Sprite2D

    if not coords.is_empty():
        target = coords.back()
        actor = SpriteStateHelper.get_actor_by_coord(target)
        if actor != null:
            _kill_grunt(actor, target)
    _ammo = _get_valid_ammo(_ammo - 1)
    _alert_npc(pc)
    _aim(pc)
    _end_turn()


func _is_impassable(coord: Vector2i) -> bool:
    if not DungeonSize.is_in_dungeon(coord):
        return true
    elif SpriteStateHelper.has_building_at_coord(coord):
        return true
    elif SpriteStateHelper.has_actor_at_coord(coord):
        return true
    return false


func _block_shoot_ray(_from_coord: Vector2i, to_coord: Vector2i,
        _opt_args: Array) -> bool:
    return _is_impassable(to_coord)


func _block_hit_ray(from_coord: Vector2i, to_coord: Vector2i,
        _opt_args: Array) -> bool:
    var ray_length_squared: int = (from_coord - to_coord).length_squared()

    if SpriteStateHelper.has_trap_at_coord(to_coord):
        SpriteFactory.remove_sprite(SpriteStateHelper.get_trap_by_coord(to_coord))

    if ray_length_squared == 1:
        return false
    elif ray_length_squared  > (GameData.HIT_BACK ** 2):
        return true
    return _block_shoot_ray(from_coord, to_coord, _opt_args)


func _kill_grunt(actor: Sprite2D, coord: Vector2i) -> void:
    SpriteFactory.remove_sprite(actor)
    SpriteFactory.create_trap(SubTag.AMMO, coord)
    _add_enemy_count()


func _add_enemy_count() -> void:
    _enemy_count = min(enemy_count + 1, GameData.MAX_ENEMY_COUNT)
    _progress_bar = GameData.MAX_PROGRES_BAR + 1


func _subtract_progress_bar() -> void:
    if _progress_bar > GameData.MIN_PROGRESS_BAR:
        _progress_bar -= 1
    if _progress_bar == GameData.MIN_PROGRESS_BAR:
        _enemy_count = max(enemy_count - 1, GameData.MIN_ENEMY_COUNT)
        if _enemy_count > GameData.MIN_ENEMY_COUNT:
            _progress_bar = GameData.MAX_PROGRES_BAR


func _end_turn() -> void:
    _subtract_progress_bar()
    _ref_Schedule.start_next_turn()


func _alert_npc(pc: Sprite2D) -> void:
    _alert_duration = GameData.MAX_ALERT_DURATION
    _alert_coord = ConvertCoord.get_coord(pc)


func _get_valid_ammo(new_ammo: int) -> int:
    return max(min(new_ammo, GameData.MAX_AMMO), GameData.MIN_AMMO)
