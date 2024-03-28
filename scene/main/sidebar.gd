class_name Sidebar
extends CustomMarginContainer


@onready var _ref_GameStateLabel: GameStateLabel = $SidebarVBox/GameStateLabel
@onready var _ref_FootnoteLabel: FootnoteLabel = $SidebarVBox/FootnoteLabel


func _ready() -> void:
    visible = false


func init_gui() -> void:
    _ref_GameStateLabel.init_label()
    _ref_FootnoteLabel.init_label()
    visible = true


func _on_Schedule_turn_started(sprite: Sprite2D) -> void:
    if sprite.is_in_group(SubTag.PC):
        _ref_GameStateLabel.update_label()


func _on_GameProgress_game_over(player_win: bool) -> void:
    _ref_GameStateLabel.game_over = true
    _ref_GameStateLabel.player_win = player_win
    _ref_GameStateLabel.update_label()


func _on_PlayerInput_action_pressed(input_tag: StringName) -> void:
    match input_tag:
        InputTag.CLOSE_MENU:
            visible = true
        InputTag.OPEN_DEBUG_MENU:
            visible = false
        InputTag.OPEN_HELP_MENU:
            visible = false
