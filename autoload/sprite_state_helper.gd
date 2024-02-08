# class_name SpriteStateHelper
extends Node2D


var _ref_SpriteState: SpriteState


func get_sprites_by_tag(main_tag: StringName, sub_tag: StringName) -> Array:
    return _ref_SpriteState.get_sprites_by_tag(main_tag, sub_tag)


func get_sprite_by_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> Sprite2D:
    return _ref_SpriteState.get_sprite_by_coord(main_tag, coord, z_layer)


func get_sprites_by_coord(coord: Vector2i) -> Array:
    return _ref_SpriteState.get_sprites_by_coord(coord)


func get_main_tag(sprite: Sprite2D) -> StringName:
    return _ref_SpriteState.get_main_tag(sprite)


func get_sub_tag(sprite: Sprite2D) -> StringName:
    return _ref_SpriteState.get_sub_tag(sprite)


func has_sprite_at_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> bool:
    return get_sprite_by_coord(main_tag, coord, z_layer) != null


func has_building_at_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.BUILDING)) -> bool:
    return has_sprite_at_coord(MainTag.BUILDING, coord, z_layer)


func has_trap_at_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.TRAP)) -> bool:
    return has_sprite_at_coord(MainTag.TRAP, coord, z_layer)


func has_actor_at_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.ACTOR)) -> bool:
    return has_sprite_at_coord(MainTag.ACTOR, coord, z_layer)


func get_building_by_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.BUILDING)) -> Sprite2D:
    return get_sprite_by_coord(MainTag.BUILDING, coord, z_layer)


func get_trap_by_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.TRAP)) -> Sprite2D:
    return get_sprite_by_coord(MainTag.TRAP, coord, z_layer)


func get_actor_by_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.ACTOR)) -> Sprite2D:
    return get_sprite_by_coord(MainTag.ACTOR, coord, z_layer)
