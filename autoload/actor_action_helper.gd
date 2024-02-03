# class_name ActorActionHelper
extends Node2D


signal searching_actor_action(search: SearchKeyword)


func hit_actor(sprite: Sprite2D) -> void:
    _get_actor_action().hit_actor(sprite)


func _get_actor_action() -> ActorAction:
    var search: SearchKeyword = SearchKeyword.new()
    searching_actor_action.emit(search)
    return search.actor_action
